# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit xdg-utils gnome2-utils vala meson

DESCRIPTION="Modular desktop settings hub"
HOMEPAGE="https://github.com/elementary/switchboard"
SRC_URI="https://github.com/elementary/switchboard/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls example cups bluetooth pulseaudio networkmanager upower"

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	media-libs/clutter-gtk
	>=x11-libs/gtk+-3.10:3
	dev-libs/granite
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	dev-util/meson
	nls? ( sys-devel/gettext )
"
PDEPEND="
	pantheon-base/switchboard-plug-a11y
	pantheon-base/switchboard-plug-about
	pantheon-base/switchboard-plug-applications
	bluetooth? ( pantheon-base/switchboard-plug-bluetooth )
	pantheon-base/switchboard-plug-datetime
	pantheon-base/switchboard-plug-display
	pantheon-base/switchboard-plug-keyboard
	pantheon-base/switchboard-plug-locale
	pantheon-base/switchboard-plug-mouse-touchpad
	networkmanager? ( pantheon-base/switchboard-plug-network )
	pantheon-base/switchboard-plug-notifications
	pantheon-base/switchboard-plug-pantheon-shell
	pantheon-base/switchboard-plug-parental-controls
	upower? ( pantheon-base/switchboard-plug-power )
	cups? ( pantheon-base/switchboard-plug-printers )
	pantheon-base/switchboard-plug-security-privacy
	pantheon-base/switchboard-plug-sharing
	pulseaudio? ( pantheon-base/switchboard-plug-sound )
	pantheon-base/switchboard-plug-useraccounts
"

src_prepare() {
	eapply_user

	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dexample=$(usex example true false)
		-Dlibunity=false
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
}
