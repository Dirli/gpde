# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit vala meson

DESCRIPTION="Mouse and touchpad settings"
HOMEPAGE="https://github.com/elementary/switchboard-plug-mouse-touchpad"
SRC_URI="https://github.com/elementary/switchboard-plug-mouse-touchpad/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	x11-libs/gtk+:3
	>=pantheon-base/switchboard-2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	eapply_user
	vala_src_prepare
}

