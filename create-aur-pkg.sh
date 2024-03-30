#!/bin/sh -e
gitapps_dir=${gitapps_dir:-/mnt/Data/gitapps}
TARGET_DIR=${TARGET_DIR:-${gitapps_dir}/AUR}

for pkgname in "$@"; do
  gitless_name=$(echo "${pkgname}" | sed 's/-git$//')
  git_pkg=true
  if [ "${pkgname}" = "${gitless_name}" ]; then
    git_pkg=false
  fi

  cd "${TARGET_DIR}"
  mkdir -p "${pkgname}"
  cd "${pkgname}"
  git init -b master
  git remote add origin ssh://aur@aur.archlinux.org/"${pkgname}".git

  {
    echo "${pkgname}*"
    echo "src"
    echo "pkg"
  } > .gitignore

  {
    if ${git_pkg}; then
      makedep_git=git
      # shellcheck disable=SC2016
      source_git='"${pkgname}"::"git+${url}"'
      checksum_git=SKIP
    fi

    echo "# Maintainer: Mazhar Hussain <realmazharhussain@gmail.com>"
    echo "pkgname=${pkgname}"
    echo "pkgdesc=''"
    echo "url="
    echo "pkgver=1.0"
    echo "pkgrel=1"
    echo "arch=(any)"
    echo "license=()"
    if ${git_pkg}; then
      echo "provides=(${gitless_name})"
      echo "conflicts=(${gitless_name})"
    fi
    echo "depends=()"
    echo "makedepends=(${makedep_git})"
    echo "checkdepends=()"
    echo "source=(${source_git})"
    echo "sha256sums=(${checksum_git})"

    if ${git_pkg}; then
      echo
      echo 'pkgver() {'
      # shellcheck disable=SC2016
      echo '  cd "${srcdir}/${pkgname}"'
      echo '  git describe --tags --long | sed -e "s/^v//" -e "s/-/+/g"'
      echo '}'
    fi

    echo
    echo 'build() {'
    # shellcheck disable=SC2016
    echo '  cd "${srcdir}/${pkgname}"'
    echo '}'

    echo
    echo 'check() {'
    # shellcheck disable=SC2016
    echo '  cd "${srcdir}/${pkgname}"'
    echo '}'

    echo
    echo 'package() {'
    # shellcheck disable=SC2016
    echo '  cd "${srcdir}/${pkgname}"'
    echo '}'
  } > PKGBUILD
done
