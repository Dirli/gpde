# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 gnome2-utils meson vala

DESCRIPTION="Date & Time indicator for Wingpanel"
HOMEPAGE="https://github.com/Dirli/wingpanel-indicator-datetime"
EGIT_REPO_URI="https://github.com/Dirli/wingpanel-indicator-datetime.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="plugins nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libical
	gnome-extra/evolution-data-server[vala]
	net-libs/libsoup:2.4
	pantheon-base/wingpanel
	x11-libs/gtk+:3
	plugins? ( x11-libs/libnotify )
"
DEPEND="${RDEPEND}
	>=dev-lang/vala-0.40.3
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare --vala-api-version 0.40
}

src_configure() {
	local emesonargs=(
		-Dplugin=$(usex plugins true false)
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
