# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit meson vala

DESCRIPTION="A printers plug for Switchboard"
HOMEPAGE="https://github.com/elementary/settings-printers"
SRC_URI="https://github.com/elementary/settings-printers/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:0/6
	net-print/cups
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/settings-printers-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}

