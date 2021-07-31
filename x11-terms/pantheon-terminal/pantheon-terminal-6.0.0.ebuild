# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="The terminal of the 21st century"
HOMEPAGE="https://github.com/elementary/terminal"
SRC_URI="https://github.com/elementary/terminal/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""


DEPEND="
	$(vala_depend)
	dev-util/desktop-file-utils
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	>=dev-libs/granite-6.1.0:=
	dev-libs/libgee
	dev-libs/libpcre2
	>=gui-libs/libhandy-0.83.0:1
	x11-libs/gtk+:3
	x11-libs/vte:2.91[vala]
"

S="${WORKDIR}/terminal-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

