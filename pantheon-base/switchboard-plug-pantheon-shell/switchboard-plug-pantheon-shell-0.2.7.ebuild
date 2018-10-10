# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils xdg-utils vala meson

DESCRIPTION="Configure the Pantheon desktop environment using Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-pantheon-shell"
SRC_URI="https://github.com/elementary/switchboard-plug-pantheon-shell/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	media-libs/gexiv2[vala]
	gnome-base/gnome-desktop:3
	>=x11-misc/plank-0.10.9
	>=pantheon-base/switchboard-2
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	dev-util/meson
	nls? ( sys-devel/gettext )"

src_prepare() {
	eapply_user
	vala_src_prepare
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_schemas_update
}
