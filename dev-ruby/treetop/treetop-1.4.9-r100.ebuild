# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19 ree18"

inherit ruby-fakegem

DESCRIPTION="Text parsing and interpretation DSL."
HOMEPAGE="http://functionalform.blogspot.com/"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "  >=dev-ruby/polyglot-0.3.1"
