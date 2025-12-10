# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit gnome2 meson vala xdg-utils

DESCRIPTION="Location services agent"
HOMEPAGE="https://github.com/elementary/pantheon-agent-geoclue2"
SRC_URI="https://github.com/elementary/pantheon-agent-geoclue2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	app-misc/geoclue
	dev-libs/glib:2
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
}
