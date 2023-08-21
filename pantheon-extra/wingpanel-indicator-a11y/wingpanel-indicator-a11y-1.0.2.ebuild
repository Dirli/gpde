# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala

DESCRIPTION="Wingpanel Universal Access Indicator"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-a11y"
SRC_URI="https://github.com/elementary/wingpanel-indicator-a11y/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	>=pantheon-base/wingpanel-3.0.0:=
	x11-libs/gtk+:3
"

#app-accessibility/onboard
RDEPEND="${DEPEND}
	app-accessibility/orca
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
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
