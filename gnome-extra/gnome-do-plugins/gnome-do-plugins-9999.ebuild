# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils mono gnome2 bzr

DESCRIPTION="Plugins to put the Do in Gnome Do"
HOMEPAGE="http://do.davebsd.com/"
EBZR_REPO_URI="lp:do-plugins"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=gnome-extra/gnome-do-9999
		dev-dotnet/wnck-sharp"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	./autogen.sh --prefix=/usr --enable-debug=no --enable-release=yes \
		 || die "configure failed"
}

