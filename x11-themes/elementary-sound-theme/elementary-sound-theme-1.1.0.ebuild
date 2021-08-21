# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A set of system sounds for elementary OS"
HOMEPAGE="https://github.com/elementary/sound-theme"
SRC_URI="https://github.com/elementary/sound-theme/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/sound-theme-${PV}"


