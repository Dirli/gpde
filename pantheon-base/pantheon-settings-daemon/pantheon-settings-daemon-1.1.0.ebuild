# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala

DESCRIPTION="Pantheon settings daemon"
HOMEPAGE="https://github.com/elementary/settings-daemon"
SRC_URI="https://github.com/elementary/settings-daemon/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	>=dev-libs/granite-5.3.0
	dev-libs/glib:2
	app-misc/geoclue:2.0
"

S="${WORKDIR}/settings-daemon-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_savelist
}

pkg_postinst() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}

pkg_postrm() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}
