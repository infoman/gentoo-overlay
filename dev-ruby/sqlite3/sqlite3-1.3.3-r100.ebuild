# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="SQLite3 database engine Ruby interface."
HOMEPAGE="http://github.com/luislavena/sqlite3-ruby"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="=dev-db/sqlite-3*"
RDEPEND="${DEPEND}"

each_ruby_configure() {
	${RUBY} -Cext/sqlite3 extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/sqlite3 || die
	mv ext/sqlite3/sqlite3_native$(get_modname) lib/sqlite3/ || die
}
