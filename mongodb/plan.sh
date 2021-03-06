pkg_name=mongodb
pkg_origin=chefops
pkg_version=3.2.9
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_source=https://fastdl.mongodb.org/linux/${pkg_name}-linux-x86_64-${pkg_version}.tgz
pkg_filename=${pkg_name}-linux-x86_64-${pkg_version}.tgz
pkg_dirname=${pkg_name}-linux-x86_64-${pkg_version}
pkg_shasum=07d982db0f7e7fb10a8d110d47debc470933d55f2077d7f547f14a5201725d50
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/patchelf)

pkg_expose=(27017 28017)
# This plan uses hooks.

do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/bin
  cp bin/* $pkg_prefix/bin/

  for i in mongo mongos mongod ; do
    build_line "Setting interpreter for '${pkg_prefix}/bin/${i}' '$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2'"
    build_line "Setting rpath for '${pkg_prefix}/bin/${i}' to '$LD_RUN_PATH'"
    patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
             --set-rpath ${LD_RUN_PATH} \
             ${pkg_prefix}/bin/${i}
  done
}
