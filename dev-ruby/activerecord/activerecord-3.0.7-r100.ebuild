# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19 ree18"

inherit ruby-fakegem

DESCRIPTION="Databases on Rails."
HOMEPAGE="http://rubyonrails.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "  ~dev-ruby/activemodel-${PV}
                    ~dev-ruby/activesupport-${PV}
                    >=dev-ruby/arel-2.0.2 <dev-ruby/arel-2.1
                    >=dev-ruby/tzinfo-0.3.23 <dev-ruby/tzinfo-0.4"
