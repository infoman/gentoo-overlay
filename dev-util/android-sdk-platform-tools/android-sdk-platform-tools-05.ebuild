# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Google Android SDK Platform Tools"
HOMEPAGE="http://developer.android.com/"
SRC_URI="http://dl.google.com/android/repository/platform-tools_r${PV}-linux.zip"
RESTRICT="mirror"

LICENSE="android"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/android-sdk-tools"

MY_TARGET="${EPREFIX}/opt/android-sdk"

src_install() {
	dodir "${MY_TARGET}"
	mv platform-tools_r${PV}-linux "${D}/${MY_TARGET}/platform-tools"
}
