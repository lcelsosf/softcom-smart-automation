# Plano de execução — Fases 2, 3 e 4

Documento de acompanhamento da migração do projeto shield-smart-test-automation
para a arquitetura alvo definida no CLAUDE.md.

---

## Status geral

| Fase   | Descrição                                       | Status          |
| ------ | ----------------------------------------------- | --------------- |
| Fase 1 | Fundação — infraestrutura e configuração        | 🔄 Em andamento |
| Fase 2 | Dissolução da pasta common/                     | 🔄 Em andamento |
| Fase 3 | Modularização — criar modules/ e adaptar suites | ⏳ Pendente     |
| Fase 4 | Limpeza final                                   | ⏳ Pendente     |

---

## Fase 1 — Fundação — infraestrutura e configuração

### ✅ Ponto 1 — common_keywords.resource refatorado

- Keywords renomeadas para evitar colisão com AppiumLibrary
- `device.resource` eliminado da cadeia de imports
- Padrão `_Do` documentado e padronizado

### ✅ Ponto 2 — resources/base/ criado

- `base.resource` com variáveis globais (substitui `variables.resource`)
- `open_app.resource` refatorado — lê config do `devices.yaml` via `DevicesConfig.py`
- `setup.resource` com `Suite/Test Setup Default` e `Teardown Default` padronizados

### ✅ Ponto 3 — run_tests.sh

- Detecção automática de devices via ADB
- Menu interativo de seleção de devices e suites
- Comando pabot montado dinamicamente
- Geração de Allure Report ao final

### ⏳ Ponto 4 — DevicesConfig.py refatorado

**Ação manual:**

- Adicionar método `get_tag_from_udid(udid)` — busca tag no `devices.yaml` pelo UDID
- Adicionar método `get_device_config(tag)` — retorna objeto com `system_port`,
  `appium_server` e `app_package` para a tag informada
- Migrar expansão de variáveis de ambiente da sintaxe customizada `%{VAR=default}`
  para `python-dotenv` com `os.getenv("VAR", default)` padrão
- Chamar `load_dotenv()` no `__init__` da classe

Métodos obrigatórios após refatoração:

```python
def get_device_udid(self, tag: str, default: str = "emulator-5554") -> str
def get_device_config(self, tag: str) -> DeviceConfig
def get_keyboard_close_method(self, tag: str) -> str
def get_tag_from_udid(self, udid: str) -> str
```

### ⏳ Ponto 5 — devices.yaml atualizado

**Ação manual:**

- Adicionar `system_port` e `appium_server` para todos os 19 adquirentes
- Migrar sintaxe de UDID de `%{VAR=default}` para `${VAR}`
- Verificar se todos os adquirentes têm `app_package` explícito ou herdam `default_app_package`

Portas a usar por adquirente:

| Tag                      | system_port |
| ------------------------ | ----------- |
| cielo                    | 8200        |
| rede                     | 8202        |
| rede_n960k               | 8204        |
| getnet / getnet_dx8000   | 8206        |
| getnet_p2                | 8208        |
| getnet_p3                | 8210        |
| stone                    | 8212        |
| pagbank                  | 8214        |
| pagbank_a11              | 8216        |
| fiserv                   | 8218        |
| sipag_p2                 | 8220        |
| sipag_x990               | 8222        |
| sipag_dx8000             | 8224        |
| safra                    | 8226        |
| mercadopago              | 8228        |
| quickpay / quickpay_a910 | 8230        |
| clover                   | 8232        |

Validar após edição:

```bash
python3 -c "import yaml; yaml.safe_load(open('resources/data/devices.yaml'))"
```

### ⏳ Ponto 6 — pabot_configs/\*.args simplificados

**Ação manual:**

- Editar cada `.args` mantendo apenas `--variable DEVICE_TAG:<tag>`
- Remover `SYSTEM_PORT`, `APPIUM_SERVER_URL` e qualquer outra variável
- Criar os `.args` que ainda não existem para os adquirentes cadastrados no `devices.yaml`

Estrutura obrigatória de cada arquivo:
--variable DEVICE_TAG:<tag>

Verificar lista de `.args` existentes vs adquirentes no `devices.yaml`:

```bash
ls pabot_configs/*.args
```

---

## Fase 2 — Dissolução da pasta common/

### ✅ Ponto 7 — structured_logging.resource

- Corrigido formatação de `&{kwargs}` ignorados
- Movido para `resources/helpers/structured_logging.resource`

### ✅ Ponto 8 — error_handling.resource

- Movido sem mudanças estruturais para `resources/helpers/error_handling.resource`

### ✅ Ponto 9 — validation.robot

- Helpers internos `_Resolve Endpoint` e `_Load Json` extraídos
- Renomeado para `resources/helpers/validation.resource`

### ⏳ Ponto 10 — device.resource — eliminar

**Ação manual:**

- Deletar `common/device.resource`
- Confirmar que `Close Keyboard` em `common_keywords.resource` já absorveu a lógica
- Verificar se não há mais referências com:

```bash
grep -r "device.resource" --include="*.resource" --include="*.robot" .
grep -r "Get Device Type" --include="*.resource" --include="*.robot" .
```

### ⏳ Ponto 11 — variables.resource — eliminar

**Ação manual:**

- Confirmar que `base.resource` já tem todas as variáveis globais
- Confirmar que `devices.yaml` tem `system_port` e `appium_server`
- Confirmar que `env_variables.py` carrega as credenciais via python-dotenv
- Deletar `resources/variables/variables.resource`
- Verificar referências restantes com:

```bash
grep -r "variables.resource" --include="*.resource" --include="*.robot" .
```

---

## Fase 3 — Modularização

### ⏳ Ponto 12 — Criar base\_<modulo>.resource para cada módulo

**Ação manual — implementar para cada módulo:**

- `modules/default/base_default.resource`
- `modules/pdv/base_pdv.resource`
- `modules/commands/base_commands.resource`
- `modules/prevenda/base_prevenda.resource`
- `modules/mini_mercado/base_mini_mercado.resource`

Usar o arquivo `documentation/examples/base_default.resource` como template.

### ⏳ Ponto 13 — Adaptar suites para importar apenas o base do módulo

**Ação manual — para cada suite:**

- Remover todos os imports diretos de `resources/`
- Substituir por um único `Resource  ../../modules/<modulo>/base_<modulo>.resource`

Usar o arquivo `documentation/examples/default_suite.robot` como referência.

### ⏳ Ponto 14 — Validar e mover navigation/ para modules/<modulo>/

**Executar no terminal com acesso a ambos os projetos:**

1. Rodar o prompt de análise disponível em `documentation/prompts/analyze_navigations.md`
2. O prompt lê os arquivos de navigation do projeto legado `shield-softcom-smart-automation`
3. Avalia se cada arquivo respeita as regras:
   - Contém apenas fluxos compostos (nunca ações atômicas)
   - Não duplica lógica que deveria estar em pages/
   - Não importa AppiumLibrary diretamente
4. Gera relatório de divergências e sugestões de ajuste
5. Após validação e ajustes → mover para `modules/<modulo>/navigation/`

---

## Fase 4 — Limpeza final

### ⏳ Ponto 15 — Remover import .venv de commands/main_navigation.resource

```bash
# Localizar o import problemático
grep -n "venv" resources/navigation/commands/main_navigation.resource

# Remover a linha manualmente no editor
```

### ⏳ Ponto 16 — Resolver módulo mini_mercado

**Decisão necessária:**

- [ ] Implementar do zero seguindo a estrutura de módulo padrão
- [ ] Remover `base_minimarket.resource` e arquivos com referências quebradas

### ⏳ Ponto 17 — Limpar código morto

```bash
# Verificar se orders_navigation.resource (shim) ainda é referenciado
grep -r "orders_navigation" --include="*.resource" --include="*.robot" .

# Verificar se login/logoff em commands ainda é referenciado
grep -r "logoff.resource" --include="*.resource" --include="*.robot" .
```

### ⏳ Ponto 18 — Atualizar CLAUDE.md e README.md

- Remover seção "Plano de migração" do CLAUDE.md
- Remover seção "Arquivos já refatorados" e substituir por estado final
- Atualizar README.md com estrutura final do projeto
