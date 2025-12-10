# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.34

inherit meson vala

DESCRIPTION="Pantheon Polkit Agent"
HOMEPAGE="https://github.com/elementary/pantheon-agent-polkit"
SRC_URI="https://github.com/elementary/pantheon-agent-polkit/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:0/6
	sys-auth/polkit[introspection]
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
