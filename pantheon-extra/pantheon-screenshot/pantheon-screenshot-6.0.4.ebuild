# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Elementary Screenshot Tool"
HOMEPAGE="https://github.com/elementary/screenshot"
SRC_URI="https://github.com/elementary/screenshot/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"


DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:0
	>=gui-libs/libhandy-0.83.0:1
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S=${WORKDIR}/screenshot-${PV}

src_prepare() {
	eapply_user
	vala_setup
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}
