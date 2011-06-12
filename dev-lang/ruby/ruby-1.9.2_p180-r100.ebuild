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
IUSE="debug doc ipv6 berkdb gdbm ncurses readline ssl tk yaml +minimal core_source"

DEPEND=">=app-admin/eselect-ruby-20100603
	berkdb? ( sys-libs/db )
	gdbm? ( sys-libs/gdbm )
   	ncurses? ( sys-libs/ncurses )
	readline?  ( sys-libs/readline )
    ssl? ( dev-libs/openssl )
    tk? ( dev-lang/tk[threads] )
	yaml? ( dev-libs/libyaml )
	sys-libs/zlib"
RDEPEND="${DEPEND}"

MY_SUFFIX=$(delete_version_separator 1 ${SLOT})
RUBYVERSION=1.9.1
S="${WORKDIR}/${MY_P}"

src_prepare() {
	# stop gem rbinstall step from running
	sed -i -e "s/install?(:ext, :comm, :gem) do/if false/" tool/rbinstall.rb

	# remove conflicting bin and man
	rm -r bin/{gem,rake} man/{rake,ri}.1 || die

	# remove bundled gems not needed for compile
	if use minimal; then
		rm -r ext/json lib/rake* || die
	fi
}

src_configure() {
	local myconf=

	econf	--program-suffix=${MY_SUFFIX} \
			--with-soname=ruby${MY_SUFFIX} \
			--enable-shared \
			$(use_enable debug) \
			$(use_enable doc install-doc) \
			--enable-option-checking=no \
			$(use_enable ipv6) \
			$(use_with berkdb dbm) \
			$(use_with gdbm) \
			$(use_with ncurses curses) \
			$(use_with readline) \
			$(use_with ssl openssl) \
			$(use_with tk) \
			$(use_with yaml psych) \
			|| die
}

src_compile() {
	emake || die
}

src_install() {
	unset RUBYOPT

	emake DESTDIR="${D}" install || die

	# remove remaining bins
	rm -r "${D}/usr/bin/"{rdoc,ri}"${MY_SUFFIX}" || die

	# remove remaining bundled gems
	if use minimal; then
		rm -r "${D}/usr/$(get_libdir)/ruby/${RUBYVERSION}/"{rdoc,{,r}ubygems}* || die
	fi

	dosym "libruby${MY_SUFFIX}$(get_libname ${PV%_*})" \
		"/usr/$(get_libdir)/libruby$(get_libname ${PV%.*})"
	dosym "libruby${MY_SUFFIX}$(get_libname ${PV%_*})" \
		"/usr/$(get_libdir)/libruby$(get_libname ${PV%_*})"

	# install internal headers for ruby-debug and similar
	if use core_source; then
		insinto /usr/include/${PN}-${RUBYVERSION}
		doins *.h *.inc || die
	fi

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

