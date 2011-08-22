# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="The world's leading IDE for building open web applications"
HOMEPAGE="http://www.aptana.com"
SRC_URI="x86? ( http://download.aptana.com/studio3/standalone/${PV}/linux/Aptana_Studio_3_Setup_Linux_x86_${PV}.zip )
	amd64? ( http://download.aptana.com/studio3/standalone/${PV}/linux/Aptana_Studio_3_Setup_Linux_x86_64_${PV}.zip )"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
EAPI=2

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.5
   || ( >=net-libs/xulrunner-1.8 net-libs/xulrunner:1.8 )
   dev-libs/expat"

src_install() {
	einfo "Installing Aptana ${PV}"
	dodir "/opt/${PN}"
	local dest="${D}/opt/${PN}"
	cd "${WORKDIR}/Aptana Studio 3/"
	cp -pPR about_files/ configuration/ features/ plugins/ "${dest}" || die "Failed to install Files"
	strip -s libcairo-swt.so
	insinto "/opt/${PN}"
	doins libcairo-swt.so about.html AptanaStudio3.ini full_uninstall.txt version.txt
	exeinto "/opt/${PN}"
	doexe AptanaStudio3

	dodir /opt/bin
	echo "#!/bin/sh" > ${T}/AptanaStudio3
	if [ -x /opt/xulrunner ]; then
		echo "export MOZILLA_FIVE_HOME=/opt/xulrunner" >> ${T}/AptanaStudio3
	else
		echo "export MOZILLA_FIVE_HOME=/usr/lib/xulrunner" >> ${T}/AptanaStudio3
	fi
	echo "/opt/${PN}/AptanaStudio3" >> ${T}/AptanaStudio3
	dobin ${T}/AptanaStudio3

	newicon "plugins/com.aptana.branding_${PV}.*/studio32.gif" "AptanaStudio.png"
	make_desktop_entry "AptanaStudio3" "Aptana Studio" AptanaStudio "Development"
}
