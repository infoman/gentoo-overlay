# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Android Development Tools plugin for the Eclipse IDE"
HOMEPAGE="http://developer.android.com/sdk/eclipse-adt.html"
SRC_URI="http://dl.google.com/android/ADT-${PV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-util/eclipse
	dev-util/eclipse-emf
	dev-util/eclipse-gef
	dev-util/eclipse-jdt
	dev-util/eclipse-wtp
	dev-util/android-sdk-tools"

src_install() {
	local destdir="/opt/eclipse"

	insinto ${destdir}/features
	doins -r features/* || die
	
	insinto ${destdir}/plugins
	doins -r plugins/* || die
}

