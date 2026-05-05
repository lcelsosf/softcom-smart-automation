# Navigation Analysis

> **Nota:** Este relatório foi gerado com base no projeto refatorado `softcom-smart-automation`.
> O projeto legado (`shield-softcom-smart-automation`) não estava acessível no momento da análise.
> Quando o acesso ao legado estiver disponível, execute novamente o prompt em
> `docs/analyze_navigations_prompt.md` para gerar a análise completa com as keywords reais.

---

## Resumo

| Arquivo | Total keywords | ✅ Corretas | ⚠️ Ajuste | ❌ Incorretas |
| ------- | -------------- | ----------- | --------- | ------------- |
| *(legado não acessível)* | — | — | — | — |

---

## Estado atual — projeto refatorado

Os módulos abaixo ainda **não possuem arquivos de navigation** criados.
Eles precisam ser criados a partir da análise do legado ou do zero seguindo
as regras da arquitetura alvo.

| Módulo | Caminho esperado | Status |
| ------ | ---------------- | ------ |
| default | `modules/default/navigation/default_navigation.resource` | ⏳ Não criado |
| pdv | `modules/pdv/navigation/pdv_navigation.resource` | ⏳ Não criado |
| commands | `modules/commands/navigation/commands_navigation.resource` | ⏳ Não criado |
| prevenda | `modules/prevenda/navigation/prevenda_navigation.resource` | ⏳ Não criado |
| mini_mercado | `modules/mini_mercado/navigation/mini_mercado_navigation.resource` | ⏳ Não criado |

---

## Critérios de avaliação

### ✅ Navigation CORRETO

- Compõe 2 ou mais ações atômicas em um fluxo de negócio
- Chama keywords de `pages/` — nunca interage diretamente com locators
- Nome descreve o destino ou o fluxo: `Navigate To X`, `Complete X Flow`
- Não duplica lógica já existente em outro navigation

### ❌ Navigation INCORRETO

- Contém ações atômicas isoladas (`Wait Visible And Click`, `Input Text` sozinhos)
- Importa `AppiumLibrary` diretamente
- Duplica keywords de `pages/` com outro nome
- Mistura responsabilidades (navigation + assertion)
- Nome genérico sem indicar módulo ou destino

---

## Exemplo de navigation correto

Veja `documentation/examples/example_navigation.resource` para um template completo.

---

## Plano de movimentação (após análise do legado)

Quando o acesso ao projeto legado estiver disponível:

1. Executar `find shield-softcom-smart-automation -path "*/navigation/*.resource" | sort`
2. Ler todos os arquivos encontrados
3. Para cada keyword:
   - Avaliar contra os critérios acima
   - Classificar como ✅ / ⚠️ / ❌
4. Aplicar ajustes nas keywords ⚠️
5. Mover keywords ❌ para o `pages/` correto
6. Copiar keywords ✅ para `modules/<modulo>/navigation/`
7. Atualizar o `base_<modulo>.resource` com o import do novo arquivo de navigation
