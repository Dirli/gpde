# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit meson vala

DESCRIPTION="Application configuration management"
HOMEPAGE="https://github.com/elementary/settings-applications"
SRC_URI="https://github.com/elementary/settings-applications/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="flatpak"

DEPEND="
	>=dev-libs/glib-2.34:2
	dev-libs/granite:0/6
	pantheon-base/switchboard
	flatpak? ( sys-apps/flatpak )
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/settings-applications-${PV}"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${PV}-flatpak_optional.patch"
	vala_setup
}
