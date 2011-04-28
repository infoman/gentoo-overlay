# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils ssl-cert toolchain-funcs perl-module flag-o-matic

MODULE_PASSENGER_P="passenger-3.0.7"

DESCRIPTION="Robust, small and high performance http and reverse proxy server"
HOMEPAGE="http://nginx.net/"
SRC_URI="http://sysoev.ru/nginx/${P}.tar.gz \
	nginx_modules_http_passenger? ( mirror://rubyforge/passenger/${MODULE_PASSENGER_P}.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +http +http-cache ipv6 +pcre ssl"

# list of modules dumped from configure --help
NGINX_MODULES_HTTP_STD="charset gzip ssi userid access auth_basic autoindex geo map referer rewrite proxy fastcgi memcached limit_zone limit_req empty_gif browser upstream_ip_hash"
NGINX_MODULES_HTTP_OPT="realip addition xslt image_filter geoip sub dav flv gzip_static random_index secure_link stub_status perl"
NGINX_MODULES_HTTP_3RD="passenger"
NGINX_MODULES_MAIL_OPT="imap pop3 smtp"

for module in $NGINX_MODULES_HTTP_STD; do
	IUSE="${IUSE} +nginx_modules_http_${module}"
done

for module in $NGINX_MODULES_HTTP_OPT; do
	IUSE="${IUSE} nginx_modules_http_${module}"
done

for module in $NGINX_MODULES_HTTP_3RD; do
	IUSE="${IUSE} nginx_modules_http_${module}"
done

for module in $NGINX_MODULES_MAIL_OPT; do
	IUSE="${IUSE} nginx_modules_mail_${module}"
done

DEPEND="ssl? ( dev-libs/openssl )
	pcre? ( >=dev-libs/libpcre-4.2 )
	http-cache? ( userland_GNU? ( dev-libs/openssl ) )
	nginx_modules_http_geo? ( dev-libs/geoip )
	nginx_modules_http_gzip? ( sys-libs/zlib )
	nginx_modules_http_gzip_static? ( sys-libs/zlib )
	nginx_modules_http_perl? ( >=dev-lang/perl-5.8 )
	nginx_modules_http_rewrite? ( >=dev-libs/libpcre-4.2 )
	nginx_modules_http_secure_link? ( userland_GNU? ( dev-libs/openssl ) )
	nginx_modules_http_xslt? ( dev-libs/libxml2 dev-libs/libxslt )
	" # nginx_modules_http_passenger? ( ~dev-ruby/${MODULE_PASSENGER_P} )"
RDEPEND="${DEPEND}"

pkg_setup() {
	ebegin "Creating nginx user and group"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
	eend ${?}

	if use ipv6; then
		ewarn "Note that ipv6 support in nginx is still experimental."
		ewarn "Be sure to read comments on gentoo bug #274614"
		ewarn "http://bugs.gentoo.org/show_bug.cgi?id=274614"
	fi

	use nginx_modules_http_passenger && {
		#ruby-ng_pkg_setup
		# fix strict-aliasing warnings in boost portion of passenger module
		append-flags -fno-strict-aliasing
		use debug && append-flags -DPASSENGER_DEBUG
	}
}

# prevent ruby-ng.eclass from messing with src_unpack
src_unpack() {
	default
}

src_prepare() {
	sed -i 's/ make/ \\$(MAKE)/' "${S}"/auto/lib/perl/make

	# fix passenger Rakefile to accept our CFLAGS
	use nginx_modules_http_passenger && {
		pushd "${WORKDIR}/${MODULE_PASSENGER_P}"
			sed -i -e "s:/usr/lib/phusion-passenger/agents:/usr/libexec/phusion-passenger/agents:" ext/common/ResourceLocator.h || die
		popd
	}
}

src_configure() {
	local myconf= enable_http=false enable_mail=false

	use debug && myconf="${myconf} --with-debug"
	use ipv6  && myconf="${myconf} --with-ipv6"
	# pcre are needed for http_rewrite, but can also be used for config files
	if use pcre || use nginx_modules_http_rewrite; then
		myconf="${myconf} --with-pcre"
	else
		myconf="${myconf} --without-pcre"
	fi

	# standard default modules
	for module in ${NGINX_MODULES_HTTP_STD}; do
		if use "nginx_modules_http_${module}"; then
			enable_http=true
		else
			myconf="${myconf} --without-http_${module}_module"
		fi
	done

	# optional modules
	for module in ${NGINX_MODULES_HTTP_OPT}; do
		if use "nginx_modules_http_${module}"; then
			myconf="${myconf} --with-http_${module}_module"
			enable_http=true
		fi
	done

	# 3rd party modules
	# passenger will compile itself in the configure step, so lets do it now
	if use nginx_modules_http_passenger; then
		pushd "${WORKDIR}/${MODULE_PASSENGER_P}"
			rake nginx || die
		popd
		myconf="${myconf} --add-module=../${MODULE_PASSENGER_P}/ext/nginx"
		enable_http=true
	fi

	# while good for security, not sure this is techically required
	use nginx_modules_http_fastcgi && \
		myconf="${myconf} --with-http_realip_module"

	# had http been specified directly via useflag
	if use http || use http-cache; then
		enable_http=true
	fi

	# do we need http support	
	if $enable_http; then
		use http-cache || myconf="${myconf} --without-http-cache"
		use ssl && myconf="${myconf} --with-http_ssl_module"
	else
		myconf="${myconf} --without-http --without-http-cache"
	fi

	# mail modules
	for module in ${NGINX_MODULES_MAIL_OPT}; do
		if use "nginx_modules_mail_${module}"; then
			myconf="${myconf} --without-mail_${module}_module"
			enable_mail=true
		fi
	done

	# do we need mail support
	if $enable_mail; then
		myconf="${myconf} --with-mail"
		use ssl && myconf="${myconf} --with-mail_ssl_module"
	fi

	# http://bugs.gentoo.org/show_bug.cgi?id=286772
	export LANG=C LC_ALL=C
	tc-export CC

	./configure \
		--prefix=/usr \
		--sbin-path=/usr/sbin/nginx \
		--conf-path=/etc/${PN}/${PN}.conf \
		--http-log-path=/var/log/${PN}/access.log \
		--error-log-path=/var/log/${PN}/error.log \
		--pid-path=/var/run/${PN}.pid \
		--lock-path=/var/lock/nginx.lock \
		--http-client-body-temp-path=/var/tmp/${PN}/client \
		--http-proxy-temp-path=/var/tmp/${PN}/proxy \
		--http-fastcgi-temp-path=/var/tmp/${PN}/fastcgi \
		--http-scgi-temp-path=/var/tmp/${PN}/scgi \
		--http-uwsgi-temp-path=/var/tmp/${PN}/uwsgi \
		--with-cc-opt="-I${ROOT}usr/include" \
		--with-ld-opt="-L${ROOT}usr/lib" \
		--user=${PN} --group=${PN} \
		${myconf} || die "configure failed"

}

src_compile() {
	# http://bugs.gentoo.org/show_bug.cgi?id=286772
	export LANG=C LC_ALL=C
	emake LINK="${CC} ${LDFLAGS}" OTHERLDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	keepdir /var/log/${PN} /var/tmp/${PN}/{client,proxy,fastcgi,scgi,uwsgi}

	dosbin objs/nginx
	newinitd "${FILESDIR}"/nginx.init nginx || die "failed to install init script"

	dodir /etc/${PN}
	insinto /etc/${PN}
	doins "${FILESDIR}"/nginx.conf
	doins conf/mime.types

	dodir /etc/${PN}/sites.d
	insinto /etc/${PN}/sites.d
	doins "${FILESDIR}"/sites.d/*

	dodir /etc/${PN}/modules.d
	insinto /etc/${PN}/modules.d
	use nginx_modules_http_gzip && doins "${FILESDIR}"/modules.d/gzip
	use ssl && doins "${FILESDIR}"/modules.d/ssl

	dodoc CHANGES{,.ru} README

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/nginx.logrotate nginx || die "failed to install logrotate script"

	use nginx_modules_http_perl && {
		cd "${S}"/objs/src/http/modules/perl/
		einstall DESTDIR="${D}" INSTALLDIRS=vendor || die "failed to install perl stuff"
		fixlocalpod
	}

	use nginx_modules_http_passenger && {
		insinto /etc/${PN}/modules.d
		doins "${FILESDIR}"/modules.d/passenger

		cd "${WORKDIR}/${MODULE_PASSENGER_P}"

#		# install ruby stuff to multiple targets
#		for RUBY in ${USE_RUBY}; do
#			# are we actually using this ruby target?
#			use ruby_targets_${RUBY} || continue
#
#			insinto $(${RUBY} -rrbconfig -e 'print Config::CONFIG["archdir"]')
#			insopts -m 0755
#			doins ext/ruby/$(${RUBY} -rrbconfig -e 'print "ruby-"+Config::CONFIG["RUBY_PROGRAM_VERSION"]+"-"+Config::CONFIG["arch"]')/passenger_native_support.so || die
#
#			doruby -r lib/*
#		done

#		exeinto /usr/sbin
#		doexe bin/passenger-memory-stats bin/passenger-status || die

		# this path seems hardcoded for now so place where expected
#		exeinto	/usr/share/phusion-passenger/helper-scripts
#		doexe helper-scripts/* || die

		# as above passenger_root directive seens brokeb
#		exeinto /usr/lib/phusion-passenger/agents
#		doexe agents/Passenger* || die

#		exeinto /usr/lib/phusion-passenger/agents/nginx
#		doexe agents/nginx/PassengerHelperAgent || die
	}
}

pkg_postinst() {
	if use ssl && [ ! -f "${ROOT}"/etc/ssl/${PN}/${PN}.key ]; then
		install_cert /etc/ssl/${PN}/${PN}
		chown ${PN}:${PN} "${ROOT}"/etc/ssl/${PN}/${PN}.{crt,csr,key,pem}
	fi

	# create an "its working" page if none exists
	if [[ ! -e "${ROOT}"/var/www/default ]] ; then
		mkdir -p "${ROOT}"/var/www/default/{public,log}
		echo "<html><body><h1>nginx on $(hostname -f) is working!!!</h1></body></html>" \
			> "${ROOT}"/var/www/default/public/index.html
		chown -R ${PN}:${PN} "${ROOT}"/var/www/default
	fi
}
