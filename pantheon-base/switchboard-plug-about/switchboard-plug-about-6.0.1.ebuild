# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit meson vala

DESCRIPTION="Switchboard plug to show system information"
HOMEPAGE="https://github.com/elementary/switchboard-plug-about"
SRC_URI="https://github.com/elementary/switchboard-plug-about/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	>=dev-libs/appstream-0.12.10
	>=dev-libs/glib-2.64.0:2
	dev-libs/granite
	gnome-base/libgtop
	gui-libs/libhandy:1
	pantheon-base/switchboard
	sys-apps/fwupd
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
