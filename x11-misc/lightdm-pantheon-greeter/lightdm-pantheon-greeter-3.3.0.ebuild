# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils vala meson

DESCRIPTION="Pantheon Greeter"
HOMEPAGE="https://github.com/elementary/greeter"
SRC_URI="https://github.com/elementary/greeter/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="nls"

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"
RDEPEND="${DEPEND}
	media-libs/clutter-gtk:1.0
	pantheon-base/wingpanel
	x11-libs/gdk-pixbuf:2
	virtual/opengl
	dev-libs/granite
	>=x11-misc/lightdm-1.2.1[vala]
	x11-libs/gtk+:3
"

S=${WORKDIR}/greeter-${PV}

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
