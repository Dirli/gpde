# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Control system power consumption using Switchboard."
HOMEPAGE="https://github.com/elementary/switchboard-plug-power"
SRC_URI="https://github.com/elementary/switchboard-plug-power/archive/${PV}.tar.gz -> ${P}.tar.gz"

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
	pantheon-base/switchboard
	sys-apps/dbus
	sys-auth/polkit
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
