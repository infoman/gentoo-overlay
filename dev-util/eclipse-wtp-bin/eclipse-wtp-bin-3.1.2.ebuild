# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_P="wtp-R-3.1.2-20100211202452"

DESCRIPTION="Eclipse Java Development Tools Binary"
HOMEPAGE="http://www.eclipse.org/jdt/"
SRC_URI="http://download.eclipse.org/webtools/downloads/drops/R3.1.2/R-3.1.2-20100211202452/${MY_P}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="dev-util/eclipse-bin"

S="${WORKDIR}/eclipse"

ECLIPSE_DIR="/opt/eclipse"

src_install() {
	insinto "${ECLIPSE_DIR}"
	rm -f plugins/org.apache.commons.codec_1.3.0.v20080530-1600.jar
	rm -f plugins/org.apache.commons.logging_1.0.4.v200904062259.jar
	doins -r features
	doins -r plugins
}
