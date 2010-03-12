# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils mono gnome2 bzr

DESCRIPTION="Docky is an advanced shortcut bar"
HOMEPAGE="http://www.go-docky.com/"
EBZR_REPO_URI="lp:docky"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/gconf-sharp-2.24.0
	>=dev-dotnet/gtk-sharp-2.12.6
	>=dev-dotnet/glade-sharp-2.12.6
	dev-dotnet/dbus-sharp
	dev-dotnet/dbus-glib-sharp
	>=dev-dotnet/gnome-desktop-sharp-2.24.0
	>=dev-dotnet/gnome-keyring-sharp-1.0.0
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gnomevfs-sharp-2.24.0
	>=dev-dotnet/wnck-sharp-2.24.0
	>=dev-dotnet/art-sharp-2.24.0
	>=dev-dotnet/rsvg-sharp-2.24.0
	dev-dotnet/mono-addins[gtk]
	dev-dotnet/notify-sharp"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	./autogen.sh --prefix=/usr --enable-debug=no --enable-release=yes \
		 || die "configure failed"
}
