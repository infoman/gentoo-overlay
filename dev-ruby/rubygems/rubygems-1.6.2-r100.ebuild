# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby19"

inherit ruby-ng prefix

DESCRIPTION="Centralized Ruby extension management system"
HOMEPAGE="http://rubyforge.org/projects/rubygems/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="|| ( Ruby GPL-2 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="ruby_targets_ruby19? ( >=dev-lang/ruby-1.9.2 )"
RDEPEND="${DEPEND}"

each_ruby_compile() {
	# change bin/gem interpreter to versioned ruby
	sed -i -e 's:#!.*:#!'"${RUBY}"':' bin/gem
}

each_ruby_install() {
	unset RUBYOPT

	doruby -r lib/*

	newbin bin/gem $(basename ${RUBY} | sed -e 's:ruby:gem:') || die
}

pkg_postinst() {
	if [[ ! -n $(readlink "${ROOT}"usr/bin/gem) ]] ; then
		eselect ruby set $(eselect --brief --no-color ruby show | head -n1)
	fi
}

pkg_postrm() {
	eselect ruby cleanup
}

