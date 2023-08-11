# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.40

inherit gnome2-utils meson vala

DESCRIPTION="Keyboard indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-keyboard"
SRC_URI="https://github.com/elementary/wingpanel-indicator-keyboard/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
	x11-misc/xkeyboard-config
"

RDEPEND="${DEPEND}
	app-i18n/ibus
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libxml2[python]
	>=pantheon-base/wingpanel-3.0.0
	x11-libs/gtk+:3
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
