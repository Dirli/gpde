# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{6,7,8,9,10,11} )
VALA_MIN_API_VERSION=0.22

inherit autotools bash-completion-r1 python-r1 vala xdg

DIR_PV=$(ver_cut 1-2)

DESCRIPTION="Service to log activities and present to other apps"
HOMEPAGE="https://launchpad.net/zeitgeist/"
SRC_URI="https://launchpad.net/zeitgeist/${DIR_PV}/${PV}/+download/${P}.tar.xz"

LICENSE="LGPL-2+ LGPL-3+ GPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE="datahub downloads-monitor fts introspection nls sql-debug telepathy"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	downloads-monitor? ( datahub )
"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/json-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/rdflib[${PYTHON_USEDEP}]
	media-libs/raptor:2
	>=dev-libs/glib-2.35.4:2
	>=dev-db/sqlite-3.7.11:3
	sys-apps/dbus
	datahub? ( x11-libs/gtk+:3 )
	fts? ( dev-libs/xapian:0=[inmemory] )
	introspection? ( dev-libs/gobject-introspection )
	telepathy? ( net-libs/telepathy-glib )
"

DEPEND="${RDEPEND}
	$(vala_depend)
	>=sys-devel/automake-1.11
	>=sys-devel/gettext-0.19
	virtual/pkgconfig
"

src_prepare() {
	# pure-python module is better managed manually, see src_install
	sed -e 's:python::g' \
		-i Makefile.am || die

	# fix placeholder in systemd service template
	sed -e 's:@libexecdir@:@pkglibexecdir@:' \
		-i extensions/fts++/zeitgeist-fts.service.in

	eapply_user
	vala_setup
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--without-dee-icu
		$(use_enable sql-debug explain-queries)
		$(use_enable datahub)
		$(use_enable downloads-monitor)
		$(use_enable telepathy)
		$(use_enable introspection)
	)

	use nls || myeconfargs+=( --disable-nls )
	use fts && myeconfargs+=( --enable-fts )

	python_setup
	econf "${myeconfargs[@]}"
}

src_test() {
	emake check TESTS_ENVIRONMENT="dbus-run-session"
}

src_install() {
	default

	dobashcomp data/completions/zeitgeist-daemon

	cd python || die
	python_moduleinto ${PN}
	python_foreach_impl python_domodule *py

	# Redundant NEWS/AUTHOR installation
	rm -r "${D}"/usr/share/zeitgeist/doc/ || die
}
