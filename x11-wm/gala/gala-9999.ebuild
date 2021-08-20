# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.28

inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://github.com/elementary/gala"

EGIT_REPO_URI="https://github.com/elementary/gala.git"
EGIT_COMMIT="737b960ed5e0e23b2dcf00431e6bf4932e1f5d6a"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	>=dev-libs/glib-2.44:2
	>=dev-libs/granite-5.4.0:=
	dev-libs/libgee:0.8
	gnome-base/gnome-desktop:3
	gnome-base/gnome-settings-daemon
	media-libs/libcanberra
	media-libs/gexiv2
	x11-libs/gdk-pixbuf[jpeg]
	>=x11-libs/gtk+-3.10.0:3
	>=x11-misc/plank-0.11.0
	>=x11-wm/mutter-3.36.0:=
"

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
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
