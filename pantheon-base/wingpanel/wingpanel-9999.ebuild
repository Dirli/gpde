# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="Stylish top panel that holds indicators and spawns an application launcher"
HOMEPAGE="https://github.com/elementary/wingpanel"

EGIT_REPO_URI="https://github.com/elementary/wingpanel.git"
EGIT_COMMIT="989cfbd26ca6d80e0f485df829e930f58af9f28f"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="example"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	>=dev-libs/glib-2.40:2
	dev-libs/libgee:0.8
	>=dev-libs/granite-5.4.0:=
	>=x11-libs/gtk+-3.10.0:3
	x11-wm/gala
	>=x11-wm/mutter-3.35.90:=
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dexample=$(usex example true false)
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
