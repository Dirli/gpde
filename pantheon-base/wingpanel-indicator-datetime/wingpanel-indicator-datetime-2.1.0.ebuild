# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_VERSION=0.40

inherit gnome2-utils vala cmake-utils

DESCRIPTION="Date & Time indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-datetime"
SRC_URI="https://github.com/elementary/wingpanel-indicator-datetime/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	gnome-extra/evolution-data-server[vala]
	net-libs/libsoup:2.4
	pantheon-base/wingpanel
	x11-libs/gtk+:3
	dev-libs/granite
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-lang/vala-0.40.3
"

src_prepare() {
	eapply_user

	vala_src_prepare --vala-api-version 0.40
	cmake-utils_src_prepare
}


src_configure() {
	mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE=${VALAC}
	)

	cmake-utils_src_configure
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
