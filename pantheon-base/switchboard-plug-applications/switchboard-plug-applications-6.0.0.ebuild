# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit meson vala

DESCRIPTION="Application configuration management"
HOMEPAGE="https://github.com/elementary/switchboard-plug-applications"
SRC_URI="https://github.com/elementary/switchboard-plug-applications/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="flatpak"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	>=dev-libs/glib-2.34:2
	dev-libs/granite
	pantheon-base/switchboard
	flatpak? ( sys-apps/flatpak )
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user

	eapply "${FILESDIR}/${PV}-flatpak_optional.patch"

	vala_src_prepare
}
