# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="The Inter font family"
HOMEPAGE="https://rsms.me/inter/"
SRC_URI="https://github.com/rsms/${PN}/releases/download/v${PV}/Inter-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}"

BDEPEND="app-arch/unzip"

FONT_SUFFIX="ttc ttf"
