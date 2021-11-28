# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.50

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Code editor designed for elementary OS"
HOMEPAGE="https://github.com/elementary/code"
SRC_URI="https://github.com/elementary/code/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="plugins flatpak"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	app-text/editorconfig-core-c
	app-text/gtkspell:3
	>=dev-libs/glib-2.30:2
	>=dev-libs/granite-6.0.0:=
	>=dev-libs/libgee-0.8.5:0.8
	dev-libs/libgit2-glib
	dev-libs/libpeas[gtk]
	>=gui-libs/libhandy-0.90.0:1
	media-libs/fontconfig
	net-libs/libsoup:2.4
	>=x11-libs/gtk+-3.6:3
	x11-libs/gtksourceview:4
	x11-libs/pango
	x11-libs/vte:2.91
"

S="${WORKDIR}/code-${PV}"

src_prepare() {
	eapply_user

	eapply "${FILESDIR}/${PV}-optional_portal.patch"

	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dplugins=$(usex plugins true false)
		-Dflatpak=$(usex flatpak true false)
	)
	meson_src_configure
}


pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}
