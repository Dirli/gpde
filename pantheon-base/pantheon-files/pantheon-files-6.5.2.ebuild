# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.48

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="A simple, powerful, sexy file manager for the Pantheon desktop"
HOMEPAGE="https://github.com/elementary/files"
SRC_URI="https://github.com/elementary/files/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="wayland zeitgeist"

DEPEND="
	dev-db/sqlite:3
	dev-libs/dbus-glib
	>=dev-libs/glib-2.64.6:2
	>=dev-libs/granite-6.1.0:0
	dev-libs/libgee:0.8
	dev-libs/libgit2-glib
	>=dev-libs/libcloudproviders-0.3.0
	zeitgeist? ( >=gnome-extra/zeitgeist-1.0.2 )
	>=gui-libs/libhandy-0.83.0:1
	>=media-libs/libcanberra-0.30
	>=x11-misc/plank-0.10.9
	>=x11-libs/gtk+-3.22.25:3[X,wayland?]
	>=x11-libs/libnotify-0.7.2
	>=x11-libs/pango-1.1.2
"

RDEPEND="${DEPEND}
	gnome-base/gvfs
	xfce-base/tumbler
"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/files-${PV}"

src_prepare() {
	eapply_user

	eapply "${FILESDIR}/6.4.1-wayland_optional.patch"

	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dwith-zeitgeist=$(usex zeitgeist enabled disabled)
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
