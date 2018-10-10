# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit vala meson

DESCRIPTION="Configure all available networks"
HOMEPAGE="https://github.com/elementary/switchboard-plug-network"
SRC_URI="https://github.com/elementary/switchboard-plug-network/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	gnome-extra/nm-applet
	>=net-misc/networkmanager-1.8
	sys-auth/polkit
	dev-libs/granite
	x11-libs/gtk+:3
	>=pantheon-base/switchboard-2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	eapply_user
	vala_src_prepare
}


