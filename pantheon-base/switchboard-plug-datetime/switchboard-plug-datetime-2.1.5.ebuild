# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Configure the date & time of the user"
HOMEPAGE="https://github.com/elementary/switchboard-plug-datetime"
SRC_URI="https://github.com/elementary/switchboard-plug-datetime/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+plugins nls"

DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	pantheon-base/switchboard
	plugins? ( pantheon-base/wingpanel-indicator-datetime[plugins] )
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	if use plugins; then
		eapply "${FILESDIR}/2.1.5-add_break.patch"
	fi
	vala_src_prepare
}

