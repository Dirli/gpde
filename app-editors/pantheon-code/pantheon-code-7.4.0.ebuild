# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.50

inherit gnome2 meson vala xdg-utils

DESCRIPTION="Code editor designed for elementary OS"
HOMEPAGE="https://github.com/elementary/code"
SRC_URI="https://github.com/elementary/code/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="plugins policykit"

DEPEND="
	plugins? (
		app-text/editorconfig-core-c
		app-text/gtkspell:3
		net-libs/libsoup:2.4
	)
	>=dev-libs/glib-2.30:2
	>=dev-libs/granite-6.0.0:0/6
	>=dev-libs/libgee-0.8.5:0.8
	dev-libs/libgit2-glib
	dev-libs/libpeas[gtk]
	>=gui-libs/libhandy-0.90.0:1
	media-libs/fontconfig
	>=x11-libs/gtk+-3.6:3
	x11-libs/gtksourceview:4
	x11-libs/pango
	x11-libs/vte:2.91
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	policykit? ( sys-auth/polkit )
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/code-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Ddevelopment=false
		-Dplugins=$(usex plugins true false)
		-Dhave_pkexec=$(usex policykit true false)
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
