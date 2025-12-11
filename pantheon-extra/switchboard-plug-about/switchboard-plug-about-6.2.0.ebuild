# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit meson vala

DESCRIPTION="Switchboard plug to show system information"
HOMEPAGE="https://github.com/elementary/settings-system"
SRC_URI="https://github.com/elementary/settings-system/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	>=dev-libs/appstream-0.12.10[vala]
	>=dev-libs/glib-2.64.0:2
	dev-libs/granite:0/6
	dev-libs/libgudev
	gnome-base/libgtop
	gui-libs/libhandy:1
	pantheon-base/switchboard
	sys-apps/fwupd[introspection]
	sys-fs/udisks[introspection]
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/settings-system-${PV}"

src_prepare() {
	eapply "${FILESDIR}/${PV}-fix_fwupd_2.patch"
	eapply_user
	vala_setup
}
