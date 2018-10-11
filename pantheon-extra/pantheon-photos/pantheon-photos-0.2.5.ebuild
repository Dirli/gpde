# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.26

inherit xdg-utils gnome2-utils vala cmake-utils

DESCRIPTION="Photo viewer and organizer designed for elementary OS"
HOMEPAGE="https://github.com/elementary/photos/archive/0.2.5.tar.gz"
SRC_URI="https://github.com/elementary/photos/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="nls"

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"
RDEPEND="${DEPEND}
	>=dev-libs/libgee-0.8.5:0.8
	>=media-libs/gexiv2-0.4.98
	sci-geosciences/geocode-glib
	>=dev-libs/glib-2.30:2
	>=media-libs/gstreamer-1.0.0:1.0
	>=media-libs/gst-plugins-base-1.0.0:1.0
	dev-libs/granite
	>=x11-libs/gtk+-3.6.0:3
	dev-libs/libgudev
	dev-libs/json-glib
	>=media-libs/libexif-0.6.16
	>=media-libs/libgphoto2-2.4.2
	>=media-libs/libwebp-0.4.4
	>=media-libs/libraw-0.13.2
	>=net-libs/libsoup-2.26:2.4
	>=dev-libs/libxml2-2.6.32:2[python]
	>=net-libs/rest-0.7:0.7
	>=dev-db/sqlite-3.5.9:3
	>=net-libs/webkit-gtk-2.0.0:4
"

S="${WORKDIR}/photos-${PV}"

src_prepare() {
	eapply_user

	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}

