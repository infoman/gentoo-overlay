# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

if use ppc; then MY_ARCH="ppc"
elif use x86; then MY_ARCH="x86"
elif use amd64; then MY_ARCH="x86_64"
fi

MY_P="eclipse-platform-${PV}-linux-gtk-${MY_ARCH}"

DESCRIPTION="Eclipse Platform Runtime Binary"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/eclipse/downloads/drops/R-3.5.2-201002111343/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/eclipse"

ECLIPSE_DIR="/opt/eclipse"

QA_PRESTRIPPED="opt/eclipse/libcairo-swt.so"

src_install() {
	newicon plugins/org.eclipse.platform_*/eclipse48.png eclipse-icon.png
	domenu "${FILESDIR}/${PN}.desktop"

	insinto "${ECLIPSE_DIR}"
	doins -r configuration
	doins -r features
	doins -r p2
	doins -r plugins
	doins artifacts.xml
	doins eclipse.ini
	doins libcairo-swt.so
	exeinto "${ECLIPSE_DIR}"
	doexe eclipse
	
	dosym "${ECLIPSE_DIR}/eclipse" "${DESTTREE}/bin/eclipse"
}
