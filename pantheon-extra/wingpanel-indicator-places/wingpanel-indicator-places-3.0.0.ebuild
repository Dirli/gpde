# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Wingpanel places indicator for disks, volumes and places management"
HOMEPAGE="https://github.com/Dirli/wingpanel-indicator-places"
SRC_URI="https://github.com/Dirli/wingpanel-indicator-places/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	>=pantheon-base/wingpanel-3.0.0
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

