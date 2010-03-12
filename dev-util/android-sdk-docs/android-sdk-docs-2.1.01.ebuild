# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator

MY_P="docs-$(replace_version_separator $(get_last_version_component_index) _r)-linux"

DESCRIPTION="Google Android SDK Docs"
HOMEPAGE="http://developer.android.com/sdk/"
SRC_URI="http://dl.google.com/android/repository/${MY_P}.zip"
RESTRICT="mirror"

LICENSE="android"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/android-sdk-tools"

S="${WORKDIR}/${MY_P}"

ANDROID_DOCS_DIR="/opt/android-sdk/docs"

src_install() {
	insinto "${ANDROID_DOCS_DIR}"
	doins -r *
}
