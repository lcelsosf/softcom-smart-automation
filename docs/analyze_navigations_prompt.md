# Prompt — Análise de navigations + geração de exemplos

Cole este prompt no Cursor, Windsurf ou Claude Code com acesso a ambos os projetos.

---

````
Você é um especialista em automação mobile com Robot Framework + Appium.

Você tem acesso a dois projetos:
- Projeto legado:     shield-softcom-smart-automation   (estado atual)
- Projeto refatorado: shield-smart-test-automation      (arquitetura alvo)

Execute as tarefas abaixo em ordem.

═══════════════════════════════════════════════════════════════
TAREFA 0 — Concluir Fase 1 (pontos 4, 5 e 6)
═══════════════════════════════════════════════════════════════

Execute esta tarefa ANTES das demais. Só avance para a Tarefa 1
após confirmar que os 3 pontos abaixo estão concluídos.

## 0.1 DevicesConfig.py refatorado — Ponto 4

Leia o arquivo atual:
shield-smart-test-automation/resources/libraries/DevicesConfig.py

Refatore mantendo os métodos existentes e adicionando:

1. Migrar expansão de variáveis de ambiente:
   - Substituir sintaxe customizada %{VAR=default} por os.getenv("VAR", default)
   - Chamar load_dotenv() no __init__ da classe

2. Adicionar método get_tag_from_udid(udid: str) -> str:
   - Percorre devices.yaml comparando o UDID expandido de cada tag
   - Retorna a tag correspondente ou "default" se não encontrar
   - Usado pelo Close Keyboard em common_keywords.resource para eliminar
     a dependência de variáveis ${*_UDID} hardcoded

3. Adicionar método get_device_config(tag: str) -> object:
   - Retorna objeto (ou dict) com: system_port, appium_server, app_package
   - app_package usa default_app_package se não definido na tag
   - Usado pelo open_app.resource para abrir a sessão sem depender de
     variáveis globais de configuração

Métodos públicos obrigatórios após refatoração:
- get_device_udid(tag, default="emulator-5554") -> str
- get_device_config(tag) -> objeto com system_port, appium_server, app_package
- get_keyboard_close_method(tag) -> str
- get_tag_from_udid(udid) -> str

Valide após implementar:
```bash
cd shield-smart-test-automation
uv run python -c "
from resources.libraries.DevicesConfig import DevicesConfig
dc = DevicesConfig()
print(dc.get_device_config('cielo'))
print(dc.get_tag_from_udid('emulator-5554'))
print(dc.get_keyboard_close_method('clover'))
"
````

## 0.2 devices.yaml atualizado — Ponto 5

Leia o arquivo atual:
shield-smart-test-automation/resources/data/devices.yaml

Para cada adquirente:

1. Migrar sintaxe de UDID de %{VAR=default} para ${VAR}
2. Adicionar system_port conforme tabela abaixo
3. Adicionar appium_server: "http://localhost:4723"
4. Garantir que app_package está explícito ou herda default_app_package

Portas por adquirente:
cielo=8200, rede=8202, rede_n960k=8204, getnet/getnet_dx8000=8206,
getnet_p2=8208, getnet_p3=8210, stone=8212, pagbank=8214,
pagbank_a11=8216, fiserv=8218, sipag_p2=8220, sipag_x990=8222,
sipag_dx8000=8224, safra=8226, mercadopago=8228,
quickpay/quickpay_a910=8230, clover=8232

Valide o YAML após edição:

```bash
python3 -c "import yaml; d=yaml.safe_load(open('resources/data/devices.yaml')); print(f'{len(d[\"devices\"])} devices carregados')"
```

## 0.3 pabot_configs/\*.args simplificados — Ponto 6

Liste os .args existentes:

```bash
ls shield-smart-test-automation/pabot_configs/*.args
```

Para cada arquivo .args encontrado:

1. Substituir todo o conteúdo por apenas: --variable DEVICE_TAG:<tag>
2. Remover SYSTEM_PORT, APPIUM_SERVER_URL e qualquer outra variável

Criar os .args que ainda não existem para os adquirentes cadastrados
no devices.yaml seguindo a mesma estrutura.

Estrutura obrigatória de cada arquivo:
--variable DEVICE_TAG:<tag>

Valide a cobertura após edição:

```bash
echo "=== .args existentes ===" && ls pabot_configs/*.args
echo "=== tags no devices.yaml ===" && python3 -c "
import yaml
d = yaml.safe_load(open('resources/data/devices.yaml'))
for tag in d['devices']: print(tag)
"
```

Ao concluir a Tarefa 0, exiba no chat:

- ✅ DevicesConfig.py — métodos implementados e validados
- ✅ devices.yaml — N adquirentes com system_port e appium_server
- ✅ pabot_configs/ — N arquivos .args simplificados

Só então avance para a TAREFA 1.

═══════════════════════════════════════════════════════════════
TAREFA 1 — Gerar exemplos para implementação manual (Fase 3)
═══════════════════════════════════════════════════════════════

Crie os seguintes arquivos de exemplo em
shield-smart-test-automation/documentation/examples/

## 1.1 base_default.resource — template de base de módulo

Gere um base_default.resource completo para o módulo default seguindo
esta estrutura obrigatória:

**_ Settings _**
Documentation Base do módulo default — único import necessário nas suites.
... Importa: base global + locators + pages + navigation do módulo.

Resource ../../resources/base/base.resource

# Locators do módulo

Variables ./locators/<arquivo>.yaml # via locators_loader.py

# Pages do módulo — uma linha por arquivo de page encontrado

Resource ./pages/<tela>\_page.resource

# Navigation do módulo — uma linha por arquivo de navigation encontrado

Resource ./navigation/<modulo>\_navigation.resource

Regras:

- Nunca importar AppiumLibrary diretamente — já vem pelo base.resource
- Nunca importar helpers diretamente — já vem pelo base.resource
- Listar TODOS os pages e navigations do módulo default encontrados
  nos arquivos do projeto legado

## 1.2 default_suite.robot — template de suite adaptada

Gere um default_suite.robot de exemplo seguindo esta estrutura:

**_ Settings _**
Documentation Suite de regressão — módulo default
Resource ../../modules/default/base_default.resource
Suite Setup Open App
Suite Teardown Close App
Test Setup Test Setup Default
Test Teardown Test Teardown Default

**_ Test Cases _**
<Cenário real extraído do projeto legado>
[Tags] @allure.label.severity:critical regression default
<Keywords de navigation ou page reais do módulo>

Regras:

- Importar APENAS o base_default.resource
- Usar casos de teste reais encontrados no projeto legado como exemplo
- Aplicar tags Allure em todos os casos

## 1.3 example_navigation.resource — template de navigation

Gere um arquivo de navigation de exemplo para o módulo default
usando um fluxo real encontrado no projeto legado como base.

Regras obrigatórias para navigation:

- Contém APENAS keywords de fluxo composto (2+ ações encadeadas)
- NUNCA contém ações atômicas (click, input, wait isolados)
- NUNCA importa AppiumLibrary diretamente
- Nomenclatura: Default - Navigate To <Destino>
- Cada keyword documenta o fluxo que executa

═══════════════════════════════════════════════════════════════
TAREFA 2 — Analisar navigations do projeto legado (Fase 3, ponto 14)
═══════════════════════════════════════════════════════════════

## 2.1 Varredura

Execute o comando abaixo no projeto legado e leia TODOS os arquivos
de navigation encontrados:

find shield-softcom-smart-automation -path "_/navigation/_.resource" | sort

Para cada arquivo lido, extraia:

- Nome do arquivo e caminho
- Lista de todas as keywords definidas
- O que cada keyword faz (baseado no conteúdo real)

## 2.2 Avaliação por keyword

Para cada keyword encontrada nos arquivos de navigation, avalie:

### Critérios de um navigation CORRETO

✅ Compõe 2 ou mais ações atômicas em um fluxo de negócio
✅ Chama keywords de pages/ — nunca interage diretamente com locators
✅ Nome descreve o destino ou o fluxo: "Navigate To X", "Complete X Flow"
✅ Não duplica lógica já existente em outro navigation

### Critérios de um navigation INCORRETO

❌ Contém ações atômicas isoladas (Wait Visible And Click, Input Text sozinhos)
❌ Importa AppiumLibrary diretamente
❌ Duplica keywords de pages/ com outro nome
❌ Mistura responsabilidades (parte navigation, parte verificação/assertion)
❌ Nome genérico sem indicar módulo ou destino

## 2.3 Relatório de análise

Gere o arquivo:
shield-smart-test-automation/documentation/NAVIGATION_ANALYSIS.md

Com a seguinte estrutura:

# Navigation Analysis

## Resumo

| Arquivo | Total keywords | ✅ Corretas | ⚠️ Ajuste | ❌ Incorretas |
| ------- | -------------- | ----------- | --------- | ------------- |

## Análise por arquivo

### `caminho/do/arquivo.resource`

#### ✅ Keywords corretas — prontas para mover

| Keyword | O que faz |
| ------- | --------- |

#### ⚠️ Keywords que precisam de ajuste antes de mover

Para cada uma:

- **Keyword:** nome
- **Problema:** descrição do problema
- **Sugestão:** como corrigir

#### ❌ Keywords que devem ser movidas para pages/

Para cada uma:

- **Keyword:** nome
- **Motivo:** por que pertence a pages/ e não a navigation/
- **Destino sugerido:** qual arquivo de page recebe

## Plano de movimentação

Lista ordenada de ações para mover os navigations para modules/<modulo>/navigation/
após os ajustes necessários.

═══════════════════════════════════════════════════════════════
TAREFA 3 — Gerar README.md do projeto (Fase 4, ponto 18)
═══════════════════════════════════════════════════════════════

Gere o arquivo shield-smart-test-automation/README.md completo com
as seguintes seções:

---

# Shield Smart Test Automation

Breve descrição do projeto, stack e objetivo.

---

## Pré-requisitos

- Python 3.11+
- uv (gerenciador de pacotes)
- Node.js (para Appium)
- Android SDK (adb no PATH)
- Appium Server

Instruções de instalação de cada dependência.

---

## Instalação

\`\`\`bash

# Clonar o repositório

git clone <url>
cd shield-smart-test-automation

# Instalar dependências com uv

uv sync

# Copiar e preencher variáveis de ambiente

cp .env.example .env
\`\`\`

---

## Configuração

### Devices

Todos os devices são configurados em `resources/data/devices.yaml`.
Cada adquirente tem: udid, app_package, keyboard_close, system_port, appium_server.

### Variáveis de ambiente (.env)

Listar todas as variáveis do .env.example com descrição de cada uma.

---

## Executando os testes

### Execução interativa (recomendado)

\`\`\`bash
chmod +x run_tests.sh
./run_tests.sh
\`\`\`
Descrever o fluxo do menu interativo.

### Execução manual — device único

\`\`\`bash
uv run robot -v DEVICE_TAG:cielo tests/regression/default/default.robot
\`\`\`

### Execução paralela — múltiplos devices

\`\`\`bash
uv run pabot --processes 2 \
 --argumentfile1 pabot_configs/cielo.args \
 --argumentfile2 pabot_configs/clover.args \
 --outputdir pabot_results/ \
 --listener allure_robotframework:allure-report/ \
 tests/
\`\`\`

### Relatório Allure

\`\`\`bash
uv run allure generate allure-report/ -o allure-report/html --clean
uv run allure open allure-report/html
\`\`\`

---

## Estrutura do projeto

Árvore de pastas comentada com a responsabilidade de cada camada.

---

## Arquitetura em camadas

Explicar em prosa:

1. Camada global (resources/) — compartilhada entre todos os módulos
2. Camada modular (modules/<modulo>/) — auto-contida por módulo
3. Suites (tests/) — orquestram os fluxos

Incluir diagrama ASCII do fluxo de imports:
suite.robot → base\_<modulo>.resource → base.resource → libs/helpers

---

## Adicionando um novo adquirente

Passo a passo:

1. Adicionar entrada em `resources/data/devices.yaml`
2. Adicionar variável no `.env` e `.env.example`
3. Criar `pabot_configs/<tag>.args`
4. Verificar se o `app_package` é novo (adicionar locators se necessário)

---

## Adicionando um novo módulo

Passo a passo:

1. Criar pasta `modules/<modulo>/` com subpastas `locators/`, `pages/`, `navigation/`
2. Criar `modules/<modulo>/base_<modulo>.resource`
3. Criar pasta `tests/regression/<modulo>/` e a suite `.robot`
4. Seguir as regras de nomenclatura do CLAUDE.md

---

## Adicionando novos testes

Regras:

- Locators em YAML em `modules/<modulo>/locators/`
- Ações atômicas em `modules/<modulo>/pages/`
- Fluxos compostos em `modules/<modulo>/navigation/`
- Caso de teste na suite importa apenas keywords de navigation ou pages

---

## Linting e qualidade

\`\`\`bash

# Rodar robocop

uv run robocop resources/ modules/ tests/

# Formatação com robotframework-tidy

uv run robotidy resources/ modules/ tests/
\`\`\`

---

## Contribuindo

Referência ao CLAUDE.md para regras arquiteturais completas.
Regras de branch, PR e commit.

---

═══════════════════════════════════════════════════════════════
TAREFA 4 — Atualizar CLAUDE.md (Fase 4, ponto 18)
═══════════════════════════════════════════════════════════════

No arquivo shield-smart-test-automation/CLAUDE.md faça as seguintes
atualizações:

1. Na seção "19. Arquivos já refatorados":
   - Adicionar todos os arquivos concluídos nas fases 1, 2 e 3
   - Remover a lista "Próximos a refatorar"
   - Substituir por "Estado final da arquitetura: implementada"

2. Na seção "18. Plano de migração":
   - Marcar todos os itens concluídos com ✅
   - Adicionar data de conclusão em cada item

3. Adicionar nova seção ao final "20. Histórico de refatoração":
   - Data de início
   - Principais decisões tomadas
   - Arquivos eliminados (variables.resource, device.resource, common/)
   - Arquivos renomeados (validation.robot → validation.resource)
   - Keywords renomeadas (Wait Until Element Is Not Visible → Wait For Element To Disappear, etc.)

Não altere nenhuma outra seção do CLAUDE.md.

═══════════════════════════════════════════════════════════════
INSTRUÇÕES FINAIS
═══════════════════════════════════════════════════════════════

- Execute as tarefas em ordem: 1 → 2 → 3 → 4
- Leia os arquivos reais antes de gerar qualquer conteúdo
- Para a Tarefa 2, leia TODOS os arquivos de navigation do projeto legado
  antes de escrever o NAVIGATION_ANALYSIS.md
- Para o README, use informações reais do projeto (adquirentes, módulos,
  variáveis de ambiente reais do .env.example)
- Ao final, exiba no chat:
  - Arquivos gerados/modificados
  - Total de keywords de navigation analisadas
  - Quantidade: corretas / precisam ajuste / mover para pages
  - Próximo passo sugerido

```

```
