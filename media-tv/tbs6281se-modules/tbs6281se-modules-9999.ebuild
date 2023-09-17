# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod git-r3

DESCRIPTION="Kernel Modules for TurboSight TBS 6281SE DVB-T/T2/C devices"
HOMEPAGE="https://www.tbsdtv.com/"
GIT_REPO_MEDIA_BUILD="https://github.com/tbsdtv/media_build.git"
GIT_REPO_LINUX_MEDIA="https://github.com/tbsdtv/linux_media.git"
GIT_LINUX_MEDIA_BRANCH="latest"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-perl/Proc-ProcessTable
	dev-util/patchutils"

S="${WORKDIR}/media_build"

PATCHES=(
	"${FILESDIR}/fix-lsmod-path.patch"
	"${FILESDIR}/config.patch"
)

BUILD_TARGETS="all"
MODULE_NAMES="
	dvb-core(misc:${S}:${S}/v4l)
	mc(misc:${S}:${S}/v4l)
	si2157(misc:${S}:${S}/v4l)
	si2168(misc:${S}:${S}/v4l)
	tbsecp3(misc:${S}:${S}/v4l)
"

CONFIG_CHECK="VIDEOBUF2_DVB"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="VER=${KV_FULL}"
}

src_unpack() {
	git-r3_fetch ${GIT_REPO_MEDIA_BUILD} refs/heads/master
	git-r3_checkout ${GIT_REPO_MEDIA_BUILD} "${WORKDIR}/media_build"

	git-r3_fetch ${GIT_REPO_LINUX_MEDIA} refs/heads/${GIT_LINUX_MEDIA_BRANCH}
	git-r3_checkout ${GIT_REPO_LINUX_MEDIA} "${WORKDIR}/media"
}

src_prepare() {
	default_src_prepare
	# This is a temp fix for linux >=6.5 and should be fixed in the media_build repo
	if kernel_is -ge 6 5; then
		cd "${WORKDIR}/media_build" || eerror "Failed to change into dir ${WORKDIR}/media_build"
		eapply "${FILESDIR}/fix-get-user-pages.patch"
	fi
}

src_configure() {
	set_arch_to_kernel
	emake dir DIR=../media
}
