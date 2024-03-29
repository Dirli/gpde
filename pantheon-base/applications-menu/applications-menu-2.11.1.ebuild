# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg-utils

VALA_MIN_API_VERSION="0.40"

DESCRIPTION="A lightweight and stylish app launcher for Pantheon and other DEs"
HOMEPAGE="https://github.com/elementary/applications-menu"
SRC_URI="https://github.com/elementary/applications-menu/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="zeitgeist"

DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-6.1.0:0
	dev-libs/json-glib
	dev-libs/libgee:0.8
	gnome-base/gnome-menus:3
	zeitgeist? ( gnome-extra/zeitgeist )
	>=gui-libs/libhandy-0.83.0:1
	net-libs/libsoup:2.4
	pantheon-base/switchboard
	>=pantheon-base/wingpanel-3.0.0
	>=x11-libs/gtk+-3.12.0:3
"

RDEPEND="${DEPEND}
	>=dev-libs/appstream-0.10.0[vala]
"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dwith-zeitgeist=$(usex zeitgeist true false)
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
