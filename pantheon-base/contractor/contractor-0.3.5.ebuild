# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.26

inherit meson vala

DESCRIPTION="A desktop-wide extension service"
HOMEPAGE="https://github.com/elementary/contractor"
SRC_URI="https://github.com/elementary/contractor/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	sys-apps/dbus
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
