SUMMARY = "Wav Recorder Script"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "file://recorder"

SRC_URI[md5sum] = "d1789baee89448837d48e264da901369"

FILESEXTRAPATHS_prepend := "${THISDIR}/file:"

S= "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0777 recorder ${D}${bindir}
}



