# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit vala meson

DESCRIPTION="An easy parental controls plug for Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-parental-controls"
SRC_URI="https://github.com/elementary/switchboard-plug-parental-controls/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	pantheon-base/switchboard
	dev-libs/granite
	sys-auth/polkit
	sys-apps/systemd
	sys-apps/accountsservice
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	eapply_user

	vala_src_prepare
}

src_configure() {
	meson_src_configure
}

#src_compile() {
#	cd ${BUILD_DIR} || die "build directory not found"
#	eninja || die "ninja failed"
#}

#src_install() {
#	cd ${BUILD_DIR} || die "build directory not found"
#	DESTDIR="${D}" eninja install || die "ninja install failed"
#}

