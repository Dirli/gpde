# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala xdg-utils

DESCRIPTION="Manage processes and monitor system resources in ElementaryOS"
HOMEPAGE="https://github.com/Dirli/pantheon-monitor"
SRC_URI="https://github.com/Dirli/pantheon-monitor/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+gui indicator"

DEPEND="
	dev-libs/glib:2
	dev-libs/libgee
	gnome-base/libgtop:2
	gui? (
		dev-libs/granite:0/6
		x11-libs/cairo
		x11-libs/libwnck:3
	)
	indicator? ( >=pantheon-base/wingpanel-3.0.0 )
	sys-fs/udisks:2
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dgui=$(usex gui true false)
		-Dresources=$(usex indicator true false)
		-Dsensors=$(usex indicator true false)
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
