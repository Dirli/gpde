# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="The Gtk+ Stylesheet for elementary OS"
HOMEPAGE="https://github.com/elementary/stylesheet"
SRC_URI="https://github.com/elementary/stylesheet/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/sassc
"

S="${WORKDIR}/stylesheet-${PV}"
