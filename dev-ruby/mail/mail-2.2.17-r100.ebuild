# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19 ree18"

inherit ruby-fakegem

DESCRIPTION="Ruby Mail handler."
HOMEPAGE="http://github.com/mikel/mail"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "  >=dev-ruby/activesupport-2.3.6
                    >=dev-ruby/i18n-0.4.0
                    >=dev-ruby/mime-types-1.16 <dev-ruby/mime-types-2
                    >=dev-ruby/treetop-1.4.8 <dev-ruby/treetop-1.5"
