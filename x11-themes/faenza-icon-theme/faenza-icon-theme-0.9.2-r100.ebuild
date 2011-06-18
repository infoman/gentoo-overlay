# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/faenza-icon-theme/faenza-icon-theme-0.9.2-r1.ebuild,v 1.1 2011/06/01 11:33:15 hwoarang Exp $

EAPI="4"

inherit gnome2-utils

DESCRIPTION="A scalable icon theme called Faenza"
HOMEPAGE="http://code.google.com/p/faenza-icon-theme/"
SRC_URI="http://faenza-icon-theme.googlecode.com/files/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( x11-themes/gnome-icon-theme )
	x11-themes/hicolor-icon-theme"

RESTRICT="binchecks strip"

S=${WORKDIR}

src_prepare() {
	for x in Faenza Faenza-Dark; do
		for res in 22 24 32 48; do
			pushd "${x}/places/${res}"
				ln -sf start-here-gentoo.png start-here.png || die
			popd
		done
		pushd "${x}/places/scalable"
			ln -sf start-here-gentoo.svg start-here.svg || die
		popd
	done
	for res in 22 24 32 48; do
		pushd "Faenza/apps/${res}"
			ln -s logviewer.png logview.png || die
			ln -s guake.png sandbox.png || die
			ln -s config-date.png preferences-system-time.png || die
			ln -s ../../places/${res}/user-desktop.png preferences-desktop-wallpaper.png || die
		popd
	done
	pushd "Faenza/apps/scalable"
		ln -s logviewer.svg logview.svg || die
		ln -s guake.svg sandbox.svg || die
		ln -s config-date.svg preferences-system-time.svg || die
		ln -s ../../places/scalable/user-desktop.svg preferences-desktop-wallpaper.svg || die
	popd
	for res in 22 24 32 48; do
		pushd "Faenza/status/${res}"
			ln -s ../../devices/${res}/battery.png battery-good-charging.png || die
		popd
	done
	pushd "Faenza/status/scalable"
		ln -s ../../devices/scalable/battery.svg battery-good-charging.svg || die
	popd
}

src_install() {
	insinto /usr/share/icons
	doins -r Faenza{,-Dark,-Darker,-Darkest} || die

	dodoc AUTHORS ChangeLog README
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
