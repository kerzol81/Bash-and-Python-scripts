SUMMARY = "HTTP Audio Streaming"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "file://streamer"

SRC_URI[md5sum] = "40244cc5c167d9276d03ad1894bc2629"

FILESEXTRAPATHS_prepend := "${THISDIR}/file:"

S= "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0777 streamer ${D}${bindir}
}



