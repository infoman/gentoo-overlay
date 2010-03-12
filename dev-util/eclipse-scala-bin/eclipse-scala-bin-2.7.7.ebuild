# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Eclipse Scala IDE Plugin Binary"
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="http://www.scala-lang.org/sites/default/files/linuxsoft_archives/downloads/distrib/files/ch.epfl.lamp.sdt_${PV}.final.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="dev-util/eclipse-jdt-bin"

S="${WORKDIR}"

ECLIPSE_DIR="/opt/eclipse"

src_install() {
	insinto "${ECLIPSE_DIR}"
	doins -r features
	doins -r plugins
}
