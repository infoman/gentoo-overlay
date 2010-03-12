# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

MY_P="android-sdk_r0${PV}-linux_86"

DESCRIPTION="Google Android SDK Tools"
HOMEPAGE="http://developer.android.com/"
SRC_URI="http://dl.google.com/android/${MY_P}.tgz"
RESTRICT="mirror"

LICENSE="android"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/android-sdk-linux_86"

ANDROID_SDK_DIR="/opt/android-sdk"

src_install() {
	newicon "${FILESDIR}/android-icon.png" android-icon.png
	domenu "${FILESDIR}/android-sdk.desktop"

	dodir "${ANDROID_SDK_DIR}/"{add-ons,platforms}

	insinto "${ANDROID_SDK_DIR}/tools"
	doins -r tools/lib
	doins tools/source.properties
	rm -rf tools/lib
	rm -f tools/NOTICE.txt
	rm -f tools/source.properties

	exeinto "${ANDROID_SDK_DIR}/tools"
	doexe tools/*

	echo "PATH=\"${ANDROID_SDK_DIR}/tools\"" > "${T}/80${PN}"
	doenvd "${T}/80${PN}"
}
