# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.26

inherit gnome2-utils meson vala

DESCRIPTION="Sound indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-sound"
SRC_URI="https://github.com/elementary/wingpanel-indicator-sound/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="bluetooth nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	media-libs/libcanberra[gtk3]
	media-sound/pulseaudio[glib]
	pantheon-base/wingpanel
	x11-libs/gtk+:3
	x11-libs/libnotify
"
DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user

	if use !bluetooth; then
		eapply "${FILESDIR}/${PV}-rm_bluetooth.patch"
	fi

	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
