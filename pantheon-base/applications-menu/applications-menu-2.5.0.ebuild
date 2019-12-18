# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

VALA_MIN_API_VERSION="0.32"

DESCRIPTION="A lightweight and stylish app launcher for Pantheon and other DEs"
HOMEPAGE="https://github.com/elementary/applications-menu"
SRC_URI="https://github.com/elementary/applications-menu/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls zeitgeist"

DEPEND="
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	>=dev-libs/appstream-0.10.0[vala]
	dev-libs/glib:2
	>=dev-libs/granite-0.5
	dev-libs/json-glib
	dev-libs/libgee:0.8
	gnome-base/gnome-menus:3
	zeitgeist? ( gnome-extra/zeitgeist )
	net-libs/libsoup:2.4
	pantheon-base/switchboard
	pantheon-base/wingpanel
	>=x11-libs/gtk+-3.12.0:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dwith-zeitgeist=$(usex zeitgeist true false)
		-Dwith-unity=false
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
}
