# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="Fast implementation of eRuby."
HOMEPAGE="http://www.kuwata-lab.com/erubis/"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

ruby_add_rdepend "  >=dev-ruby/abstract-1.0.0"
