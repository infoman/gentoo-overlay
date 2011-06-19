# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Java Development Tooling plugin for the Eclipse IDE"
HOMEPAGE="http://www.eclipse.org/jdt/"
SRC_URI="http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/eclipse/downloads/drops/R-3.6.2-201102101200/org.eclipse.jdt-${PV}.zip"

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

