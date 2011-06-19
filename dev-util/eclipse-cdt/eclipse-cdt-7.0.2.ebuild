# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="C/C++ Development Tooling plugin for the Eclipse IDE"
HOMEPAGE="http://www.eclipse.org/cdt/"
SRC_URI="http://download.eclipse.org/tools/cdt/releases/helios/dist/cdt-master-${PV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-util/eclipse"

src_install() {
	local destdir="/opt/eclipse"

	insinto ${destdir}/features
	doins -r features/* || die
	
	insinto ${destdir}/plugins
	doins -r plugins/* || die
}
