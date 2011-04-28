# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19"

inherit flag-o-matic ruby-ng

DESCRIPTION="Easy and robust Ruby web application deployment"
HOMEPAGE="http://www.modrails.com/"
SRC_URI="mirror://rubyforge/passenger/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="apache nginx"

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "
    dev-ruby/rack
    >=dev-ruby/daemon_controller-0.2.5
    >=dev-ruby/fastthread-1.0.1
    >=dev-ruby/rake-0.8.1"

all_ruby_prepare() {
	#rm bin/passenger-{install-{apache2,nginx}-module,make-enterprisey}

	# use CXXFLAGS, LDFLAGS and DISTDIR
	sed -i -e "s:OPTIMIZE = boolean_option(\"OPTIMIZE\"):OPTIMIZE = true:" \
		-e "s:OPTIMIZATION_FLAGS = \"#{PlatformInfo.debugging_cflags} -O2 -DBOOST_DISABLE_ASSERTS\".strip:OPTIMIZATION_FLAGS = \"#{ENV['CXXFLAGS']}\":" \
		-e "s:EXTRA_LDFLAGS  = \"\":EXTRA_LDFLAGS  = \"#{ENV['LDFLAGS']}\":" \
		build/config.rb
	sed -i -e "s:fakeroot = \"pkg/fakeroot\":fakeroot = ENV['DISTDIR']:" \
		build/packaging.rb

	# fix hardcoded paths
	sed -i -e "s:#{fakeroot}/usr/lib/ruby/:#{fakeroot}/#{CONFIG['sitedir']}/:" \
		 build/packaging.rb
	sed -i -e "s:/usr/share/doc/phusion-passenger:/usr/share/doc/${P}:" \
		-e "s:/usr/lib/apache2/modules/mod_passenger.so:${APACHE_MODULESDIR}/mod_passenger.so:" \
		-e "s:/usr/lib/phusion-passenger/agents:/usr/libexec/phusion-passenger/agents:" \
		lib/phusion_passenger.rb || die
	sed -i -e "s:/usr/lib/phusion-passenger/agents:/usr/libexec/phusion-passenger/agents:" \
		ext/common/ResourceLocator.h || die

	# remove fakeroot task deps to prevents double building
	sed -i -e "s/task :fakeroot => \[:apache2, :nginx\] +/task :fakeroot =>/" \
		build/packaging.rb || die

	# don't install the installer scripts
	for f in passenger{,-install-{apache2,nginx}-module,-make-enterprisey}; do
		sed -i -e "/'${f}'/d" \
			lib/phusion_passenger/packaging.rb || die
		rm -f bin/${f} || die
	done

	# don't install the darn sources
	sed -i -e "/sh \"mkdir -p #{fake_source_root}\"/,/^\tend/d" \
		 build/packaging.rb || die

	# remove apache2 build steps
	if ! use apache; then
		sed -i -e "/sh \"mkdir -p #{fake_apache2_module_dir}\"/d" \
			-e "/sh \"cp #{APACHE2_MODULE} #{fake_apache2_module_dir}\/\"/d" \
			build/packaging.rb || die
	fi
}

each_ruby_compile() {
	append-flags -fno-strict-aliasing

	if use nginx; then
		rake nginx || die
	fi

	if use apache; then
		rake apache || die
	fi
}

each_ruby_install() {
	DISTDIR="${D}" rake fakeroot || die
}

