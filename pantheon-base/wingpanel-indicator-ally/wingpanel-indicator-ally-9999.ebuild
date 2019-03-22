# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_VERSION=0.22

inherit git-r3 gnome2-utils meson vala

DESCRIPTION="Accessibility indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-a11y"
EGIT_REPO_URI="https://github.com/elementary/wingpanel-indicator-a11y.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite
	pantheon-base/wingpanel
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

