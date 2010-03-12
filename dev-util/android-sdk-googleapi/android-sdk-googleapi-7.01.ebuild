# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator

if [ "${PV}" == "3.03" ]; then MY_P="google_apis-3-r03"
else MY_P="google_apis-$(replace_version_separator 1 _r)"
fi

DESCRIPTION="Google Android SDK Google API"
HOMEPAGE="http://developer.android.com/"
SRC_URI="http://dl.google.com/android/repository/${MY_P}.zip"
RESTRICT="mirror"

LICENSE="android"
SLOT="$(get_major_version)"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-util/android-sdk-platform"

S="${WORKDIR}/${MY_P}"

ANDROID_ADDONS_DIR="/opt/android-sdk/add-ons"

src_install() {
	insinto ${ANDROID_ADDONS_DIR}/google_apis_${SLOT}
	doins -r *
}
