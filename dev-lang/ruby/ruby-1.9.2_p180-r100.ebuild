# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator multilib

MY_P="${PN}-$(replace_version_separator 3 '-')"

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/${MY_P}.tar.bz2"

LICENSE="|| ( Ruby GPL-2 )"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64"
IUSE="doc gem"

DEPEND=">=app-admin/eselect-ruby-20100603"
RDEPEND="${DEPEND}"
PDEPEND="gem? ( >=dev-ruby/rubygems-1.6.2 )"

S="${WORKDIR}/${MY_P}"
MY_SUFFIX=$(delete_version_separator 1 ${SLOT})
RUBYVERSION=1.9.1

src_prepare() {
	# remove conflicting execs
	rm -r bin/{gem,rdoc,ri} || die

	# remove bundled gems
	#rm -r bin/{gem,testrb} || die
	#rm -r {bin,man}/ri* || die
	#rm -r {ext,lib}/racc* || die
	#rm -r ext/json || die
}

src_configure() {
	local myconf=

	econf	--program-suffix=${MY_SUFFIX} \
			--with-soname=ruby${MY_SUFFIX} \
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

	# remove bundled gems
	rm -r "${D}/usr/$(get_libdir)/ruby/gems" || die

	# remove bundled gems
	#rm -r "${D}/usr/$(get_libdir)/ruby/${RUBYVERSION}"/{,r}ubygems* || die
	#rm -r "${D}/usr/"{bin,"$(get_libdir)/ruby/${RUBYVERSION}"}/rdoc* || die
	#rm -r "${D}/usr/"{bin,share/man/man1,"$(get_libdir)/ruby/${RUBYVERSION}"}/rake* || die
	#rm -r "${D}/usr/$(get_libdir)/ruby/${RUBYVERSION}"/{,mini}test* || die
	#rm -r "${D}/usr/$(get_libdir)/ruby/gems" || die

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

