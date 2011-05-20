# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19 ree18"

inherit ruby-fakegem

DESCRIPTION="Rails internal libraries."
HOMEPAGE="http://rubyonrails.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "  ~dev-ruby/actionpack-${PV}
                    ~dev-ruby/activesupport-${PV}
                    >=dev-ruby/rake-0.8.7
                    >=dev-ruby/thor-0.14.4 <dev-ruby/thor-0.15"
