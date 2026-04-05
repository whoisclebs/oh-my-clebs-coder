#!/usr/bin/env sh

set -eu

REPO_SLUG="whoisclebs/oh-my-clebs-coder"
REPO_REF="main"
TARGET_DIR="${1:-$PWD}"
TMP_DIR="$(mktemp -d 2>/dev/null || mktemp -d -t opencode-template)"
ARCHIVE_URL="https://codeload.github.com/${REPO_SLUG}/tar.gz/refs/heads/${REPO_REF}"
ARCHIVE_FILE="${TMP_DIR}/template.tar.gz"
EXTRACT_DIR="${TMP_DIR}/extract"
TEMPLATE_ROOT="${EXTRACT_DIR}/oh-my-clebs-coder-${REPO_REF}"

cleanup() {
  rm -rf "${TMP_DIR}"
}

trap cleanup EXIT INT TERM

download_archive() {
  mkdir -p "${EXTRACT_DIR}"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${ARCHIVE_URL}" -o "${ARCHIVE_FILE}"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "${ARCHIVE_FILE}" "${ARCHIVE_URL}"
  else
    printf 'Erro: curl ou wget e obrigatorio para baixar o template\n' >&2
    exit 1
  fi

  tar -xzf "${ARCHIVE_FILE}" -C "${EXTRACT_DIR}"
}

copy_if_missing() {
  src="$1"
  dst="$2"

  if [ -e "${dst}" ]; then
    printf 'skip  %s (ja existe)\n' "$dst"
    return 0
  fi

  mkdir -p "$(dirname "${dst}")"
  cp -R "${src}" "${dst}"
  printf 'instalado %s\n' "$dst"
}

copy_children_if_missing() {
  src_dir="$1"
  dst_dir="$2"

  mkdir -p "${dst_dir}"

  for entry in "${src_dir}"/* "${src_dir}"/.[!.]* "${src_dir}"/..?*; do
    if [ ! -e "${entry}" ]; then
      continue
    fi

    name="$(basename "${entry}")"
    copy_if_missing "${entry}" "${dst_dir}/${name}"
  done
}

install_dependencies() {
  if [ ! -f "${TARGET_DIR}/.opencode/package.json" ]; then
    printf 'skip  dependencias (.opencode/package.json ausente)\n'
    return 0
  fi

  if [ -d "${TARGET_DIR}/.opencode/node_modules" ]; then
    printf 'skip  dependencias (.opencode/node_modules ja existe)\n'
    return 0
  fi

  if command -v npm >/dev/null 2>&1; then
    printf 'instalando dependencias com npm...\n'
    npm install --prefix "${TARGET_DIR}/.opencode"
    return 0
  fi

  if command -v bun >/dev/null 2>&1; then
    printf 'instalando dependencias com bun...\n'
    (cd "${TARGET_DIR}/.opencode" && bun install)
    return 0
  fi

  printf 'aviso: npm/bun nao encontrado; dependencias nao foram instaladas\n' >&2
}

main() {
  mkdir -p "${TARGET_DIR}"

  printf 'Baixando template %s@%s...\n' "${REPO_SLUG}" "${REPO_REF}"
  download_archive

  copy_if_missing "${TEMPLATE_ROOT}/AGENTS.md" "${TARGET_DIR}/AGENTS.md"
  copy_if_missing "${TEMPLATE_ROOT}/README.md" "${TARGET_DIR}/README.md"
  copy_if_missing "${TEMPLATE_ROOT}/opencode.json" "${TARGET_DIR}/opencode.json"
  copy_if_missing "${TEMPLATE_ROOT}/docs" "${TARGET_DIR}/docs"
  if [ -d "${TARGET_DIR}/.opencode" ]; then
    copy_children_if_missing "${TEMPLATE_ROOT}/.opencode" "${TARGET_DIR}/.opencode"
  else
    copy_if_missing "${TEMPLATE_ROOT}/.opencode" "${TARGET_DIR}/.opencode"
  fi
  copy_if_missing "${TEMPLATE_ROOT}/scripts" "${TARGET_DIR}/scripts"

  install_dependencies

  printf '\nConcluido. Revise AGENTS.md, opencode.json e .opencode/.\n'
}

main "$@"
