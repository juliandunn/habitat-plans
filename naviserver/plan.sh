pkg_name=naviserver
pkg_origin=jdunn
pkg_version=4.99.11
pkg_license=('BSD-3-Clause')
pkg_maintainer="Julian Dunn <jdunn@aquezada.com>"
pkg_source=http://downloads.sourceforge.net/project/naviserver/naviserver/4.99.11/naviserver-4.99.11.tar.gz
pkg_shasum=7b80b7ab645ca95a0b2f621d58cb783044a9a390f51885c3163bbc107e153f19
pkg_bin_dirs=(bin)
pkg_build_deps=(core/make core/gcc core/tcl core/zlib core/busybox-static)
pkg_deps=(core/glibc core/tcl core/zlib core/gcc-libs)
pkg_expose=(8080)
pkg_svc_run="bin/nsd -i -t $pkg_svc_config_path/nsd-config.tcl"

do_build() {
  ./configure --prefix=$pkg_prefix \
              --with-tcl=$(pkg_path_for core/tcl)/lib \
              --with-zlib=$(pkg_path_for core/zlib)
  ln -sf $(pkg_path_for core/busybox-static)/bin/rm /bin/rm
  ln -sf $(pkg_path_for core/busybox-static)/bin/mkdir /bin/mkdir
  ln -sf $(pkg_path_for core/busybox-static)/bin/cp /bin/cp
  make
}
