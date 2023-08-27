# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_VERSION=0.40

inherit gnome2-utils meson vala

DESCRIPTION="Network indicator for Wingpanel"
HOMEPAGE="https://launchpad.net/wingpanel-indicator-network"
SRC_URI="https://github.com/elementary/wingpanel-indicator-network/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	gnome-extra/nm-applet
	>=net-misc/networkmanager-1.24.0
	>=pantheon-base/wingpanel-3.0.0
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

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
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
