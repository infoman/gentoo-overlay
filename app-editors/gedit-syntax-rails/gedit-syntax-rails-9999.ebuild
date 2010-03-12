# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git

DESCRIPTION="gedit syntax files and auto typesetter for Ruby on Rails from gmate"
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
	# fix inconsitant naming
	mv ${S}/lang-specs/ruby_on_rails.lang ${S}/lang-specs/rubyonrails.lang
	mv ${S}/mime/rails.xml ${S}/mime/rubyonrails.xml
}

src_install() {
	insinto /usr/$(get_libdir)/gedit-2/plugins
	doins plugins/rubyonrailsloader*

	insinto /usr/share/gtksourceview-2.0/language-specs
	doins lang-specs/{rhtml,rubyonrails,yml}.lang

	insinto /usr/share/mime/packages
	doins mime/rubyonrails.xml
}

pkg_postinst() {
	update-mime-database /usr/share/mime
}

pkg_postrm() {
	update-mime-database /usr/share/mime
}
