# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="A complete, multi-colored suite of themes and icons for Linux"
HOMEPAGE="http://code.google.com/p/gnome-colors/downloads/list"
SRC_URI="http://gnome-colors.googlecode.com/files/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	DESTDIR=$D emake install
}
