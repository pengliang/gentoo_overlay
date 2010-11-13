# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

MY_P=${P}
DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="http://fcitx.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pango tray dbus"

RDEPEND="sys-libs/glibc
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXrender
	x11-libs/cairo
	dbus? ( sys-apps/dbus )
	pango? ( x11-libs/pango )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"
RESTRICT="primaryuri"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf $(use_enable pango) $(use_enable tray) $(use_enable dbus)

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README THANKS TODO
	dodoc doc/pinyin.txt doc/cjkvinput.txt
}

pkg_postinst() {
	echo
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=fcitx"
	elog " export XIM_PROGRAM=fcitx"
	elog
	elog "Conf files are at ~/.config/fcitx"
	echo
	if !use xft; then
		ewarn "NOTICE: We have changed the original \"truetype\" USE flag."
		ewarn "NOTICE: (Switch over to global \"xft\" USE flag.)"
		ewarn "NOTICE: Please re-merge your fcitx with xft on."
	fi
}
