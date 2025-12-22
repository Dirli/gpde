# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_VERSION=0.22

inherit meson vala

DESCRIPTION="Session indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-session"
SRC_URI="https://github.com/elementary/wingpanel-indicator-session/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-5.3.0:0/6
	>=gui-libs/libhandy-0.90.0:1
	>=pantheon-base/wingpanel-3.0.0:=
	sys-apps/accountsservice:=
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
