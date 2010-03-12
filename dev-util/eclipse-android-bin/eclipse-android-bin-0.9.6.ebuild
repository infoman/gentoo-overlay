# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_P="ADT-${PV}"

DESCRIPTION="Eclipse Google Android IDE Plugin Binary"
HOMEPAGE="http://developer.android.com/sdk/eclipse-adt.html"
SRC_URI="http://dl.google.com/android/${MY_P}.zip"
RESTRICT="mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/eclipse-bin
	dev-util/android-sdk-bin"

S="${WORKDIR}"

ECLIPSE_DIR="/opt/eclipse"

src_install() {
	insinto "${ECLIPSE_DIR}"
	doins -r features
	doins -r plugins
}
