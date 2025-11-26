# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit gnome2 meson vala

DESCRIPTION="Date & Time indicator for Wingpanel"
HOMEPAGE="https://github.com/Dirli/wingpanel-indicator-datetime"
SRC_URI="https://github.com/Dirli/wingpanel-indicator-datetime/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="evolution"

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0/6
	evolution? (
		dev-libs/libical
		gnome-extra/evolution-data-server[vala]
	)
	>=pantheon-base/wingpanel-3.0.0
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

DEPEND="
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
