# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala

DESCRIPTION="This is plug for elementary Switchboard to configure settings for Wacom tablets"
HOMEPAGE="https://github.com/elementary/switchboard-plug-wacom"
SRC_URI="https://github.com/elementary/switchboard-plug-wacom/archive/refs/tags/1.0.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgudev
	dev-libs/libwacom
	pantheon-base/switchboard
	x11-libs/gtk+:3[wayland]
	x11-libs/libX11
	x11-libs/libXi
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
