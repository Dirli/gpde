# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="The terminal of the 21st century"
HOMEPAGE="https://github.com/elementary/terminal"
SRC_URI="https://github.com/elementary/terminal/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

DEPEND="
	>=dev-libs/glib-2.40:2
	>=dev-libs/granite-6.1.0:0
	dev-libs/libgee
	dev-libs/libpcre2
	>=gui-libs/libhandy-0.83.0:1
	>=x11-libs/gtk+-3.24:3
	>=x11-libs/vte-0.59:2.91[vala]
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	test? (
		dev-util/desktop-file-utils
		x11-misc/xvfb-run
	)
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/terminal-${PV}"

src_prepare() {
	eapply_user

	eapply "${FILESDIR}/${PV}-test_optional.patch"

	vala_setup
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

