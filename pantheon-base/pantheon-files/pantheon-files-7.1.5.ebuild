# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.50

inherit gnome2 meson systemd vala xdg-utils

DESCRIPTION="A simple, powerful, sexy file manager for the Pantheon desktop"
HOMEPAGE="https://github.com/elementary/files"
SRC_URI="https://github.com/elementary/files/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="systemd wayland zeitgeist"

DEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.64.6:2
	>=dev-libs/granite-6.1.0:0/6
	dev-libs/libgee:0.8
	dev-libs/libgit2-glib
	dev-libs/libportal[gtk,wayland?]
	zeitgeist? ( >=gnome-extra/zeitgeist-1.0.2 )
	>=gui-libs/libhandy-0.83.0:1
	>=media-libs/libcanberra-0.30
	>=net-libs/libcloudproviders-0.3.0[vala]
	systemd? ( sys-apps/systemd )
	>=x11-libs/gtk+-3.22.25:3[X,wayland?]
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

	eapply "${FILESDIR}/${PV}-wayland_optional.patch"

	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dwith-zeitgeist=$(usex zeitgeist enabled disabled)
		-Dsystemduserunitdir=$(usex systemd $(systemd_get_userunitdir) no)
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
