# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A utility for creating and editing GtkSourceView2 style schemes"
HOMEPAGE="http://www.dabj01.co.cc/page4.php"
SRC_URI="http://www.dabj01.co.cc/downloads/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-cpp/gtksourceviewmm"
RDEPEND="${DEPEND}"

src_install() {
	sed -i 's/gksu //g' src/badschemer.desktop
	emake DESTDIR="${D}" install
}
