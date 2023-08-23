# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala

DESCRIPTION="Adjust keyboard settings from Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-keyboard"
SRC_URI="https://github.com/elementary/switchboard-plug-keyboard/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	app-i18n/ibus
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:0
	dev-libs/libxml2
	gnome-base/libgnomekbd
	>=gui-libs/libhandy-0.90.0:1
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
	x11-misc/xkeyboard-config
"

src_prepare() {
	eapply_user

	eapply "${FILESDIR}/3.1.0-delete_terminal_key.patch"

	vala_setup
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
