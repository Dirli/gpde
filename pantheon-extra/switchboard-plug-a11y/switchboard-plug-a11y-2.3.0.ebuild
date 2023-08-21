# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Switchboard Universal Access Plug"
HOMEPAGE="https://github.com/elementary/switchboard-plug-a11y"
SRC_URI="https://github.com/elementary/switchboard-plug-a11y/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}
	pantheon-extra/wingpanel-indicator-a11y
"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
