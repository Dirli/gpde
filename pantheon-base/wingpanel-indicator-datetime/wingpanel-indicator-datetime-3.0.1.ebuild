# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala

DESCRIPTION="Date & Time indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-datetime"
SRC_URI="https://github.com/Dirli/wingpanel-indicator-datetime/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="evolution"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	evolution? (
		dev-libs/libical
		gnome-extra/evolution-data-server[vala] 
	)
	net-libs/libsoup:2.4
	>=pantheon-base/wingpanel-3.0.0
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Devo=$(usex evolution true false)
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
