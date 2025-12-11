# Copyright 2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Stylish top panel that holds indicators and spawns an application launcher"
HOMEPAGE="https://github.com/elementary/wingpanel"
SRC_URI="https://github.com/elementary/wingpanel/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="example"

DEPEND="
	>=dev-libs/glib-2.40:2
	dev-libs/libgee:0.8
	>=dev-libs/granite-5.4.0:0/6
	>=x11-libs/gtk+-3.10.0:3[X]
	x11-wm/gala
	<x11-wm/mutter-47
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply "${FILESDIR}/${PV}-add_mutter_46_1.patch"
	eapply "${FILESDIR}/${PV}-add_mutter_46_2.patch"

	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		$(meson_use example)
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}
