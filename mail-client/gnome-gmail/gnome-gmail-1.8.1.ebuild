# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Gnome Gmail is software which adds support for Gmail to the Linux Gnome Desktop."
HOMEPAGE="http://gnome-gmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Version_${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="gnome-base/gconf"
RDEPEND="${DEPEND}"

src_compile() {
	emake DESTDIR="${D}" PREFIX="/usr/" || die "emake failed!"
}

src_install () {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed!"
}
