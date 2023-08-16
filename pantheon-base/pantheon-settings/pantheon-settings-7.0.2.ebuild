# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson

DESCRIPTION="Default settings for the Pantheon Desktop Environment"
HOMEPAGE="https://github.com/elementary/default-settings"
SRC_URI="https://github.com/elementary/default-settings/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="no license"
SLOT="0"
KEYWORDS="amd64"
IUSE="flatpak"

DEPEND="
	sys-apps/accountsservice
	sys-apps/dbus
	sys-auth/polkit
"
RDEPEND="${DEPEND}
	pantheon-base/pantheon-settings-daemon
	x11-themes/elementary-icons-theme
	x11-themes/elementary-sound-theme
	x11-themes/elementary-theme
	x11-themes/elementary-wallpapers
"

S="${WORKDIR}/default-settings-${PV}"

src_prepare() {
	eapply_user

	eapply "${FILESDIR}/6.0.0-drop_test_page.patch"
	eapply "${FILESDIR}/${PV}-drop_terminal_key.patch"
}

src_configure() {
	local emesonargs=(
		-Dappcenter-flatpak=$(usex flatpak true false)
	)
	meson_src_configure
}


pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
