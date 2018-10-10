# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.26

inherit vala meson

DESCRIPTION="A desktop-wide extension service"
HOMEPAGE="https://github.com/elementary/contractor"
SRC_URI="https://github.com/elementary/contractor/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

RDEPEND="
	sys-apps/dbus
	dev-libs/libgee:0.8
	dev-libs/glib:2
"
DEPEND="${RDEPEND}
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
