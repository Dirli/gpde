# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils meson vala

DESCRIPTION="Configure various aspects of the security of the system."
HOMEPAGE="https://github.com/elementary/switchboard-plug-security-privacy"
SRC_URI="https://github.com/elementary/switchboard-plug-security-privacy/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:=
	gnome-extra/zeitgeist
	pantheon-base/switchboard
	>=sys-auth/polkit-0.115
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_src_prepare
}


pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
