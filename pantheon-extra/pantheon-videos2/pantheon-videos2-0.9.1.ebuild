# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Alternative vision of the default video player in the Pantheon DE"
HOMEPAGE="https://github.com/Dirli/videos2"
SRC_URI="https://github.com/Dirli/videos2/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgee
	media-plugins/gst-plugins-gtk
	media-plugins/gst-plugins-meta[ffmpeg]
	media-libs/gstreamer:1.0
	media-libs/libdvbpsi
	>=x11-libs/gtk+-3.22:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S=${WORKDIR}/videos2-${PV}

src_prepare() {
	eapply_user
	vala_src_prepare
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
