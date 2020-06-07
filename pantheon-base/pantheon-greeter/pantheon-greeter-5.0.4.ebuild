# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala xdg-utils

DESCRIPTION="LightDM Greeter for Pantheon"
HOMEPAGE="https://github.com/elementary/greeter"
SRC_URI="https://github.com/elementary/greeter/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgee:0.8
	sys-apps/accountsservice
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-misc/lightdm[introspection,vala]
	>=x11-wm/mutter-3.34.0:=
"

S="${WORKDIR}/greeter-${PV}"

src_prepare() {
	eapply_user

	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dubuntu-patched-gsd=false
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

