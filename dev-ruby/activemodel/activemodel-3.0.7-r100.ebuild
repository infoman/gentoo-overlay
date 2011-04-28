# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="Toolkit for building modeling frameworks like Active Record and Active Resource"
HOMEPAGE="http://rubyonrails.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "  ~dev-ruby/activesupport-${PV}
                    >=dev-ruby/builder-2.1.2 <dev-ruby/builder-2.2
                    >=dev-ruby/i18n-0.4 <dev-ruby/i18n-1"
