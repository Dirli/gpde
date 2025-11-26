# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd vala

DESCRIPTION="Pantheon XDG Desktop Portals"
HOMEPAGE="https://github.com/elementary/portals"
SRC_URI="https://github.com/elementary/portals/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="wayland"

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0/6
	gui-libs/libhandy:1
	x11-libs/gtk+:3[X,wayland?]
"
RDEPEND="${DEPEND}
	sys-apps/xdg-desktop-portal
"

BDEPEND="
	sys-apps/systemd
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/portals-${PV}"

src_prepare() {
	eapply "${FILESDIR}/${PV}-wayland_optional.patch"
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dsystemduserunitdir="$(systemd_get_userunitdir)"
	)

	meson_src_configure
}
