# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson vala

DESCRIPTION="Manage your dynamic workspaces from the panel"
HOMEPAGE="https://github.com/Dirli/wingpanel-indicator-workspaces"
SRC_URI="https://github.com/Dirli/wingpanel-indicator-workspaces/archive/${PV}.tar.gz -> ${P}.tar.gz"

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
	dev-libs/granite
	pantheon-base/wingpanel
	x11-libs/gtk+:3
	x11-libs/libwnck
"

src_prepare() {
	eapply_user
	vala_src_prepare
}
