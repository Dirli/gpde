# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit vala meson

DESCRIPTION="Configure the date & time of the user"
HOMEPAGE="https://github.com/elementary/switchboard-plug-datetime"
SRC_URI="https://github.com/elementary/switchboard-plug-datetime/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	x11-libs/gtk+:3
	pantheon-base/switchboard"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	dev-util/meson
	nls? ( sys-devel/gettext )"

src_prepare() {
	eapply_user

	vala_src_prepare
}

