# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git

DESCRIPTION="gedit smart indent plugin from gmate"
HOMEPAGE="http://blog.siverti.com.br/gmate/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/lexrupy/gmate.git"
EGIT_PROJECT="gmate"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-editors/gedit"
RDEPEND="${DEPEND}"

src_prepare() {
	# fix missing gtk.glade import
	sed -i 's/import gtk/import gtk\nimport gtk.glade/g' \
		${S}/plugins/smart_indent/__init__.py
}

src_install() {
	insinto /usr/$(get_libdir)/gedit-2/plugins
	doins -r plugins/smart_indent*
}
