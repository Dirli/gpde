# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala

DESCRIPTION="Gala plugin to switch layouts per window"
HOMEPAGE="https://github.com/Dirli/gala-layoutpw-plugin"
SRC_URI="https://github.com/Dirli/gala-layoutpw-plugin/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/libgee:0.8
	>=x11-wm/gala-6.0.0
	>=x11-wm/mutter-3.36.0:=
"

src_prepare() {
	default
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
