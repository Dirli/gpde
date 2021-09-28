# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Adjust keyboard settings from Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-keyboard"
SRC_URI="https://github.com/elementary/switchboard-plug-keyboard/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
	x11-misc/xkeyboard-config
"

RDEPEND="${DEPEND}
	app-i18n/ibus
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:=
	dev-libs/libxml2
	gnome-base/libgnomekbd
	>=gui-libs/libhandy-0.90.0:1
	pantheon-base/switchboard
	x11-libs/gtk+:3
"


src_prepare() {
	eapply_user
	vala_src_prepare
}
