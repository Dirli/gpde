# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Elementary OS music player"
HOMEPAGE="https://github.com/elementary/music"
SRC_URI="https://github.com/elementary/music/archive/5.0.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="plugins ipod"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	>=dev-libs/glib-2.40:2
	>=dev-libs/granite-6.0.0
	dev-libs/libgee:0.8
	dev-libs/libpeas[gtk]
	gnome-extra/libgda:5
	gnome-extra/zeitgeist
	>=gui-libs/libhandy-0.83.0:1
	media-libs/gst-plugins-base
	media-libs/gstreamer
	ipod? ( media-libs/libgpod )
	media-libs/taglib
	media-plugins/gst-plugins-meta[mp3]
	>=x11-libs/gtk+-3.22:3
"

S="${WORKDIR}/music-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local plugs="[ 'audioplayer'"
	if [ $(usex ipod true false ) = true ]; then
		plugs=$plugs", 'ipod'"
	fi
	plugs=$plugs" ]"
	local emesonargs=(
		-D'build-plugins'=$(usex plugins true false)
		-Dplugins="$plugs"
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
