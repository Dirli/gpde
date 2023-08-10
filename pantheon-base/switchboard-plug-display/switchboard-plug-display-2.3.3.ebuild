# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit meson vala

DESCRIPTION="Switchboard plug to show displays information"
HOMEPAGE="https://github.com/elementary/switchboard-plug-display"
SRC_URI="https://github.com/elementary/switchboard-plug-display/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:0
	>=gui-libs/libhandy-0.83.0:1
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
