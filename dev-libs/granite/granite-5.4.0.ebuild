# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit meson vala xdg-utils

DESCRIPTION="Elementary OS library that extends Gtk+"
HOMEPAGE="https://github.com/elementary/granite"
SRC_URI="https://github.com/elementary/granite/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8[introspection]
	>=x11-libs/gtk+-3.22:3[introspection]
"

DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Ddocumentation=$(usex doc true false)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
