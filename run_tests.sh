#!/usr/bin/env bash
# =============================================================================
# run_tests.sh — Execução interativa de testes Robot Framework + Pabot
# Detecta devices Android via ADB e permite selecionar suite e devices
# =============================================================================

set -euo pipefail

# --- Cores para output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# --- Configurações ---
PABOT_CONFIGS_DIR="pabot_configs"
TESTS_DIR="tests"
RESULTS_DIR="pabot_results"
ALLURE_DIR="allure-report"
DEVICES_YAML="resources/data/devices.yaml"

# =============================================================================
# FUNÇÕES AUXILIARES
# =============================================================================

print_header() {
  echo ""
  echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${BLUE}║       Shield Smart Test Automation           ║${RESET}"
  echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════╝${RESET}"
  echo ""
}

print_step() {
  echo -e "${CYAN}${BOLD}▶ $1${RESET}"
}

print_success() {
  echo -e "${GREEN}✔ $1${RESET}"
}

print_warning() {
  echo -e "${YELLOW}⚠ $1${RESET}"
}

print_error() {
  echo -e "${RED}✖ $1${RESET}"
}

separator() {
  echo -e "${BLUE}──────────────────────────────────────────────${RESET}"
}

# =============================================================================
# DETECÇÃO DE DEVICES VIA ADB
# =============================================================================

get_connected_devices() {
  if ! command -v adb &>/dev/null; then
    print_error "ADB não encontrado. Verifique se está instalado e no PATH."
    exit 1
  fi

  # Retorna lista de UDIDs conectados (excluindo a linha de cabeçalho)
  adb devices | grep -E "^\S+\s+(device|emulator)" | awk '{print $1}'
}

get_device_tag_from_yaml() {
  local udid="$1"

  # Carrega .env se existir para expandir variáveis
  if [ -f ".env" ]; then
    set -a
    source .env
    set +a
  fi

  # Lê o devices.yaml e tenta associar o UDID a uma tag
  if command -v python3 &>/dev/null && [ -f "$DEVICES_YAML" ]; then
    python3 - "$udid" "$DEVICES_YAML" <<'EOF'
import sys
import os
import yaml
import re

udid = sys.argv[1]
yaml_path = sys.argv[2]

with open(yaml_path) as f:
    config = yaml.safe_load(f)

devices = config.get("devices", {})

for tag, data in devices.items():
    raw_udid = data.get("udid", "")
    # Expande ${VAR} usando variáveis de ambiente
    expanded = re.sub(r'\$\{(\w+)\}', lambda m: os.environ.get(m.group(1), ""), raw_udid)
    if expanded == udid:
        print(tag)
        sys.exit(0)

print("unknown")
EOF
  else
    echo "unknown"
  fi
}

# =============================================================================
# MENU DE SELEÇÃO DE DEVICES
# =============================================================================

select_devices() {
  local -a connected_udids
  mapfile -t connected_udids < <(get_connected_devices)

  if [ ${#connected_udids[@]} -eq 0 ]; then
    print_error "Nenhum device Android conectado. Conecte um device e tente novamente."
    exit 1
  fi

  echo ""
  print_step "Devices conectados detectados:"
  separator

  declare -A udid_to_tag
  declare -a display_items

  for udid in "${connected_udids[@]}"; do
    tag=$(get_device_tag_from_yaml "$udid")
    udid_to_tag["$udid"]="$tag"
    display_items+=("$udid ($tag)")
  done

  # Exibe devices encontrados
  local index=1
  for item in "${display_items[@]}"; do
    echo -e "  ${BOLD}[$index]${RESET} $item"
    ((index++))
  done

  separator
  echo ""

  # Pergunta se usa todos ou seleciona
  echo -e "${BOLD}Usar todos os devices conectados? [s/n]${RESET}"
  read -r use_all

  SELECTED_UDIDS=()

  if [[ "$use_all" =~ ^[Ss]$ ]]; then
    SELECTED_UDIDS=("${connected_udids[@]}")
    print_success "Todos os devices selecionados."
  else
    echo ""
    echo -e "${BOLD}Digite os números dos devices (separados por espaço):${RESET}"
    echo -e "${YELLOW}Exemplo: 1 3${RESET}"
    read -r -a choices

    for choice in "${choices[@]}"; do
      if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#connected_udids[@]} ]; then
        SELECTED_UDIDS+=("${connected_udids[$((choice - 1))]}")
      else
        print_warning "Opção inválida ignorada: $choice"
      fi
    done

    if [ ${#SELECTED_UDIDS[@]} -eq 0 ]; then
      print_error "Nenhum device válido selecionado."
      exit 1
    fi
  fi

  echo ""
  print_success "Devices selecionados: ${#SELECTED_UDIDS[@]}"
  for udid in "${SELECTED_UDIDS[@]}"; do
    tag="${udid_to_tag[$udid]}"
    echo -e "  ${GREEN}•${RESET} $udid ${CYAN}→ tag: $tag${RESET}"
  done
}

# =============================================================================
# MENU DE SELEÇÃO DE SUITE
# =============================================================================

select_suite() {
  echo ""
  print_step "Suites de teste disponíveis:"
  separator

  # Descobre suites dinamicamente a partir da pasta tests/
  local -a suites
  mapfile -t suites < <(find "$TESTS_DIR" -name "*.robot" | sort)

  if [ ${#suites[@]} -eq 0 ]; then
    print_error "Nenhuma suite .robot encontrada em $TESTS_DIR/"
    exit 1
  fi

  local index=1
  for suite in "${suites[@]}"; do
    # Remove o prefixo tests/ para exibição mais limpa
    local display="${suite#$TESTS_DIR/}"
    echo -e "  ${BOLD}[$index]${RESET} $display"
    ((index++))
  done

  # Opção para rodar todas
  echo -e "  ${BOLD}[$index]${RESET} ${YELLOW}Todas as suites${RESET}"
  local all_index=$index

  separator
  echo ""
  echo -e "${BOLD}Selecione a suite [1-$index]:${RESET}"
  read -r suite_choice

  if [[ "$suite_choice" =~ ^[0-9]+$ ]]; then
    if [ "$suite_choice" -eq "$all_index" ]; then
      SELECTED_SUITE="$TESTS_DIR/"
      print_success "Todas as suites selecionadas."
    elif [ "$suite_choice" -ge 1 ] && [ "$suite_choice" -le ${#suites[@]} ]; then
      SELECTED_SUITE="${suites[$((suite_choice - 1))]}"
      print_success "Suite selecionada: ${SELECTED_SUITE#$TESTS_DIR/}"
    else
      print_error "Opção inválida: $suite_choice"
      exit 1
    fi
  else
    print_error "Entrada inválida."
    exit 1
  fi
}

# =============================================================================
# MONTAGEM DO COMANDO PABOT
# =============================================================================

build_and_run() {
  echo ""
  print_step "Montando comando de execução..."
  separator

  # Cria pasta de resultados
  mkdir -p "$RESULTS_DIR"
  mkdir -p "$ALLURE_DIR"

  local -a pabot_args
  pabot_args+=(
    "--processes" "${#SELECTED_UDIDS[@]}"
    "--outputdir" "$RESULTS_DIR"
    "--listener" "allure_robotframework:$ALLURE_DIR"
  )

  # Monta --argumentfileN para cada device selecionado
  local index=1
  for udid in "${SELECTED_UDIDS[@]}"; do
    local tag="${udid_to_tag[$udid]:-unknown}"
    local args_file="$PABOT_CONFIGS_DIR/${tag}.args"

    if [ -f "$args_file" ]; then
      pabot_args+=("--argumentfile${index}" "$args_file")
    else
      # Gera args temporário se não existir arquivo para essa tag
      local tmp_args
      tmp_args=$(mktemp /tmp/device_XXXXXX.args)
      echo "--variable DEVICE_TAG:${tag}" > "$tmp_args"
      echo "--variable DEVICE_UDID:${udid}" >> "$tmp_args"
      pabot_args+=("--argumentfile${index}" "$tmp_args")
      print_warning "Arquivo $args_file não encontrado. Usando configuração temporária para $tag."
    fi

    ((index++))
  done

  pabot_args+=("$SELECTED_SUITE")

  # Exibe o comando final
  echo ""
  echo -e "${BOLD}Comando:${RESET}"
  echo -e "${CYAN}uv run pabot ${pabot_args[*]}${RESET}"
  echo ""
  separator

  # Confirmação antes de executar
  echo -e "${BOLD}Confirmar execução? [s/n]${RESET}"
  read -r confirm

  if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    print_warning "Execução cancelada."
    exit 0
  fi

  echo ""
  print_step "Iniciando execução..."
  echo ""

  uv run pabot "${pabot_args[@]}"

  echo ""
  print_step "Gerando Allure Report..."
  uv run allure generate "$ALLURE_DIR" -o "${ALLURE_DIR}/html" --clean
  print_success "Report gerado em: ${ALLURE_DIR}/html"

  echo ""
  echo -e "${BOLD}${GREEN}Execução finalizada!${RESET}"
  echo ""
  echo -e "  ${BOLD}Resultados:${RESET}   $RESULTS_DIR/"
  echo -e "  ${BOLD}Allure Report:${RESET} ${ALLURE_DIR}/html/index.html"
  echo ""

  # Pergunta se quer abrir o report
  echo -e "${BOLD}Abrir Allure Report no browser? [s/n]${RESET}"
  read -r open_report
  if [[ "$open_report" =~ ^[Ss]$ ]]; then
    uv run allure open "${ALLURE_DIR}/html"
  fi
}

# =============================================================================
# MAIN
# =============================================================================

main() {
  print_header

  # Verifica se está na raiz do projeto
  if [ ! -d "$TESTS_DIR" ]; then
    print_error "Execute este script a partir da raiz do projeto."
    exit 1
  fi

  # Carrega .env se existir
  if [ -f ".env" ]; then
    set -a
    source .env
    set +a
    print_success ".env carregado."
  fi

  # Declara variáveis globais
  declare -a SELECTED_UDIDS
  declare -A udid_to_tag
  SELECTED_SUITE=""

  select_devices
  select_suite
  build_and_run
}

main "$@"
