# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator

MY_P="android-$(replace_version_separator $(get_last_version_component_index) _r)-linux"
if [ "${PV}" == "1.5.03" ]; then MY_P+="_x86"; fi

DESCRIPTION="Google Android SDK Platform"
HOMEPAGE="http://developer.android.com/sdk/"
SRC_URI="http://dl.google.com/android/repository/${MY_P}.zip"
RESTRICT="mirror"

LICENSE="android"
SLOT="$(get_version_component_range 1-$(get_last_version_component_index))"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-util/android-sdk-tools"

if [ "${SLOT}" \< "1.6" ]
	then MY_SOURCE="${WORKDIR}/android-${SLOT}"
	else MY_SOURCE="${WORKDIR}/${MY_P}"
fi

MY_TARGET="${EPREFIX}/opt/android-sdk/platforms"

src_install() {
	dodir "${MY_TARGET}"
	mv "${MY_SOURCE}" "${D}/${MY_TARGET}/android_${SLOT}"
}
