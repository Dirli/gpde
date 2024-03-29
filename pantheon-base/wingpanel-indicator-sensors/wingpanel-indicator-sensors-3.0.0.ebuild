# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala

DESCRIPTION="Shows hardware sensors readings"
HOMEPAGE="https://github.com/Dirli/wingpanel-indicator-sensors"
SRC_URI="https://github.com/Dirli/wingpanel-indicator-sensors/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
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
	>=pantheon-base/wingpanel-3.0.0
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
