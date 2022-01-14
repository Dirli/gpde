# Copyright 2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Wallpapers for elementary OS"
HOMEPAGE="https://github.com/elementary/wallpapers"
SRC_URI="https://github.com/elementary/wallpapers/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/wallpapers-${PV}

