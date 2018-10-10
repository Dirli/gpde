# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.34

inherit fdo-mime gnome2-utils vala cmake-utils versionator multilib

DESCRIPTION="A simple, powerful, sexy file manager for the Pantheon desktop"
HOMEPAGE="http://launchpad.net/pantheon-files"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2).x/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+gvfs nls"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/dbus-glib
	>=dev-libs/glib-2.29.0:2
	>=dev-libs/granite-0.3
	dev-libs/libgee:0.8
	gnome-extra/zeitgeist
	x11-misc/plank
	>=x11-libs/gtk+-3.14:3
	pantheon-extra/contractor
	>=x11-libs/libnotify-0.7.2
	>=media-libs/libcanberra-0.30
	>=x11-libs/pango-1.1.2
	gvfs? ( gnome-base/gvfs )
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

DOCS=( AUTHORS COPYING HACKING README )

src_prepare() {
	eapply_user

	# Disable generation of the translations (if needed)
	use nls || sed -i -e '/add_subdirectory (po)/d' CMakeLists.txt

	# Replace hard-coded "/usr/lib" in CMakeLists (.so files destination)
	if [[ $(get_libdir) != lib ]]; then
		sed -e "s|\\(\\\${CMAKE_INSTALL_PREFIX}\\)/lib|\\1/$(get_libdir)|g" \
			-i {,lib{core,widgets}/}CMakeLists.txt || die
		sed -e "s|DESTINATION lib/|DESTINATION $(get_libdir)/|g" \
			-i plugins/{contractor,network-places,pantheon-files-{trash,ctags}}/CMakeLists.txt || die
	fi

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DICON_UPDATE=ON
		-DUSE_UNITY=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
