# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Configure the Pantheon desktop environment using Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-pantheon-shell"
SRC_URI="https://github.com/elementary/switchboard-plug-pantheon-shell/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:0
	media-libs/gexiv2[vala]
	gnome-base/gnome-desktop:=
	gui-libs/libhandy:1
	pantheon-base/switchboard
	>=x11-libs/gtk+-3.22:3
	>=x11-misc/plank-0.10.9
"

RDEPEND="${DEPEND}
	pantheon-base/pantheon-settings-daemon
	pantheon-base/contractor
"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_schemas_update
}
