# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson systemd vala

DESCRIPTION="Pantheon settings daemon"
HOMEPAGE="https://github.com/elementary/settings-daemon"
SRC_URI="https://github.com/elementary/settings-daemon/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="systemd"

DEPEND="
	app-misc/geoclue:2.0
	dev-libs/glib:2
	>=dev-libs/granite-5.3.0:0/6
	sys-apps/fwupd
	systemd? ( sys-apps/systemd )
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
"

S="${WORKDIR}/settings-daemon-${PV}"

src_prepare() {
	eapply "${FILESDIR}/${PV}-add_support_fwupd2.patch"
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dsystemduserunitdir=$(usex systemd $(systemd_get_userunitdir) no)
		-Dsystemdsystemunitdir=$(usex systemd $(systemd_get_systemunitdir) no)
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

