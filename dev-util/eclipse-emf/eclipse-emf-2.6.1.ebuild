# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Eclipse Modeling Framework plugin for the Eclipse IDE"
HOMEPAGE="http://www.eclipse.org/modeling/emf/"
SRC_URI="http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/modeling/emf/emf/downloads/drops/2.6.x/R201009141218/emf-runtime-${PV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-util/eclipse"

src_install() {
	local destdir="/opt/eclipse"

	insinto ${destdir}/features
	doins -r eclipse/features/* || die
	
	insinto ${destdir}/plugins
	doins -r eclipse/plugins/* || die
}
