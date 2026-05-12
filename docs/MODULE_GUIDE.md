# Guia de Implementação de Módulos

Referência para criar locators, pages, navigation e suites seguindo o padrão do projeto.
Baseado no módulo `commands` como implementação de referência.

---

## Estrutura de Arquivos

```
modules/
  {modulo}/
    base_{modulo}.resource          ← único import nas suites
    locators/
      {tela}_locators.yaml          ← 1 arquivo por tela/dialog
    pages/
      {tela}_page.resource          ← 1 arquivo por tela/dialog
    navigation/
      {modulo}_navigation.resource  ← composição de pages

tests/
  regression/
    {modulo}/
      {modulo}.robot                ← suite de testes
```

---

## 1. Locators (YAML)

### Regras

- **1 arquivo por tela ou dialog**, nomeado `{tela}_locators.yaml`
- **1 namespace raiz** por arquivo (chave YAML de nível 0), mesmo nome do arquivo sem `_locators`
- Cada locator tem **comentário inline** explicando o que é
- **Sem `/` nem espaços** nos nomes das chaves — Robot Framework não resolve `${obj.chave/com_barra}`
- Prefixos obrigatórios para locators com `(//` (XPath indexado) — use `xpath=(...)[n]`
- `//` simples e `accessibility id=` são detectados automaticamente

### Estratégia de localização (prioridade)

| Estratégia | Quando usar | Exemplo |
|---|---|---|
| `xpath=//*[@resource-id='TestTag_0']` | Elemento tem `testTag` no Compose | `confirm: xpath=//*[@resource-id='LoginDialogButton_0']` |
| `accessibility id=Texto` | `contentDescription` definido | `back: accessibility id=Voltar` |
| `//android.view.View[@content-desc="Texto"]` | contentDesc sem prefixo | `menu: //android.view.View[@content-desc="Menu"]` |
| `xpath=//*[@text='Texto']` | Sem testTag — fallback por texto | `confirm: xpath=//*[@text='Confirmar']` |
| `xpath=(//*[...])[n]` | Múltiplos elementos iguais, selecionar por índice | `toggle: xpath=(//android.widget.TextView[@text="Item"])[2]` |

### Cabeçalho padrão

```yaml
# Locators — Tela: {Nome da Tela} ({NomeCompose})
# testTag via testTagsAsResourceId=true → xpath @resource-id
# contentDescription → accessibility id

{namespace}:
  # {Descrição do elemento}
  {chave}: {locator}
```

### Exemplo completo

```yaml
# Locators — Tela: Dialog Login (LoginDialog)
# testTag via testTagsAsResourceId=true → xpath @resource-id
# contentDescription → accessibility id

login:
  # Campo usuário (BasicOutlinedField_0)
  username: xpath=//*[@resource-id='LoginDialogBasicOutlinedField_0']//android.widget.EditText

  # Campo senha (BasicOutlinedField_1)
  password: xpath=//*[@resource-id='LoginDialogBasicOutlinedField_1']//android.widget.EditText

  # Ícone mostrar/ocultar senha (contentDescription="Mostrar senha")
  toggle_password: accessibility id=Mostrar senha

  # Botão confirmar login
  confirm: xpath=//*[@resource-id='LoginDialogButton_0']

  # Botão cancelar
  cancel: xpath=//*[@resource-id='LoginDialogOutlinedButton_0']
```

### Quando não há testTags

Documente o GAP no cabeçalho e use texto como fallback:

```yaml
# Locators — Dialog: Confirmar Ação (ConfirmDialog)
# Sem testTags — usa texto (GAP: solicitar tags ao dev)

confirm_dialog:
  # Texto de confirmação
  question: xpath=//*[contains(@text,'Deseja realmente')]

  # Botão "Sim"
  yes: xpath=//*[@text='Sim']

  # Botão "Não"
  no: xpath=//*[@text='Não']
```

---

## 2. Pages (Resource)

### Regras

- **1 arquivo por tela ou dialog**, nomeado `{tela}_page.resource`
- Keywords são **ações atômicas** — cada uma faz exatamente uma coisa
- Nomenclatura: `{Modulo} - {Tela} - {Ação}`
- **Sem `[Documentation]`** em keywords individuais — o nome deve ser autodescritivo
- Sempre importar `common_keywords.resource` (nunca AppiumLibrary diretamente)
- `Close Keyboard` após todo `Wait Visible And Input Text`

### Estrutura padrão

```robotframework
*** Settings ***
Documentation    Ações atômicas — {Nome da Tela} ({NomeCompose})
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
{Modulo} - {Tela} - {Ação}
    {keyword do common_keywords}    ${namespace.chave}
```

### Keywords disponíveis em `common_keywords.resource`

| Situação | Keyword | Argumentos opcionais |
|---|---|---|
| Clicar em elemento | `Wait Visible And Click Element` | `timeout=` |
| Clicar com retry (stale element) | `Wait Visible And Click Element With Retry` | `max_retries=3` |
| Clicar após scroll | `Swipe Until Visible And Click Element` | `direction=up\|down`, `max_swipes=5`, `swipe_timeout=3s` |
| Long press | `Wait Visible And Long Press Element` | `duration=2000ms` |
| Clicar N vezes | `Click Element Multiple Times` | — |
| Digitar texto (paste) | `Wait Visible And Input Text` | — |
| Digitar caractere a caractere | `Wait Visible And Input Text Pause` | `delay=0.05s` |
| Verificar visibilidade | `Wait Until Element Is Visible` | `timeout=` |
| Aguardar desaparecer | `Wait For Element To Disappear` | `timeout=` |
| Fechar teclado | `Close Keyboard` | — |
| Normalizar dígitos | `Normalize Digits` | — |

### Ações de verificação — nomenclatura

```robotframework
# Verificar que tela/dialog está visível
{Modulo} - {Tela} - Verify Visible
    Wait Until Element Is Visible    ${namespace.verify}

# Verificar campo ou mensagem específica
{Modulo} - {Tela} - Verify {Campo}
    Wait Until Element Is Visible    ${namespace.{campo}}
```

### Ações que requerem scroll — quando usar `Swipe Until Visible And Click Element`

Use quando o elemento pode estar **fora da área visível** dependendo do DPI do dispositivo:
- Itens no final de menus laterais (drawers)
- Botões abaixo do fold em listas
- Elementos em dialogs com scroll

```robotframework
Commands - Menu Table - Click Manage Service Charge
    Swipe Until Visible And Click Element    ${menu_table.manage_service_charge}

Commands - Manage Service Charge - Active/Deactive
    Swipe Until Visible And Click Element    ${manage_service_charge.toggle_button}    direction=UP    max_swipes=2
```

### Exemplo completo

```robotframework
*** Settings ***
Documentation    Ações atômicas — Dialog Login (LoginDialog)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
{Modulo} - Login - Input Username
    [Arguments]    ${username}
    Wait Visible And Input Text    ${login.username}    ${username}
    Close Keyboard

{Modulo} - Login - Input Password
    [Arguments]    ${password}
    Wait Visible And Input Text    ${login.password}    ${password}
    Close Keyboard

{Modulo} - Login - Click Confirm
    Wait Visible And Click Element    ${login.confirm}

{Modulo} - Login - Click Cancel
    Wait Visible And Click Element    ${login.cancel}

{Modulo} - Login - Verify Visible
    Wait Until Element Is Visible    ${login.username}
```

---

## 3. Navigation (Resource)

### Regras

- **1 arquivo por módulo**: `{modulo}_navigation.resource`
- Importa **todos os pages** do módulo
- Keywords são **fluxos compostos** de page keywords
- Nomenclatura: `{Modulo} - Navigate To {Destino}`
- Seções separadas por comentário `# ===`
- Keywords com `[Documentation]` são permitidas aqui (ao contrário dos pages)

### Estrutura padrão

```robotframework
*** Settings ***
Documentation    Fluxos de navegação do módulo {Modulo} — composição de page keywords.
...
...    Nomenclatura: {Modulo} - Navigate To <Destino>
...    Dependências: pages abaixo + locators carregados via base_{modulo}.resource
Resource    ../pages/{tela1}_page.resource
Resource    ../pages/{tela2}_page.resource


*** Keywords ***
# =============================================================================
# NAVEGAÇÃO — {SEÇÃO}
# =============================================================================

{Modulo} - Navigate To {Destino}
    [Documentation]    {Descrição do fluxo}.
    {Modulo} - {Tela} - {Ação}
    {Modulo} - {Tela} - {Ação}
```

### Padrões de navegação com argumento condicional

```robotframework
# ✅ Keyword com argumento — nome sem sufixo descritivo
{Modulo} - Navigate To Cancel Item
    [Arguments]    ${cancel_reason}
    {Modulo} - {Tela} - Click Menu
    {Modulo} - {Tela} - Click Cancel
    {Modulo} - {Tela} - Input Reason    ${cancel_reason}
    {Modulo} - {Tela} - Click Confirm

# ✅ Variante sem argumento — sufixo no nome
{Modulo} - Navigate To Cancel Item no-reason
    {Modulo} - {Tela} - Click Menu
    {Modulo} - {Tela} - Click Cancel
    {Modulo} - {Tela} - Click Confirm
```

> O sufixo (`no-reason`, `with-confirmation`, etc.) **só é adicionado à variante alternativa**. A variante principal recebe o argumento normalmente e mantém o nome limpo.

### Padrão com IF para método variável

```robotframework
{Modulo} - Navigate To Pay
    [Documentation]    Realiza o pagamento. Métodos suportados: money, pixoff
    [Arguments]    ${payment_method}
    {Modulo} - {Tela} - Click Menu
    {Modulo} - Invoice - Click Invoice
    IF    '${payment_method}' == 'money'
        {Modulo} - Invoice - Click Payment Money
    ELSE IF    '${payment_method}' == 'pixoff'
        {Modulo} - Invoice - Click Payment Pixoff
    END
    {Modulo} - Invoice - Click Confirm
    {Modulo} - Panel - Verify Panel Visible
```

---

## 4. Base Resource

### Regras

- **1 arquivo por módulo**: `base_{modulo}.resource`
- É o **único arquivo que as suites importam**
- Importa: `base.resource` global + todos os YAMLs de locators + navigation

### Estrutura padrão

```robotframework
*** Settings ***
Documentation    Base do módulo {Modulo} — único import necessário nas suites.
...
...    Importa: base global + locators (1 YAML por tela) + navigation do módulo.
...    Navigation importa os pages transitivamente.
...
...    Hierarquia de imports:
...    {modulo}.robot
...      └── base_{modulo}.resource  ← você está aqui
...            ├── base.resource (libs, helpers, open_app, setup)
...            ├── locators/*.yaml (1 arquivo por tela)
...            └── navigation/{modulo}_navigation.resource
...                  └── pages/*.resource (1 arquivo por tela)

# --- Base global ---
Resource    ../../resources/base/base.resource

# --- Locators do módulo (1 YAML por tela) ---
Variables    locators/{tela1}_locators.yaml
Variables    locators/{tela2}_locators.yaml

# --- Navigation do módulo (importa pages transitivamente) ---
Resource    navigation/{modulo}_navigation.resource
```

---

## 5. Suite de Testes

### Regras

- Arquivo em `tests/regression/{modulo}/{modulo}.robot`
- Importa **apenas** o `base_{modulo}.resource`
- `Suite Setup/Teardown` e `Test Setup/Teardown` usam os defaults do projeto
- Test cases compostos **exclusivamente** de navigation keywords
- Sem lógica nos test cases — toda lógica fica na navigation

### Estrutura padrão

```robotframework
*** Settings ***
Documentation    Suite de regressão — módulo {Modulo}
...
...    {Descrição do que a suite cobre}.
...    Pré-condição: {estado inicial esperado do app}.
Resource         ../../../modules/{modulo}/base_{modulo}.resource
Suite Setup      Suite Setup Default
Suite Teardown   Suite Teardown Default
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default


*** Variables ***
${VARIAVEL_SUITE}    valor padrão


*** Test Cases ***
{Modulo} - {Descricao do cenario}
    [Documentation]    {Descrição do que o teste verifica}.
    [Tags]    @allure.label.severity:{critical|normal|minor}    regression    {modulo}    {tag_funcionalidade}
    {Modulo} - Navigate To {Passo 1}    ${arg}
    {Modulo} - Navigate To {Passo 2}
    {Modulo} - Navigate To {Passo N}
```

### Severidades Allure

| Severidade | Quando usar |
|---|---|
| `critical` | Fluxo principal de negócio (ex: faturamento, pagamento) |
| `normal` | Funcionalidade secundária relevante (ex: adiantamento, split) |
| `minor` | Casos de borda, cenários alternativos |

---

## 6. Checklist de implementação

Ao migrar ou criar um módulo novo, siga esta ordem:

- [ ] **Locators**: criar 1 YAML por tela, validar que nenhuma chave tem `/` ou espaço
- [ ] **Pages**: criar 1 resource por tela, garantir `Close Keyboard` após inputs
- [ ] **Base**: criar `base_{modulo}.resource` importando todos os YAMLs e a navigation
- [ ] **Navigation**: criar `{modulo}_navigation.resource` importando todos os pages
- [ ] **Suite**: criar `{modulo}.robot` importando apenas o base
- [ ] **Validar nomenclatura**: pages sem `[Documentation]` individual, navigation com `[Documentation]`
- [ ] **Validar chamadas**: toda chamada no `.robot` usa keywords de navigation; toda chamada na navigation usa keywords de pages

---

## 7. Armadilhas comuns

| Problema | Causa | Solução |
|---|---|---|
| `AttributeError: {chave}` na resolução de variável | Chave YAML com `/` (ex: `active/deactive`) | Renomear para `toggle`, `active_deactive`, etc. |
| `ValueError: Element locator with prefix '(//...'` | XPath indexado sem prefixo `xpath=` | Adicionar `xpath=` antes de `(//` |
| `Keyword 'Swipe' expected 0 non-named arguments` | Appium novo exige args nomeados | `Swipe    start_x=...    start_y=...    end_x=...    end_y=...    duration=500ms` |
| `No keyword with name 'X' found` | Nome na navigation não bate com nome no page | Alinhar nomes exatamente |
| Swipe não executado, elemento off-screen | `Wait Until Element Is Visible` retorna PASS para elemento fora da viewport | Usar `Swipe Until Visible And Click Element` em vez de `Wait Visible And Click Element` |
| Teclado não fecha entre campos | `Close Keyboard` ausente após `Wait Visible And Input Text` | Adicionar `Close Keyboard` após todo input |
