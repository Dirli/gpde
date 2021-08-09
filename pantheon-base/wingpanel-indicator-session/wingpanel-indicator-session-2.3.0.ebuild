# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.22

inherit meson vala

DESCRIPTION="Session indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-session"
SRC_URI="https://github.com/elementary/wingpanel-indicator-session/archive/${PV}.tar.gz -> ${P}.tar.gz"

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
	>=dev-libs/granite-5.3.0:=
	>=gui-libs/libhandy-0.90.0:1
	>=pantheon-base/wingpanel-3.0.0:=
	sys-apps/accountsservice:=
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
