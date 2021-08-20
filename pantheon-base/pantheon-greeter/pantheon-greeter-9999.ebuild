# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson vala xdg-utils

DESCRIPTION="LightDM Greeter for Pantheon"
HOMEPAGE="https://github.com/elementary/greeter"

EGIT_REPO_URI="https://github.com/elementary/greeter.git"
EGIT_COMMIT="c4f1e7b81addccc39f3f65d5652b965c492800dd"

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
	dev-libs/glib:2
	>=dev-libs/granite-5.5.0:=
	dev-libs/libgee:0.8
	>=gui-libs/libhandy-1.1.90:=
	sys-apps/accountsservice
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-misc/lightdm[introspection,vala]
	>=x11-wm/mutter-3.36.0:=
"

src_prepare() {
	eapply_user

	vala_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

