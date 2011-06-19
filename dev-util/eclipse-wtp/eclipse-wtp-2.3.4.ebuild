# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Web Tools Platform plugin for the Eclipse IDE"
HOMEPAGE="http://www.eclipse.org/webtools/"
SRC_URI="http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/webtools/downloads/drops/R3.2.4/R-3.2.4-20110511033327/wtp-R-3.2.4-20110511033327.zip"

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
	rm eclipse/plugins/org.apache.commons.logging_*.jar
	rm eclipse/plugins/org.apache.commons.codec_*.jar
	doins -r eclipse/plugins/* || die
}
