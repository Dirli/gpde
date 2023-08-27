# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_VERSION=0.22

inherit gnome2-utils meson vala

DESCRIPTION="Power indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-power"
SRC_URI="https://github.com/elementary/wingpanel-indicator-power/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:0
	gnome-base/libgtop:2
	>=pantheon-base/wingpanel-3.0.0
	virtual/libudev
	x11-libs/bamf
	x11-libs/gtk+:3
	x11-libs/libnotify
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
