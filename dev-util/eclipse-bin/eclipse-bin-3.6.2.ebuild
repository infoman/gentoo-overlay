# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Eclipse Platform Runtime Binary"
HOMEPAGE="http://www.eclipse.org/"
URL_BASE="http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/eclipse/downloads/drops/R-3.6.2-201102101200/eclipse-platform-${PV}-linux-gtk"
SRC_URI="amd64? ( ${URL_BASE}-x86_64.tar.gz )
	x86? ( ${URL_BASE}.tar.gz )
	ppc? ( ${URL_BASE}-ppc.tar.gz )"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.5"

QA_PRESTRIPPED="opt/eclipse/libcairo-swt.so"

S="${WORKDIR}/eclipse"

src_install() {
	local destdir="/opt/eclipse"

	newicon plugins/org.eclipse.platform_*/eclipse48.png eclipse.png
	make_desktop_entry "${EPREFIX}"/usr/bin/eclipse "Eclipse" eclipse 'Application;Development;' || die

	insinto "${destdir}"
	doins -r configuration features p2 plugins artifacts.xml eclipse.ini libcairo-swt.so .eclipseproduct || die
	exeinto "${destdir}"
	doexe eclipse || die
	
	dosym "${destdir}/eclipse" "${DESTTREE}/bin/eclipse" || die
}

