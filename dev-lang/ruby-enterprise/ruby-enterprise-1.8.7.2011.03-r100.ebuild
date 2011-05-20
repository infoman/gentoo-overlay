# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator multilib

MY_P="${PN}-$(replace_version_separator 3 '-')"

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="http://rubyenterpriseedition.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="|| ( Ruby GPL-2 )"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64"
IUSE="doc gem"

DEPEND=">=app-admin/eselect-ruby-20100603"
RDEPEND="${DEPEND}"
PDEPEND="gem? ( >=dev-ruby/rubygems-1.6.2 )"

S="${WORKDIR}/${MY_P}/source"
MY_SUFFIX=ee$(delete_version_separator 1 ${SLOT})
RUBYVERSION=$(get_version_component_range 1-2)

src_prepare() {
	# remove conflicting execs
	rm -r bin/{rdoc,ri} || die

	# fix lib path
	sed -i -e "s:\(CONFIG\[\"rubylibdir\"\] = \"\\\$(libdir)/ruby\):\1ee:" \
		mkconfig.rb || die
	sed -i -e "s:\(RUBY_LIB_PREFIX=\`eval echo \\\\\\\\\"\${libdir}/ruby\):\1ee:" \
		configure.in || die
}

src_configure() {
	local myconf=

	econf	--program-suffix=${MY_SUFFIX} \
			--with-sitedir=/usr/$(get_libdir)/rubyee/site_ruby \
			--with-vendordir=/usr/$(get_libdir)/rubyee/vendor_ruby \
			--enable-shared \
			--enable-pthread \
			$(use_enable doc install-doc)
r
}

src_compile() {
	emake || die
}

src_install() {
	unset RUBYOPT

	emake DESTDIR="${D}" install || die

	dosym "libruby${MY_SUFFIX}$(get_libname ${PV%_*})" \
		"/usr/$(get_libdir)/libruby$(get_libname ${PV%.*})"
	dosym "libruby${MY_SUFFIX}$(get_libname ${PV%_*})" \
		"/usr/$(get_libdir)/libruby$(get_libname ${PV%_*})"

	dodoc ChangeLog NEWS doc/NEWS-* README* ToDo || die
}

pkg_postinst() {
	if [[ ! -n $(readlink "${ROOT}"usr/bin/ruby) ]] ; then
		eselect ruby set ruby${MY_SUFFIX}
	fi
}

pkg_postrm() {
	eselect ruby cleanup
}

