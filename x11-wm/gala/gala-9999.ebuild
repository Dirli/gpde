# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.28

inherit gnome2-utils vala git-r3 meson

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://github.com/elementary/gala"
EGIT_REPO_URI="https://github.com/elementary/gala.git"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.44:2
	dev-libs/libgee:0.8
	>=media-libs/clutter-1.12
	media-libs/clutter-gtk
	gnome-base/gnome-desktop:3
	>=x11-misc/plank-0.11.0
	x11-libs/bamf
	dev-libs/granite
	>=x11-libs/gtk+-3.10.0:3
	>=x11-wm/mutter-3.18.3
	>=gnome-base/gnome-settings-daemon-3.15.2
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
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
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	gnome2_icon_cache_update
}
