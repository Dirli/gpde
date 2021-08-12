# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala

DESCRIPTION="Indicator is able to adjust the Intel p-state driver (Sandy Bridge and newer)"
HOMEPAGE="https://github.com/Dirli/wingpanel-indicator-cpufreq"
SRC_URI="https://github.com/Dirli/wingpanel-indicator-cpufreq/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
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
	dev-libs/granite
	>=pantheon-base/wingpanel-3.0.0
	sys-auth/polkit
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
