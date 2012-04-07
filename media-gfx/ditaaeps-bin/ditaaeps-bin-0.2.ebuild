# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit java-pkg-2

MY_PN=DitaaEps
DESCRIPTION="DIagrams Through Ascii Art (EPS-producing fork of ditaa 0.6b)"
HOMEPAGE="http://ditaa-addons.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/ditaa-addons/${MY_PN}/${PV}/${MY_PN}-${PV/./_}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	>=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S=${WORKDIR}

src_compile() {
	# Workaround against ClassNotFoundException on jargs.gnu.CmdLineParser$OptionException
	# by re-packing into a single jar
	unzip ${MY_PN}/ditaa0_6b.jar || die
	rm -R META-INF || die
	unzip ${MY_PN}/${MY_PN}.jar || die
	rm -R ${MY_PN} COPYING || die
	jar cvf ${MY_PN,,}.jar * || die
}

src_install() {
	java-pkg_dojar ${MY_PN,,}.jar || die
	java-pkg_dolauncher ${MY_PN,,} --main se.ngm.ditaaeps.EpsRenderer || die
}
