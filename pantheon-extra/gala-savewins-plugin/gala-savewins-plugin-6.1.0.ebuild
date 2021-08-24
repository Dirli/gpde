# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala

DESCRIPTION="Gala plugin to restore windows after reboot"
HOMEPAGE="https://github.com/Dirli/gala-savewins-plugin"
SRC_URI="https://github.com/Dirli/gala-savewins-plugin/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

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
