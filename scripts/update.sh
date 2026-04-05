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
BACKUP_DIR="${TARGET_DIR}/.tmp/opencode-update-backup/$(date +%Y%m%d%H%M%S)"

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

backup_if_exists() {
  rel="$1"
  src="${TARGET_DIR}/${rel}"

  if [ -e "${src}" ]; then
    mkdir -p "$(dirname "${BACKUP_DIR}/${rel}")"
    cp -R "${src}" "${BACKUP_DIR}/${rel}"
    printf 'backup %s\n' "$rel"
  fi
}

replace_path() {
  rel="$1"
  src="${TEMPLATE_ROOT}/${rel}"
  dst="${TARGET_DIR}/${rel}"

  backup_if_exists "$rel"
  rm -rf "${dst}"
  mkdir -p "$(dirname "${dst}")"
  cp -R "${src}" "${dst}"
  printf 'atualizado %s\n' "$rel"
}

install_dependencies() {
  if [ -f "${TARGET_DIR}/.opencode/package.json" ]; then
    if command -v npm >/dev/null 2>&1; then
      printf 'instalando dependencias com npm...\n'
      npm install --prefix "${TARGET_DIR}/.opencode"
    elif command -v bun >/dev/null 2>&1; then
      printf 'instalando dependencias com bun...\n'
      (cd "${TARGET_DIR}/.opencode" && bun install)
    else
      printf 'aviso: npm/bun nao encontrado; dependencias nao foram instaladas\n' >&2
    fi
  fi
}

main() {
  mkdir -p "${TARGET_DIR}"

  printf 'Baixando template %s@%s...\n' "${REPO_SLUG}" "${REPO_REF}"
  download_archive

  replace_path "AGENTS.md"
  replace_path "README.md"
  replace_path "opencode.json"
  replace_path "docs"
  replace_path ".opencode"
  replace_path "scripts"

  install_dependencies

  if [ -d "${BACKUP_DIR}" ]; then
    printf '\nBackup salvo em %s\n' "${BACKUP_DIR}"
  fi

  printf 'Atualizacao concluida. Revise arquivos locais antes de commitar.\n'
}

main "$@"
