# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION=0.16

inherit fdo-mime gnome2-utils vala meson

DESCRIPTION="A simple service to relaunch pantheon applications"
HOMEPAGE="https://launchpad.net/cerbere"
#EGIT_REPO_URI="https://github.com/elementary/cerbere.git"
SRC_URI="https://github.com/elementary/cerbere/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user

	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}
