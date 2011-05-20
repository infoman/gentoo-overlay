# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19 ree18"

inherit ruby-fakegem

DESCRIPTION="A full-stack web framework."
HOMEPAGE="http://rubyonrails.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sqlite"

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "	~dev-ruby/actionmailer-${PV}
					~dev-ruby/actionpack-${PV}
					~dev-ruby/activerecord-${PV}
					~dev-ruby/activeresource-${PV}
					~dev-ruby/activesupport-${PV}
					>=dev-ruby/bundler-1.0 <dev-ruby/bundler-2
					~dev-ruby/railties-${PV}
					sqlite? ( >=dev-ruby/sqlite3-1.3.3 )"
