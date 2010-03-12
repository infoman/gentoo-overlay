# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit subversion toolchain-funcs

DESCRIPTION="gedit class browser plugin"
HOMEPAGE="http://www.stambouliote.de/projects/gedit_plugins.html"
SRC_URI=""
ESVN_REPO_URI="http://geditclassbrowser.googlecode.com/svn/trunk"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-editors/gedit"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/$(get_libdir)/gedit-2/plugins
	doins classbrowser.gedit-plugin
	doins -r classbrowser
}
