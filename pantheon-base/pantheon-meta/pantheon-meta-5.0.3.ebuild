# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pantheon DE meta package"
HOMEPAGE="https://github.com/elementary/session-settings"
SRC_URI="https://github.com/elementary/session-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=gnome-base/gnome-session-3.0
	>=gnome-base/gnome-settings-daemon-3.0
	media-fonts/dejavu
	pantheon-base/applications-menu
	pantheon-base/cerbere
	pantheon-base/pantheon-settings
	pantheon-base/wingpanel
	x11-misc/light-locker
	x11-misc/lightdm[gtk]
	x11-misc/plank
	x11-themes/elementary-icons-theme
	x11-themes/elementary-sound-theme
	x11-themes/elementary-theme
	x11-themes/elementary-wallpapers
	x11-wm/gala
"

S="${WORKDIR}/session-settings-${PV}"

src_prepare() {
	eapply_user

	# Use gnome as fallback instead of ubuntu and mutter instead of gala
	sed -i -e 's/ubuntu/gnome/' gnome-session/pantheon.session

	# Use gnome-session wrapper that sets XDG_CURRENT_DESKTOP
	sed -i 's/gnome-session --session=pantheon/pantheon-session/' xsessions/pantheon.desktop

	# Correct paths
	sed -i 's#/usr/lib/[^/]*/#/usr/libexec/#' autostart/*
}

src_install() {
	insinto /usr/share/gnome-session/sessions
	doins gnome-session/*

	insinto /usr/share/xsessions
	doins xsessions/*

	insinto /etc/xdg/autostart
	doins autostart/*

	insinto /usr/share/pantheon
	doins -r applications

	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}/Pantheon"

	dobin "${FILESDIR}/pantheon-session"
}

