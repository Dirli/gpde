# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Manage your dynamic workspaces from the panel"
HOMEPAGE="https://github.com/Dirli/wingpanel-indicator-workspaces"
SRC_URI="https://github.com/Dirli/wingpanel-indicator-workspaces/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	>=pantheon-base/wingpanel-3.0.0
	x11-libs/gtk+:3
	x11-libs/libwnck
"

RDEPEND="${DEPEND}"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
