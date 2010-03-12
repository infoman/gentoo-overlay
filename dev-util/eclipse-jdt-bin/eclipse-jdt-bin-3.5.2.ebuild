# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_P="eclipse-JDT-${PV}"

DESCRIPTION="Eclipse Java Development Tools Binary"
HOMEPAGE="http://www.eclipse.org/jdt/"
SRC_URI="http://download.eclipse.org/eclipse/downloads/drops/R-3.5.2-201002111343/${MY_P}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="=dev-util/eclipse-bin-${PV}"

S="${WORKDIR}/eclipse"

ECLIPSE_DIR="/opt/eclipse"

src_install() {
	insinto "${ECLIPSE_DIR}"
	doins -r binary
	doins -r features
	doins -r plugins
}
