# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Mouse and touchpad settings"
HOMEPAGE="https://github.com/elementary/switchboard-plug-mouse-touchpad"
SRC_URI="https://github.com/elementary/switchboard-plug-mouse-touchpad/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:=
	dev-libs/libxml2
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
	)
	if has_version ">=gnome-base/gsettings-desktop-schemas-40.0" ; then
		emesonargs+=(
			-Dgnome_40=true
		)
	else
		emesonargs+=(
			-Dgnome_40=false
		)
	fi

	meson_src_configure
}

