# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Switchboard plug to setup bluetooth devices"
HOMEPAGE="https://github.com/elementary/switchboard-plug-bluetooth"
SRC_URI="https://github.com/elementary/switchboard-plug-bluetooth/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-5.2.4:0
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
