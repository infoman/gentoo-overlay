# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19 ree18"

inherit ruby-fakegem

DESCRIPTION="Web apps on Rails."
HOMEPAGE="http://rubyonrails.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "  ~dev-ruby/activemodel-${PV}
                    ~dev-ruby/activesupport-${PV}
                    >=dev-ruby/builder-2.1.2 <dev-ruby/builder-2.2
                    >=dev-ruby/erubis-2.6.6 <dev-ruby/erubis-2.7
                    >=dev-ruby/i18n-0.4 <dev-ruby/i18n-1
                    >=dev-ruby/rack-1.2.1 <dev-ruby/rack-1.3
                    >=dev-ruby/rack-mount-0.6.13 <dev-ruby/rack-mount-0.7
                    >=dev-ruby/rack-test-0.5.7 <dev-ruby/rack-test-0.6
                    >=dev-ruby/tzinfo-0.3.23 <dev-ruby/tzinfo-0.4"
