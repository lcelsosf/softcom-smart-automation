# Guia de Construção de Keywords do Módulo PDV

Este guia documenta como construir novas keywords para o módulo PDV com base na estrutura real já implementada no projeto.

O objetivo é orientar a análise dos fluxos informados no terminal e indicar quais arquivos devem ser alterados para transformar esses fluxos em keywords reutilizáveis, fluxos completos e cenários na suíte principal.

## Estrutura atual do módulo

A estrutura do módulo PDV está concentrada em:

```text
modules/pdv
```

Arquivos existentes hoje:

```text
modules/pdv/base_pdv.resource
modules/pdv/data/pdv_data.yml
modules/pdv/locators/homeLocators.yml
modules/pdv/locators/ordersLocators.yml
modules/pdv/locators/checkoutLocators.yml
modules/pdv/pages/home_page.resource
modules/pdv/pages/orders_page.resource
modules/pdv/pages/checkout_page.resource
modules/pdv/navigation/pdv_navigation.resource
modules/pdv/navigation/pdv_complete_streams.resource
tests/regression/pdv/pdv.robot
```

## Hierarquia correta de imports

A suíte principal importa apenas a base do módulo:

```robotframework
Resource    ../../../modules/pdv/base_pdv.resource
```

A base do módulo centraliza os imports necessários:

```text
pdv.robot
  └── modules/pdv/base_pdv.resource
        ├── resources/base/base.resource
        ├── locators + dados via locators_loader.py
        └── navigation/pdv_complete_streams.resource
              └── navigation/pdv_navigation.resource
                    └── pages/*.resource
```

Ponto importante: a suíte `pdv.robot` não deve importar diretamente pages, navigation ou locators do módulo. Ela deve usar somente `base_pdv.resource`.

## Responsabilidade de cada arquivo

| Arquivo | Responsabilidade |
| --- | --- |
| `modules/pdv/base_pdv.resource` | Base única do módulo PDV. Importa a base global, carrega locators/dados e expõe os fluxos completos. |
| `modules/pdv/data/pdv_data.yml` | Armazena massas de dados reutilizadas nos testes do PDV. |
| `modules/pdv/locators/*.yml` | Armazena os elementos do app separados por tela/contexto. |
| `modules/pdv/pages/*.resource` | Contém PageObjects/actions atômicas baseadas nos locators. |
| `modules/pdv/navigation/pdv_navigation.resource` | Compõe PageObjects em passos de navegação reutilizáveis. |
| `modules/pdv/navigation/pdv_complete_streams.resource` | Compõe navigations e pages em fluxos completos de negócio. |
| `tests/regression/pdv/pdv.robot` | Suíte principal que chama as keywords de fluxo completo. |

## Base do módulo PDV

Arquivo:

```text
modules/pdv/base_pdv.resource
```

Hoje este arquivo:

- importa a base global `resources/base/base.resource`;
- carrega locators e dados via `resources/libraries/locators_loader.py`;
- carrega os arquivos:
  - `modules/pdv/locators/homeLocators.yml`;
  - `modules/pdv/locators/ordersLocators.yml`;
  - `modules/pdv/locators/checkoutLocators.yml`;
  - `modules/pdv/data/pdv_data.yml`;
- importa `navigation/pdv_complete_streams.resource`.

Exemplo atual de carregamento:

```robotframework
Variables    ../../resources/libraries/locators_loader.py    modules/pdv/locators/homeLocators.yml    modules/pdv/locators/ordersLocators.yml    modules/pdv/locators/checkoutLocators.yml    modules/pdv/data/pdv_data.yml    ${DEVICE_TAG}
Resource     navigation/pdv_complete_streams.resource
```

### Quando alterar este arquivo

Altere `base_pdv.resource` apenas quando:

- criar um novo arquivo de locator `.yml` que precise ser carregado pelo módulo;
- criar um novo arquivo de dados que precise ser carregado pelo módulo;
- mudar a estrutura de imports dos fluxos completos.

Não é necessário importar pages diretamente na base, pois elas são importadas pela navigation.

## Dados de teste

Arquivo:

```text
modules/pdv/data/pdv_data.yml
```

Atualmente existem dados agrupados em:

```yaml
products:
clients:
payment_data:
```

Exemplos de dados já implementados:

- produtos comuns:
  - `${products.product_1}`;
  - `${products.product_2}`;
- produto por referência e código de barras:
  - `${products.product_1_reference}`;
  - `${products.product_1_barcode}`;
- produtos específicos para fluxos:
  - `${products.fractional}`;
  - `${products.price_table}`;
  - `${products.grid}`;
  - `${products.composition}`;
  - `${products.promotion}`;
  - `${products.promotion_disable}`;
  - `${products.discount}`;
- variações por código de barras:
  - `${products.barcode_variation_1}`;
  - `${products.barcode_variation_2}`;
- cliente:
  - `${clients.client_credit}`;
- dados de pagamento:
  - `${payment_data.bank_slip_calendar_day}`.

### Quando alterar este arquivo

Altere `pdv_data.yml` quando o novo fluxo precisar de massa de dados específica, por exemplo:

- novo produto;
- novo cliente;
- código de barras;
- dia de vencimento;
- valor de desconto/acréscimo reutilizável;
- qualquer dado que não deve ficar fixo dentro da keyword.

Evite hardcode em keywords quando o dado representar massa de teste do cenário.

## Locators

Os locators ficam em:

```text
modules/pdv/locators/*.yml
```

Atualmente existem três arquivos principais.

### `homeLocators.yml`

Responsável pelos elementos da tela inicial e tela de status do pedido.

Namespaces existentes:

```yaml
home:
sync:
logoff:
orders_status:
```

Exemplos de elementos mapeados:

- card Novo Pedido;
- Lista de Pedidos;
- Clientes;
- Sincronizar Dados;
- Configurações;
- Logoff;
- confirmação de logoff;
- botões da tela de status do pedido, como Reimprimir, Novo Pedido, Compartilhar e Tela Inicial.

### `ordersLocators.yml`

Responsável pelos elementos de pedido, carrinho e modais relacionados.

Namespaces existentes:

```yaml
orders:
quantity_modal:
order_remove_dialog:
order_cancel_dialog:
cart:
client_modal:
discount_modal:
item_details:
price_table_modal:
price_table_change_dialog:
cart_item_edit_modal:
```

Este arquivo cobre, entre outros pontos:

- busca de produto;
- seleção de produto por nome;
- seleção do primeiro card de produto;
- limpeza de pesquisa;
- conferência do pedido;
- botão de carrinho;
- tabela de preço;
- modal de quantidade;
- remoção de item;
- cancelamento de pedido;
- carrinho;
- edição de cliente;
- desconto/acréscimo;
- badge de promoção;
- estoque;
- edição de item no carrinho;
- alteração de preço unitário.

### `checkoutLocators.yml`

Responsável pelos elementos da tela de checkout/pagamento.

Namespaces existentes:

```yaml
Checkout:
payment_value_modal:
bank_slip:
```

Este arquivo cobre:

- tela de pagamento;
- seleção de método de pagamento por nome;
- modal de valor do pagamento;
- teclado numérico do modal;
- confirmação/cancelamento do valor;
- campos específicos de boleto bancário;
- parcelas;
- prazo;
- calendário;
- seleção de dia no calendário;
- finalização da venda.

### Boas práticas para locators

- Manter os locators no arquivo correspondente à tela/contexto.
- Usar namespaces coerentes com a tela ou modal.
- Para elementos dinâmicos, seguir o padrão já existente com placeholders, por exemplo:
  - `PRODUCT_NAME`;
  - `CLIENT_NAME`;
  - `METHOD_NAME`;
  - `DAY_NUMBER`;
  - `DIGIT`.
- Substituir placeholders nas PageObjects com `Replace String`.
- Se um novo arquivo `.yml` for criado, adicioná-lo em `base_pdv.resource` no carregamento do `locators_loader.py`.

## Pages / PageObjects

Os PageObjects ficam em:

```text
modules/pdv/pages/*.resource
```

Eles representam ações atômicas de tela. Devem interagir diretamente com os locators e helpers, sem representar um fluxo de negócio inteiro.

### `home_page.resource`

Contém ações da Home, logoff e status do pedido.

Exemplos já existentes:

```robotframework
Pdv - Home - Verify Visible
Pdv - Home - Click New Order
Pdv - Home - Click List Orders
Pdv - Home - Click Clients
Pdv - Home - Click Sync
Pdv - Home - Click Settings
Pdv - Home - Click Logoff
Pdv - Logoff - Verify Visible
Pdv - Logoff - Click Confirm
Pdv - Logoff - Click Cancel
Pdv - Orders Status - Click Home
```

### `orders_page.resource`

Contém ações atômicas da tela de pedido, carrinho e modais.

Exemplos já existentes:

```robotframework
Pdv - Orders - Click Search Input
Pdv - Orders - Type Product Name
Pdv - Orders - Input Barcode By Adb
Pdv - Orders - Click Product By Name
Pdv - Orders - Click First Product Card
Pdv - Orders - Click Clear Search
Pdv - Orders - Click Conference
Pdv - Orders - Click Price Table Button
Pdv - Orders - Click Quantity Add
Pdv - Orders - Click Quantity Remove
Pdv - Orders - Click Remove Item
Pdv - Orders - Click Edit Client
Pdv - Orders - Click Client By Name
Pdv - Orders - Click Discount
Pdv - Orders - Click Addition
Pdv - Orders - Input Discount Value
Pdv - Orders - Verify Promotion Badge Visible
Pdv - Orders - Verify Stock Info Visible
Pdv - Orders - Input Cart Item Unit Price
Pdv - Orders - Click Cart Button
```

Este arquivo também usa a biblioteca `Process` para inserir código de barras via ADB na keyword:

```robotframework
Pdv - Orders - Input Barcode By Adb
```

Essa keyword depende de `${DEVICE_UDID}`.

### `checkout_page.resource`

Contém ações atômicas de checkout e pagamento.

Exemplos já existentes:

```robotframework
Pdv - Checkout - Click Method By Name
Pdv - Checkout - Click Finish Sale
Pdv - Checkout - Click Value Confirm
Pdv - Checkout - Click Bank Slip Add
Pdv - Checkout - Input Bank Slip Term
Pdv - Checkout - Click Value Key
Pdv - Checkout - Click Calendar
Pdv - Checkout - Verify Calendar Day Visible
Pdv - Checkout - Click Day By Number
```

### Boas práticas para pages

- Criar actions pequenas e reutilizáveis.
- Seguir o padrão de nomenclatura:

```text
Pdv - <Tela/Contexto> - <Ação>
```

Exemplos:

```robotframework
Pdv - Orders - Click Product By Name
Pdv - Checkout - Click Finish Sale
Pdv - Home - Verify Visible
```

- Não montar fluxo completo dentro de page.
- Usar `Wait Visible And Click Element`, `Wait Visible And Input Text`, `Wait Until Element Is Visible` e helpers já existentes no projeto.
- Para locator dinâmico, montar o locator dentro da page usando `Replace String`.
- Preferir argumentos em actions genéricas, como produto, cliente, método ou valor.

## Navigation

Arquivo:

```text
modules/pdv/navigation/pdv_navigation.resource
```

Este arquivo importa as pages:

```robotframework
Resource    ../pages/home_page.resource
Resource    ../pages/orders_page.resource
Resource    ../pages/checkout_page.resource
```

As keywords de navigation agrupam ações atômicas das pages em passos de navegação reutilizáveis.

Padrão de nomenclatura atual:

```text
Pdv - Navigate To <Destino/Ação>
```

Exemplos já existentes:

```robotframework
Pdv - Navigate To New Order
Pdv - Navigate To Initial Screen
Pdv - Navigate To Select Product
Pdv - Navigate To Search Product
Pdv - Navigate To Search And Select First Product Card
Pdv - Navigate To Input Barcode By Adb
Pdv - Navigate To Select Product With Stock
Pdv - Navigate To Select Product With Promotion Badge
Pdv - Navigate To Clear Product Search
Pdv - Navigate To Select Price Table A
Pdv - Navigate To Cancel Order
Pdv - Navigate To Check Order
Pdv - Navigate To Finish Order
Pdv - Navigate To Select Client
Pdv - Navigate To Add Items From Cart
Pdv - Navigate To Add Quantity
Pdv - Navigate To Remove Quantity
Pdv - Navigate To Confirm Quantity
Pdv - Navigate To Edit Quantity
Pdv - Navigate To Remove Product From Order
Pdv - Navigate To Apply Discount Integer
Pdv - Navigate To Apply Discount Percent
Pdv - Navigate To Apply Additional Percent
Pdv - Navigate To Apply Additional Integer
Pdv - Navigate To Select Payment Method
Pdv - Navigate To Configure Bank Slip Payment
Pdv - Navigate To Finish Sale
```

### Pagamentos suportados por alias

A navigation possui a keyword:

```robotframework
Pdv - Resolve Payment Method Name
```

Ela converte aliases usados nos testes para o texto exibido na tela:

| Alias | Nome exibido |
| --- | --- |
| `money` | `Dinheiro` |
| `pixoff` | `PIX OFF` |
| `bankslip` | `Boleto Bancário` |

Se um novo método de pagamento for usado por alias, adicionar a conversão nessa keyword.

### Boas práticas para navigation

- Usar navigation para passos reutilizáveis, não para cenários completos.
- Compor actions das pages.
- Evitar duplicar sequências que já existem.
- Criar argumentos para dados variáveis.
- Se a action for usada em mais de um fluxo completo, provavelmente ela deve estar na navigation.

## Fluxos completos

Arquivo:

```text
modules/pdv/navigation/pdv_complete_streams.resource
```

Este arquivo importa:

```robotframework
Resource    pdv_navigation.resource
```

As keywords deste arquivo representam fluxos completos de negócio e devem ser chamadas pela suíte principal.

Padrão de nomenclatura atual:

```text
PDV - Complete Flow - <Nome Do Fluxo>
```

## Fluxos completos já implementados

Atualmente existem os seguintes fluxos completos:

| Keyword | Objetivo |
| --- | --- |
| `PDV - Complete Flow - Order Common` | Pedido simples com produto e pagamento. |
| `PDV - Complete Flow - Filter Name Reference And Barcode` | Pesquisa produto por nome, referência e código de barras. |
| `PDV - Complete Flow - Alter Quantity And Remove Item` | Altera quantidade, remove item e finaliza venda. |
| `PDV - Complete Flow - Cancel Order After Select Product` | Seleciona produto e cancela pedido. |
| `PDV - Complete Flow - Alter Client And Add Itens From Cart` | Altera cliente no carrinho, adiciona item e finaliza venda. |
| `PDV - Complete Flow - Discount Integer` | Aplica desconto em valor fixo. |
| `PDV - Complete Flow - Discount Percent` | Aplica desconto percentual. |
| `PDV - Complete Flow - Additional Percent` | Aplica acréscimo percentual. |
| `PDV - Complete Flow - Additional Integer` | Aplica acréscimo em valor fixo. |
| `PDV - Complete Flow - Item Edition` | Edita quantidades e remove itens no carrinho. |
| `PDV - Complete Flow - Bankslip` | Pedido com cliente e pagamento por boleto bancário. |
| `PDV - Complete Flow - Item Variations` | Pedido com item fracionado, composição, variações por código de barras e promoção. |
| `PDV - Complete Flow - Express Mode` | Pedido adicionando itens pelo modo expresso. |
| `PDV - Complete Flow - Mini PDV Mode` | Pedido usando código de barras via ADB. |
| `PDV - Complete Flow - Smart PDV Functions` | Seleciona cliente, valida estoque e altera preço unitário. |
| `PDV - Complete Flow - Price Table` | Seleciona tabela de preço A e finaliza venda. |
| `PDV - Complete Flow - Pix Off` | Pedido com pagamento via Pix Off. |

### Boas práticas para fluxos completos

- Fluxo completo deve representar o cenário de negócio de ponta a ponta.
- Deve reutilizar navigation sempre que possível.
- Pode chamar PageObjects diretamente apenas quando a ação ainda não justificar uma navigation reutilizável, mas o padrão preferencial é criar uma navigation.
- Deve terminar retornando para a tela inicial quando o fluxo concluir venda ou operação que altere estado.
- Os fluxos atuais geralmente finalizam com:

```robotframework
Pdv - Navigate To Initial Screen
Pdv - Home - Verify Visible
```

- Manter argumentos no fluxo completo para massas variáveis.
- Evitar valores fixos dentro do fluxo quando eles pertencem ao cenário de teste.

## Suíte principal

Arquivo:

```text
tests/regression/pdv/pdv.robot
```

A suíte principal:

- importa `modules/pdv/base_pdv.resource`;
- usa setup/teardown padrão;
- chama somente keywords de fluxo completo;
- passa massas de dados vindas de `pdv_data.yml`;
- define documentação e tags de cada cenário.

Exemplo de cenário atual:

```robotframework
PDV - Order common
    [Documentation]    Realiza um pedido simples com pagamento.
    [Tags]    @allure.label.severity:critical    regression    pdv    orders
    PDV - Complete Flow - Order Common
    ...    ${products.product_1}
    ...    money
```

### Ao adicionar um novo fluxo na suíte

Adicionar um novo test case em `tests/regression/pdv/pdv.robot` chamando a keyword criada em `pdv_complete_streams.resource`.

O cenário deve conter:

- nome do teste;
- `[Documentation]` clara;
- `[Tags]` coerentes;
- chamada da keyword `PDV - Complete Flow - ...`;
- argumentos usando dados do `pdv_data.yml` sempre que possível.

## Ordem recomendada para construir uma nova keyword a partir de um fluxo

Quando um novo fluxo for informado no terminal, seguir esta ordem:

1. **Entender o fluxo solicitado**
   - Identificar telas, ações, validações, dados e resultado esperado.

2. **Verificar se os dados já existem**
   - Arquivo: `modules/pdv/data/pdv_data.yml`.
   - Reutilizar dados existentes antes de criar novos.

3. **Verificar se os locators já existem**
   - Arquivos:
     - `modules/pdv/locators/homeLocators.yml`;
     - `modules/pdv/locators/ordersLocators.yml`;
     - `modules/pdv/locators/checkoutLocators.yml`.
   - Criar novos locators apenas quando necessário.

4. **Criar ou atualizar PageObjects**
   - Arquivos:
     - `modules/pdv/pages/home_page.resource`;
     - `modules/pdv/pages/orders_page.resource`;
     - `modules/pdv/pages/checkout_page.resource`.
   - Criar actions atômicas de clique, input, validação ou interação.

5. **Criar ou atualizar navigation**
   - Arquivo: `modules/pdv/navigation/pdv_navigation.resource`.
   - Compor actions das pages em passos reutilizáveis.

6. **Criar o fluxo completo**
   - Arquivo: `modules/pdv/navigation/pdv_complete_streams.resource`.
   - Compor o cenário completo usando navigation e, se necessário, pages.

7. **Atualizar imports se necessário**
   - Arquivo: `modules/pdv/base_pdv.resource`.
   - Necessário principalmente se novo arquivo de locator/dados for criado.
   - Se nova page for criada, importar essa page em `pdv_navigation.resource`.

8. **Adicionar o cenário na suíte principal**
   - Arquivo: `tests/regression/pdv/pdv.robot`.
   - Chamar a keyword de fluxo completo.

## Convenções de nomenclatura

### PageObjects

```text
Pdv - <Tela/Contexto> - <Ação>
```

Exemplos:

```robotframework
Pdv - Orders - Click Product By Name
Pdv - Checkout - Click Finish Sale
Pdv - Home - Verify Visible
```

### Navigation

```text
Pdv - Navigate To <Ação/Objetivo>
```

Exemplos:

```robotframework
Pdv - Navigate To Select Product
Pdv - Navigate To Finish Order
Pdv - Navigate To Select Payment Method
```

### Fluxo completo

```text
PDV - Complete Flow - <Nome Do Fluxo>
```

Exemplos:

```robotframework
PDV - Complete Flow - Order Common
PDV - Complete Flow - Bankslip
PDV - Complete Flow - Pix Off
```

## Pontos de atenção importantes

- Os arquivos de locator usam extensão `.yml`, não `.yaml`.
- Os locators e dados são carregados via `locators_loader.py` em `base_pdv.resource`.
- A suíte principal deve importar apenas `base_pdv.resource`.
- `pdv_complete_streams.resource` importa `pdv_navigation.resource`.
- `pdv_navigation.resource` importa as pages.
- Se uma nova page for criada, ela deve ser importada em `pdv_navigation.resource`.
- Se um novo arquivo de locator for criado, ele deve ser incluído no `Variables` de `base_pdv.resource`.
- Para métodos de pagamento com alias, atualizar `Pdv - Resolve Payment Method Name`.
- Para fluxos com código de barras via ADB, garantir que `${DEVICE_UDID}` esteja disponível.
- Para elementos com texto dinâmico, usar placeholder no locator e `Replace String` na PageObject.
- Evitar duplicação de fluxo: antes de criar nova keyword, procurar se já existe uma navigation ou PageObject que atende.
- Sempre que um fluxo finalizar venda, manter o padrão de retorno para a tela inicial e validação da Home.

## Exemplo de construção de um novo fluxo

Supondo um novo fluxo: selecionar produto, aplicar desconto e pagar em dinheiro.

### 1. Dados

Verificar se o produto e desconto existem em:

```text
modules/pdv/data/pdv_data.yml
```

### 2. Locators

Verificar se os elementos de desconto já existem em:

```text
modules/pdv/locators/ordersLocators.yml
```

Hoje já existem locators no namespace:

```yaml
discount_modal:
```

### 3. PageObjects

Verificar se já existem actions em:

```text
modules/pdv/pages/orders_page.resource
```

Hoje já existem:

```robotframework
Pdv - Orders - Click Discount-Sum
Pdv - Orders - Click Discount
Pdv - Orders - Click R$
Pdv - Orders - Input Discount Value
Pdv - Orders - Click Apply Discount
```

### 4. Navigation

Verificar se já existe navigation em:

```text
modules/pdv/navigation/pdv_navigation.resource
```

Hoje já existe:

```robotframework
Pdv - Navigate To Apply Discount Integer
```

### 5. Fluxo completo

Criar ou reutilizar fluxo em:

```text
modules/pdv/navigation/pdv_complete_streams.resource
```

Hoje já existe:

```robotframework
PDV - Complete Flow - Discount Integer
```

### 6. Suíte principal

Chamar o fluxo completo em:

```text
tests/regression/pdv/pdv.robot
```

Exemplo já existente:

```robotframework
PDV - Discount Integer
    [Documentation]    Aplica desconto em valor fixo de 1,00 no carrinho e finaliza a venda.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    discount
    PDV - Complete Flow - Discount Integer
    ...    ${products.discount}
    ...    1,00
    ...    money
```

## Checklist antes de finalizar uma implementação

- [ ] O fluxo informado foi entendido e dividido em passos.
- [ ] Os dados necessários foram reutilizados ou adicionados em `pdv_data.yml`.
- [ ] Os locators necessários existem nos arquivos `.yml` corretos.
- [ ] As PageObjects foram criadas como ações atômicas.
- [ ] As navigations reutilizáveis foram criadas ou reaproveitadas.
- [ ] A keyword de fluxo completo foi criada em `pdv_complete_streams.resource`.
- [ ] A suíte `tests/regression/pdv/pdv.robot` chama o fluxo completo.
- [ ] Novos arquivos de locator/dados foram adicionados em `base_pdv.resource`, se existirem.
- [ ] Novas pages foram importadas em `pdv_navigation.resource`, se existirem.
- [ ] A nomenclatura segue o padrão existente.
- [ ] O fluxo final retorna para a tela inicial quando aplicável.
