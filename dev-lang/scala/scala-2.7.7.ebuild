# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit java-pkg-2

MY_P="${P}.final"

DESCRIPTION="The Scala Programming Language"
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="http://www.scala-lang.org/downloads/distrib/files/${MY_P}.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="sourceview"

DEPEND=""
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${MY_P}"

my_dolauncher() {
	java-pkg_dolauncher "${1}" --main "${2}" \
		--java_args "-Xmx256M -Xms32M -Dscala.home=${JAVA_PKG_SHAREPATH} -Denv.classpath="
}

src_install() {
	java-pkg_dojar lib/scala-*.jar

	doman man/man1/{fsc,scala,scalac,scaladoc}.1

	insinto /usr/share/mime/packages
	doins "${FILESDIR}/scala.xml"

	if use sourceview; then
		insinto /usr/share/gtksourceview-2.0/language-specs
		doins misc/scala-tool-support/gedit/scala.lang
	fi

	my_dolauncher fsc scala.tools.nsc.CompileClient
	my_dolauncher scala scala.tools.nsc.MainGenericRunner
	my_dolauncher scalac scala.tools.nsc.Main
	my_dolauncher scaladoc scala.tools.nsc.ScalaDoc
}

pkg_postinst() {
	update-mime-database "${ROOT}/usr/share/mime"
}

pkg_postrm() {
	update-mime-database "${ROOT}/usr/share/mime"
}

