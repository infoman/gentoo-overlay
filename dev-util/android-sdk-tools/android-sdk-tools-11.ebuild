# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Google Android SDK Tools"
HOMEPAGE="http://developer.android.com/"
SRC_URI="http://dl.google.com/android/android-sdk_r${PV}-linux_x86.tgz"
RESTRICT="mirror"

LICENSE="android"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jdk-1.5"

MY_TARGET="${EPREFIX}/opt/android-sdk"

src_install() {
	doicon "${FILESDIR}/android-sdk.svg"
	make_desktop_entry "${MY_TARGET}"/tools/android "Android SDK" android-sdk 'Application;Development;' || die

	dodir "${MY_TARGET}"
	mv android-sdk-linux_x86/* "${D}/${MY_TARGET}"
}
