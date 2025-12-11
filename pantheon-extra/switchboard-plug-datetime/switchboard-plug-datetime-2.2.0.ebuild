# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Configure the date & time of the user"
HOMEPAGE="https://github.com/elementary/settings-datetime"
SRC_URI="https://github.com/elementary/settings-datetime/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-5.0.0:0/6
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/settings-datetime-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}

