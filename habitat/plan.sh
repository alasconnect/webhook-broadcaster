pkg_name=webhook-broadcaster
pkg_origin=ac-core
pkg_version="0.6.2"
pkg_maintainer="AlasConnect LLC <devops@alasconnect.com>"
pkg_license=('Apache-2.0')
pkg_description="Webhook Broadcaster"
pkg_upstream_url="https://github.com/alasconnect/webhook-broadcaster"

pkg_deps=(
  core/glibc
)

pkg_build_deps=(
  core/go
  core/git
  core/make
)

pkg_bin_dirs=(bin)

do_begin() {
  export GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  project_go_path="${GOPATH}/src/github.com/alasconnect/${pkg_name}"
}

do_unpack() {
  mkdir -p "${project_go_path}"

  # Copying like this to avoid . directories at the top level such as .stack-work
  cp -vr ${PLAN_CONTEXT}/../* ${project_go_path}/

  return $?
}

do_build() {
  cd "${project_go_path}"

  make build
}

do_install() {
  cp "${project_go_path}/bin/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
