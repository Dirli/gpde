# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="This package allows you to extract and compress the archive over Contractor"
HOMEPAGE="https://github.com/Dirli/contract-archive"
SRC_URI="https://github.com/Dirli/contract-archive/archive/v${PV}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	app-arch/file-roller
	pantheon-base/contractor
"

BDEPEND="
	sys-devel/gettext
"

src_prepare() {
	eapply_user
}

