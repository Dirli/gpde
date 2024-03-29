# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Displays the weather forecast and adds a weather indicator"
HOMEPAGE="https://github.com/Dirli/pantheon-meteo"
SRC_URI="https://github.com/Dirli/pantheon-meteo/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+indicator geoclue"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	geoclue? ( app-misc/geoclue )
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/json-glib
	dev-libs/libgweather:2=
	net-libs/libsoup:2.4
	indicator? ( pantheon-base/wingpanel )
	x11-libs/gtk+:3
"

src_prepare() {
	default
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dindicator=$(usex indicator true false)
		-Dgeoclue=$(usex geoclue true false)
	)
	meson_src_configure
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
