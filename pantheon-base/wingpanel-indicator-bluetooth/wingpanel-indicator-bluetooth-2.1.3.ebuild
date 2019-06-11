# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.22

inherit gnome2-utils meson vala

DESCRIPTION="Bluetooth indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-bluetooth"
SRC_URI="https://github.com/elementary/wingpanel-indicator-bluetooth/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	pantheon-base/wingpanel
	x11-libs/gtk+:3
	x11-libs/libnotify
"
DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
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
