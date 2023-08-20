# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Video player and library app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/videos"
SRC_URI="https://github.com/elementary/videos/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="amd64"
SLOT="0"

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	gui-libs/libhandy:1
	media-plugins/gst-plugins-gtk
	media-plugins/gst-plugins-meta[taglib]
	media-libs/gstreamer:1.0
	>=x11-libs/gtk+-3.22:3[X]
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S=${WORKDIR}/videos-${PV}

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
