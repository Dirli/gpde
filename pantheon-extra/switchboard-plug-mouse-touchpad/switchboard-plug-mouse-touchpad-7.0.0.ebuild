# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit meson vala

DESCRIPTION="Mouse and touchpad settings"
HOMEPAGE="https://github.com/elementary/settings-mouse-touchpad"
SRC_URI="https://github.com/elementary/settings-mouse-touchpad/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0/6
	dev-libs/libxml2
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}
	gnome-base/gsettings-desktop-schemas:=
"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/settings-mouse-touchpad-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}

