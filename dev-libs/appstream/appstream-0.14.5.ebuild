# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION="0.48"
VALA_USE_DEPEND="vapigen"

inherit meson vala xdg-utils

SRC_URI="https://www.freedesktop.org/software/appstream/releases/AppStream-${PV}.tar.xz"
S="${WORKDIR}/AppStream-${PV}"
KEYWORDS="amd64"

DESCRIPTION="Cross-distro effort for providing metadata for software in the Linux ecosystem"
HOMEPAGE="https://www.freedesktop.org/wiki/Distributions/AppStream/"

LICENSE="LGPL-2.1+ GPL-2+"
# check as_api_level
SLOT="0/4"
IUSE="apt doc +introspection qt5 test vala"
RESTRICT="test" # bug 691962

RDEPEND="
	dev-db/lmdb:=
	>=dev-libs/glib-2.58:2
	dev-libs/libxml2:2
	dev-libs/libyaml
	dev-libs/snowball-stemmer:=
	net-misc/curl
	introspection? ( >=dev-libs/gobject-introspection-1.56:= )
	qt5? ( dev-qt/qtcore:5 )
"
DEPEND="${RDEPEND}
	test? ( qt5? ( dev-qt/qttest:5 ) )
"
BDEPEND="
	dev-libs/appstream-glib
	dev-libs/libxslt
	dev-util/itstool
	>=sys-devel/gettext-0.19.8
	doc? ( app-text/docbook-xml-dtd:4.5 )
	test? ( dev-qt/linguist-tools:5 )
	vala? ( $(vala_depend) )
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.14.3-disable-Werror-flags.patch # bug 733774
)

src_prepare() {
	default
	sed -e "/^as_doc_target_dir/s/appstream/${PF}/" -i docs/meson.build || die
	if ! use test; then
		sed -e "/^subdir.*tests/s/^/#DONT /" -i {,qt/}meson.build || die # bug 675944
	fi
}

src_configure() {
	xdg_environment_reset

	local emesonargs=(
		-Dapidocs=false
		-Ddocs=false
		-Dcompose=false
		-Dmaintainer=false
		-Dstemming=true
		-Dvapi=$(usex vala true false)
		-Dapt-support=$(usex apt true false)
		-Dinstall-docs=$(usex doc true false)
		-Dgir=$(usex introspection true false)
		-Dqt=$(usex qt5 true false)
	)

	meson_src_configure
}
