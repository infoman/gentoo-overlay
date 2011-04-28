# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="Easy and robust Ruby web application deployment"
HOMEPAGE="http://www.modrails.com/"
SRC_URI="mirror://rubyforge/passenger/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "
    dev-ruby/rack
    >=dev-ruby/daemon_controller-0.2.5
    >=dev-ruby/fastthread-1.0.1
    >=dev-ruby/rake-0.8.1"

all_ruby_prepare() {
	rm bin/passenger-{install-{apache2,nginx}-module,make-enterprisey}
}

each_ruby_configure() {
	${RUBY} -Cext/ruby extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/ruby || die
	mv ext/ruby/passenger_native_support.so lib/ || die
}
