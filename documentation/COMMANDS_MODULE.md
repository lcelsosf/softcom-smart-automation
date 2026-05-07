# Módulo Commands — Documentação Técnica

## Visão Geral

Módulo de automação para o fluxo de **Comanda/Mesa** do Softcom Smart. Cobre abertura de mesa, adição de itens, faturamento, adiantamentos, divisão de conta, cancelamento e demais operações de gestão de mesa.

**Entry point:** `modules/commands/base_commands.resource`

---

## Estrutura de Arquivos

```
modules/commands/
├── base_commands.resource              ← único import nas suites
├── locators/                           ← locators YAML, 1 arquivo por tela
│   ├── table_panel_locators.yaml       # Painel de Mesas
│   ├── open_table_locators.yaml        # Dialog Abrir Mesa
│   ├── client_locators.yaml            # Selecionar Cliente
│   ├── table_locators.yaml             # Mesa Aberta (tabs)
│   ├── products_locators.yaml          # Aba Produtos + Dialog Add Produto
│   ├── menu_table_locators.yaml        # Menu Lateral da Mesa
│   ├── advance_locators.yaml           # Adiantamentos
│   ├── invoice_locators.yaml           # Faturamento/Pagamento
│   ├── split_account_locators.yaml     # Dialog Dividir Conta
│   ├── join_table_locators.yaml        # Dialog Juntar Contas
│   ├── change_client_locators.yaml     # Dialog Alterar Cliente
│   └── cancel_table_locators.yaml      # Dialog Cancelar Mesa
├── pages/                              ← ações atômicas, 1 arquivo por tela
│   ├── table_panel_page.resource
│   ├── open_table_page.resource
│   ├── client_page.resource
│   ├── table_page.resource
│   ├── products_page.resource
│   ├── menu_table_page.resource
│   ├── advance_page.resource
│   ├── invoice_page.resource
│   ├── split_account_page.resource
│   ├── join_table_page.resource
│   ├── change_client_page.resource
│   └── cancel_table_page.resource
└── navigation/
    └── commands_navigation.resource    ← fluxos compostos de page keywords

tests/regression/commands/
└── commands.robot                      ← suite de regressão
```

---

## Regras de Arquitetura

| Camada | Responsabilidade | Proibido |
|--------|-----------------|---------|
| **Locators (YAML)** | Armazenar seletores | Lógica, condicionais |
| **Pages** | Ação atômica única por keyword | Fluxos, múltiplas interações |
| **Navigation** | Compor page keywords em fluxos | Locators hardcoded, `Wait Visible And Click Element` direto |
| **Suite** | Cenários de negócio | Import direto de pages ou locators |

---

## Estratégia de Locators

O app usa **Jetpack Compose** com `testTagsAsResourceId = true` via `ModifierExtensions.kt`:

```kotlin
fun Modifier.testTagWithPosition(elementName: String, position: Int = 0): Modifier {
    return this.semantics {
        testTagsAsResourceId = true
        testTag = "${elementName}_$position"
    }
}
```

| Tipo de elemento | Estratégia Appium | Exemplo |
|-----------------|------------------|---------|
| `testTag` via `testTagWithPosition` | `xpath=//*[@resource-id='Name_0']` | `xpath=//*[@resource-id='ComandaPainelMesasScreenColumn_0']` |
| `contentDescription` | `accessibility id=Value` | `accessibility id=Menu` |
| EditText dentro de container taggeado | `xpath=//*[@resource-id='Container_0']//android.widget.EditText` | `xpath=//*[@resource-id='OpenMesaDialogBasicOutlinedField_1']//android.widget.EditText` |
| Menu drawer com texto | `xpath=//*[@resource-id='...Text_0' and @text='Item']` | `xpath=//*[@resource-id='ConfigDrawerMenuDrawerMenuItemViewText_0' and @text='Faturar']` |
| Sem testTag (GAP) | `xpath=//*[@text='Texto']` | `xpath=//*[@text='Confirmar']` |

---

## Telas e Componentes

### Painel de Mesas (`ComandaPainelMesasScreen`)

Tela inicial do módulo. Lista mesas/comandas abertas com busca e filtro.

**Locators:** `table_panel_locators.yaml` → variável `${table_panel}`  
**Page:** `table_panel_page.resource`

| Key | Elemento | Estratégia |
|-----|----------|-----------|
| `open_table` | Botão "Abrir Mesa"/"Abrir Comanda" | xpath resource-id |
| `menu` | Ícone Menu (hamburguer) | accessibility id |
| `table_search` | Campo de busca | xpath resource-id + //EditText |
| `filter` | Ícone Filtro | accessibility id |
| `table_item` | Primeiro item de mesa/comanda | xpath resource-id |
| `table_panel` | Container principal (verificação) | xpath resource-id |
| `fab_open` | FAB "Abrir Mesa ou Comanda" | accessibility id |
| `clear_search` | Limpar pesquisa | accessibility id |
| `tab_mesas` | Aba Mesas (cenário dual) | xpath resource-id |
| `tab_comandas` | Aba Comandas (cenário dual) | xpath resource-id |

---

### Dialog Abrir Mesa (`OpenMesaDialog`)

Dialog de abertura de mesa ou comanda com campos de número, cliente e pessoas.

**Locators:** `open_table_locators.yaml` → variável `${open_table}`  
**Page:** `open_table_page.resource`

| Key | Elemento | Estratégia |
|-----|----------|-----------|
| `number_table` | Campo número da mesa | xpath resource-id + //EditText |
| `comanda_number` | Campo número da comanda | xpath resource-id + //EditText |
| `client_name` | Campo nome do cliente | xpath resource-id + //EditText |
| `search_client` | Buscar cliente | accessibility id |
| `add_people` / `sub_people` | Aumentar/Diminuir pessoas | accessibility id |
| `confirm` / `cancel` | Confirmar/Cancelar | xpath resource-id |

---

### Mesa Aberta (`ComandaMesaScreen`)

Tela da mesa aberta com tabs (Produtos / Conferência / Lançados) e barra de ações.

**Locators:** `table_locators.yaml` → variável `${table}`  
**Page:** `table_page.resource`

| Key | Elemento | Estratégia |
|-----|----------|-----------|
| `menu` | Ícone Menu | accessibility id |
| `conference_print` | Imprimir conferência | accessibility id |
| `products` | Aba Produtos | xpath resource-id |
| `conference` | Aba Conferência | xpath resource-id |
| `released` | Aba Lançados | xpath resource-id |
| `advance` / `cancel` | Barra inferior: Avançar/Cancelar | xpath resource-id |
| `filter` | Filtrar | accessibility id |
| `clean_search` | Limpar pesquisa | accessibility id |

---

### Aba Produtos + Dialog Add Produto

**Tela:** `ComandaMesaProdutosContent` + `ComandaAddProduto`  
**Locators:** `products_locators.yaml` → variável `${products}`  
**Page:** `products_page.resource`

| Key | Elemento | Estratégia |
|-----|----------|-----------|
| `search_item` | Campo busca de produtos | xpath resource-id + //EditText |
| `product` | Primeiro item na lista | xpath resource-id |
| `add_item` | Botão adicionar (barra inferior) | xpath resource-id |
| `item_obs` | Seção observações | xpath resource-id |
| `item_obs_text` | Campo observação | xpath resource-id + //EditText |
| `item_adc_add/sub` | Adicionar/Remover adicional | xpath content-desc indexado |

---

### Menu Lateral da Mesa (`ConfigDrawerMenu`)

Menu lateral compartilhado — diferenciado por `@text` do item.

**Locators:** `menu_table_locators.yaml` → variável `${menu_table}`  
**Page:** `menu_table_page.resource`

Itens disponíveis: `back`, `invoice`, `advance`, `split_account`, `change_client`, `join_accounts`, `cancel_table`, `manage_service_charge`

---

### Adiantamentos (`ComandaAdiantamentosScreen` + `ComandaAdiantamentoDialog`)

> ⚠️ **GAP:** `ComandaAdiantamentoDialog` não possui `testTags`. Os locators usam texto/hierarquia frágil.  
> **Ação pendente:** Solicitar ao dev inclusão de `testTagWithPosition` nos campos do dialog.

**Locators:** `advance_locators.yaml` → variável `${advance}`  
**Page:** `advance_page.resource`

---

### Faturamento / Pagamento

**Telas:** `PaymentScreen` + `ValorPagamentoDialog`  
**Locators:** `invoice_locators.yaml` → variável `${invoice}`  
**Page:** `invoice_page.resource`

Métodos suportados nas navegações: `money` (posição 0), `pixoff` (posição 4).

> Para adicionar novos métodos de pagamento, atualizar `invoice_locators.yaml` com novas posições e ajustar os `IF/ELSE IF` nas keywords de navegação.

---

### Telas sem testTags (GAPs)

As telas abaixo não possuem `testTagWithPosition` no código Kotlin. Os locators são baseados em texto e podem quebrar se o texto mudar.

| Tela | Arquivo | Solicitar ao dev |
|------|---------|-----------------|
| `ComandaAdiantamentoDialog` | `advance_locators.yaml` | Tags nos campos de cliente, valor e botões |
| `ComandaDividirContaDialog` | `split_account_locators.yaml` | Tag no título e botão |
| `ComandaJuntarContasDialogNew` | `join_table_locators.yaml` | Tags nos itens de mesa e botões |
| `MotivoCancelarMesaDialog` | `cancel_table_locators.yaml` | Tag no campo de motivo e botão confirmar |
| `ConfirmCancelarMesaDialog` | `cancel_table_locators.yaml` | Tag no texto de confirmação e botões |

---

## Keywords de Navegação

### Fluxos Disponíveis

```robot
# Abrir uma nova mesa
Commands - Navigate To Open Table    ${table_number}    ${client_name}

# Localizar e abrir mesa existente
Commands - Navigate To Search Table And Open    ${table_number}

# Adicionar N itens à mesa (varargs)
Commands - Add Items To Table    Item1    Item2    Item3

# Faturar (métodos: money, pixoff)
Commands - Navigate To Invoice And Pay    money

# Registrar adiantamento (métodos: money, pixoff)
Commands - Navigate To Advance    ${client}    ${value}    pixoff

# Dividir conta
Commands - Navigate To Split Account

# Alterar cliente
Commands - Navigate To Change Client

# Juntar contas
Commands - Navigate To Join Accounts

# Cancelar mesa
Commands - Navigate To Cancel Table    ${cancel_reason}
```

### Fluxos Completos

```robot
# Abrir + adicionar itens + faturar
Commands - Complete Flow - Open Table And Add Items And Invoice
...    ${table_number}    ${client_name}    ${payment_method}    @{item_names}

# Abrir + registrar adiantamento
Commands - Complete Flow - Open Table And Record Advance
...    ${table_number}    ${client_name}    ${advance_value}    ${payment_method}
```

---

## Uso nas Suites

```robot
*** Settings ***
Resource    modules/commands/base_commands.resource
Suite Setup      Suite Setup Default
Suite Teardown   Suite Teardown Default
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default

*** Test Cases ***
Abrir mesa e faturar
    [Tags]    regression    commands    critical
    Commands - Navigate To Open Table    10    Cliente
    Commands - Navigate To Search Table And Open    10
    Commands - Add Items To Table    Frango    Cerveja
    Commands - Navigate To Invoice And Pay    money
```

---

## Execução

```bash
# Suite completa
./run_tests.sh

# Filtrar por tag
robot --include commands tests/regression/commands/commands.robot

# Paralelo com pabot
pabot --processes 2 --include commands tests/regression/commands/
```

---

## Histórico de Decisões

| Decisão | Motivo |
|---------|--------|
| `xpath=//*[@resource-id='...']` para testTags | `testTagsAsResourceId=true` mapeia testTag para `resource-id`, não `content-desc` |
| `accessibility id=` para contentDescription | Estratégia Appium para `content-desc` no Android |
| 1 YAML por tela | Facilita manutenção isolada; evita conflito de chaves entre telas |
| Navigation importa pages explicitamente | Autocontido — não depende da ordem de imports no base |
| `cancel_reason` como argumento | Evita variável global; teste define o motivo de negócio |
