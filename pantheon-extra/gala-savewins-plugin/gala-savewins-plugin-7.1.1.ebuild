# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Gala plugin to restore windows after reboot"
HOMEPAGE="https://github.com/Dirli/gala-savewins-plugin"
SRC_URI="https://github.com/Dirli/gala-savewins-plugin/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	<=x11-wm/gala-8.0.0
	<x11-wm/mutter-46:=
"

RDEPEND="${DEPEND}"

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
src_prepare() {
	default
	vala_setup
}
