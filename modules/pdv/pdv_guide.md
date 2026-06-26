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
modules/pdv/locators/syncLocators.yml
modules/pdv/locators/ordersLocators.yml
modules/pdv/locators/checkoutLocators.yml
modules/pdv/locators/settingsLocators.yml
modules/pdv/locators/clientsLocators.yml
modules/pdv/locators/orderslistLocators.yml
modules/pdv/pages/home_page.resource
modules/pdv/pages/sync_page.resource
modules/pdv/pages/orders_page.resource
modules/pdv/pages/checkout_page.resource
modules/pdv/pages/settings_page.resource
modules/pdv/pages/clients_page.resource
modules/pdv/pages/orderslist_page.resource
modules/pdv/navigation/pdv_navigation.resource
modules/pdv/navigation/pdv_complete_streams.resource
modules/pdv/navigation/pdv_settings_setup.resource
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
        ├── pages/sync_page.resource
        ├── navigation/pdv_complete_streams.resource
        │     └── navigation/pdv_navigation.resource
        │           ├── pages/home_page.resource
        │           ├── pages/orders_page.resource
        │           ├── pages/checkout_page.resource
        │           ├── pages/clients_page.resource
        │           ├── pages/orderslist_page.resource
        │           └── pages/sync_page.resource
        └── navigation/pdv_settings_setup.resource
              ├── pages/home_page.resource
              ├── pages/orders_page.resource
              ├── pages/checkout_page.resource
              └── pages/settings_page.resource
```

Ponto importante: a suíte `pdv.robot` não deve importar diretamente pages, navigation ou locators do módulo. Ela deve usar somente `base_pdv.resource`.

## Responsabilidade de cada arquivo

| Arquivo | Responsabilidade |
| --- | --- |
| `modules/pdv/base_pdv.resource` | Base única do módulo PDV. Importa a base global, carrega locators/dados e expõe os fluxos completos e de configuração. |
| `modules/pdv/data/pdv_data.yml` | Armazena massas de dados reutilizadas nos testes do PDV. |
| `modules/pdv/locators/*.yml` | Armazena os elementos do app separados por tela/contexto. |
| `modules/pdv/pages/*.resource` | Contém PageObjects/actions atômicas baseadas nos locators. |
| `modules/pdv/navigation/pdv_navigation.resource` | Compõe PageObjects em passos de navegação reutilizáveis. |
| `modules/pdv/navigation/pdv_complete_streams.resource` | Compõe navigations e pages em fluxos completos de negócio. |
| `modules/pdv/locators/syncLocators.yml` | Armazena os elementos do modal `Sincronizar Dados` e do modal de sucesso `Atualização concluída!`. |
| `modules/pdv/pages/sync_page.resource` | Contém PageObjects/actions atômicas dos modais de sincronização, incluindo seleção de Produtos/Clientes/Pedidos, confirmação e cancelamento. |
| `modules/pdv/pages/clients_page.resource` | Contém PageObjects/actions atômicas da tela Lista de Clientes e cadastro de cliente. |
| `modules/pdv/locators/clientsLocators.yml` | Armazena os elementos da tela Lista de Clientes e formulário de cadastro. |
| `modules/pdv/pages/orderslist_page.resource` | Contém PageObjects/actions atômicas da tela Lista de Pedidos, modal de ações, modal de impressão, cancelamento e status de impressão. |
| `modules/pdv/locators/orderslistLocators.yml` | Armazena os elementos da tela Lista de Pedidos, modais de ações, impressão, cancelamento e status. |
| `modules/pdv/navigation/pdv_settings_setup.resource` | Centraliza fluxos de configuração do app (modo de operação, formas de pagamento, impressoras etc.). Usado em setup de suíte ou teste. |
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
  - `modules/pdv/locators/syncLocators.yml`;
  - `modules/pdv/locators/ordersLocators.yml`;
  - `modules/pdv/locators/checkoutLocators.yml`;
  - `modules/pdv/locators/settingsLocators.yml`;
  - `modules/pdv/locators/clientsLocators.yml`;
  - `modules/pdv/locators/orderslistLocators.yml`;
  - `modules/pdv/data/pdv_data.yml`;
- importa `pages/sync_page.resource` como page compartilhada do módulo;
- importa `navigation/pdv_complete_streams.resource`;
- importa `navigation/pdv_settings_setup.resource`.

Exemplo atual de carregamento:

```robotframework
Variables    ../../resources/libraries/locators_loader.py
...          modules/pdv/locators/homeLocators.yml
...          modules/pdv/locators/syncLocators.yml
...          modules/pdv/locators/ordersLocators.yml
...          modules/pdv/locators/checkoutLocators.yml
...          modules/pdv/locators/settingsLocators.yml
...          modules/pdv/locators/clientsLocators.yml
...          modules/pdv/locators/orderslistLocators.yml
...          modules/pdv/data/pdv_data.yml
...          ${DEVICE_TAG}
Resource     pages/sync_page.resource
Resource     navigation/pdv_complete_streams.resource
Resource     navigation/pdv_settings_setup.resource
```

### Quando alterar este arquivo

Altere `base_pdv.resource` apenas quando:

- criar um novo arquivo de locator `.yml` que precise ser carregado pelo módulo;
- criar um novo arquivo de dados que precise ser carregado pelo módulo;
- mudar a estrutura de imports dos fluxos completos ou de configuração.

Em geral, não é necessário importar pages diretamente na base, pois elas são importadas pela navigation. A exceção atual é `pages/sync_page.resource`, que também é importada diretamente em `base_pdv.resource` como page compartilhada do módulo.

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
client_data:
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
  - `${payment_data.bank_slip_calendar_day}`;
- dados de cadastro de cliente:
  - `${client_data.cep}`.

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

Atualmente existem sete arquivos principais.

### `homeLocators.yml`

Responsável pelos elementos da tela inicial e tela de status do pedido.

Namespaces existentes:

```yaml
home:
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

### `syncLocators.yml`

Responsável pelos elementos dos modais de sincronização acionados pela Home e também reutilizados após sincronizar clientes.

Namespaces existentes:

```yaml
sync_modal:
sync_success_modal:
```

Este arquivo cobre:

- modal `Sincronizar Dados`;
- opções Produtos, Clientes e Pedidos;
- botões Sincronizar e Cancelar;
- modal `Atualização concluída!`;
- mensagem `Os dados foram sincronizados com sucesso!`;
- botão Ok do modal de sucesso.

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

### `settingsLocators.yml`

Responsável pelos elementos de todas as telas de configuração do PDV.

Namespaces existentes:

```yaml
pdv_settings:
smart_pdv_settings:
orders_settings:
printing_settings:
payment_settings:
fiscal_settings:
ticket_settings:
```

Este arquivo cobre:

- menu principal de configurações (opções Smart PDV, Pedidos, Impressões, Formas de Pagamento, Fiscal, Ticket, Dispositivo, Outros e botão Voltar);
- configurações do Smart PDV: seletor de modo de operação (Padrão, Express, Mini PDV) e toggles de funcionalidades;
- configurações de Pedidos: toggles de finalização, envio ao servidor, quantidade fracionada, bloqueio de crédito e dropdowns de tamanho de código e leitura de código de barras;
- configurações de Impressoras: dropdown de impressão ao finalizar, toggles de cabeçalho e agrupamento, e modal de lista de impressoras;
- configurações de Formas de Pagamento: switch por método mapeado individualmente e por nome genérico;
- configurações Fiscais: toggles NFC-e e NF-e;
- configurações de Ticket de Retirada: dropdown e toggle de reimpressão.

Todos os namespaces possuem locators genéricos com placeholder `OPTION_NAME` para uso dinâmico nas pages.

### `clientsLocators.yml`

Responsável pelos elementos da tela de Lista de Clientes e formulário de cadastro de cliente.

Namespaces existentes:

```yaml
client_list:
client_register:
```

Este arquivo cobre:

- lista de clientes: botão Voltar, botão Atualizar (sync), campo de busca, cliente por nome e botão Novo Cliente;
- cadastro de cliente: tabs Detalhes/Endereço, dropdowns Tipo de Pessoa e Contribuinte ICMS, campos CPF/CNPJ/Nome/Telefone/E-mail/Observação/CEP/Endereço/Número/Bairro/Cidade/Complemento, botões Cancelar, Salvar Dados e Iniciar Venda.

Os locators de confirmação de sincronização ficam em `syncLocators.yml`, no namespace `sync_success_modal`.

Os namespaces usam placeholders como `OPTION_NAME` ou `CLIENT_NAME` para uso dinâmico nas pages.

### `orderslistLocators.yml`

Responsável pelos elementos da tela Lista de Pedidos, modais de ações, impressão, cancelamento e status.

Namespaces existentes:

```yaml
orders_list:
order_actions_modal:
print_options_modal:
cancel_order_modal:
print_status_modal:
```

Este arquivo cobre:

- lista de pedidos: botão Voltar, botão Imprimir, campo de busca, botão Filtros e primeiro card de pedido;
- modal de ações do pedido: botões Visualizar Pedido, Reimprimir Comprovante, Detalhes da Nota Fiscal, Cancelar Pedido e overlay de fechamento; telas de visualização e detalhes fiscais;
- modal de opções de impressão: título, botões Recebimentos, Resumo de Vendas e Voltar;
- modal de cancelamento: mensagem de confirmação, botão Sim, mensagem de sucesso e botão Ok;
- modal de status de impressão: mensagens "Realizando a impressão!" e "Impressão concluída!".

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
Pdv - Orders Status - Click Reprint
Pdv - Orders Status - Click New Order
Pdv - Orders Status - Click Share
Pdv - Orders Status - Click Home
Pdv - Orders - Click Home
```

### `sync_page.resource`

Contém ações atômicas dos modais de sincronização de dados.

Keywords já existentes:

```robotframework
Sync - Modal Should Be Visible
Sync - Modal Should Not Be Visible
Sync - Select Products
Sync - Select Clients
Sync - Select Orders
Sync - Click Sync Button
Sync - Tap Option
Sync - Tap Element At Percent
Sync - Click Cancel
Sync - Success Modal Should Be Visible
Sync - Success Modal Should Not Be Visible
Sync - Click Success Ok
```

Pontos importantes:

- `Sync - Select Products`, `Sync - Select Clients` e `Sync - Select Orders` usam `Sync - Tap Option`.
- `Sync - Tap Option` toca no primeiro quarto do elemento (`x=50`, `y=25`), porque o modal possui views sobrepostas na metade inferior das opções.
- `Sync - Click Sync Button` usa tap por coordenada relativa e depende de ao menos uma opção selecionada para o botão ficar habilitado.
- `Sync - Success Modal Should Be Visible` e `Sync - Click Success Ok` também são reutilizados no fluxo de sincronização da Lista de Clientes.

### `orders_page.resource`

Contém ações atômicas da tela de pedido, carrinho e modais.

Exemplos já existentes:

```robotframework
Pdv - Orders - Click Back
Pdv - Orders - Click Cancel Order New
Pdv - Orders - Click Search Input
Pdv - Orders - Type Product Name
Pdv - Orders - Search Item
Pdv - Orders - Input Barcode By Adb
Pdv - Orders - Click Product By Name
Pdv - Orders - Click First Product Card
Pdv - Orders - Click Clear Search
Pdv - Orders - Click Filter All
Pdv - Orders - Click Conference
Pdv - Orders - Click Price Table Button
Pdv - Orders - Verify Price Table Modal Visible
Pdv - Orders - Click Price Table A
Pdv - Orders - Click Price Table Modal Confirm
Pdv - Orders - Verify Price Table Change Dialog Visible
Pdv - Orders - Click Price Table Change Confirm
Pdv - Orders - Click Quantity Field
Pdv - Orders - Input Quantity
Pdv - Orders - Click Quantity Add
Pdv - Orders - Click Quantity Remove
Pdv - Orders - Click Quantity Confirm
Pdv - Orders - Click Remove Item
Pdv - Orders - Verify Remove Item Dialog
Pdv - Orders - Click Remove Item Cancel
Pdv - Orders - Click Remove Item Confirm
Pdv - Orders - Verify Cancel Dialog
Pdv - Orders - Click Cancel Cancel
Pdv - Orders - Click Cancel Confirm
Pdv - Orders - Click Cart Back
Pdv - Orders - Click Cancel Order Cart
Pdv - Orders - Click Edit Client
Pdv - Orders - Click Remove Item Icon
Pdv - Orders - Click Cart Item Sub
Pdv - Orders - Click Cart Item Quantity
Pdv - Orders - Click Cart Item Add
Pdv - Orders - Input Cart Item Unit Price
Pdv - Orders - Click Cart Item Discount
Pdv - Orders - Click Cart Item R$
Pdv - Orders - Click Cart Item Percent
Pdv - Orders - Input Cart Item Discount Value
Pdv - Orders - Click Cart Item Edit Confirm
Pdv - Orders - Click Discount-Sum
Pdv - Orders - Click Cart
Pdv - Orders - Click Finalize Order
Pdv - Orders - Click Finalize Order New Order
Pdv - Orders - Input Client Modal Client
Pdv - Orders - Click Client By Name
Pdv - Orders - Input Client Modal CPF
Pdv - Orders - Click Register Client
Pdv - Orders - Click Client Modal Cancel
Pdv - Orders - Click Client Modal Confirm
Pdv - Orders - Click Discount
Pdv - Orders - Click Addition
Pdv - Orders - Click R$
Pdv - Orders - Click Percent
Pdv - Orders - Input Discount Value
Pdv - Orders - Click Remove Discount
Pdv - Orders - Click Apply Discount
Pdv - Orders - Verify Promotion Badge Visible
Pdv - Orders - Verify Stock Info Visible
Pdv - Orders - Click Cart Button
```

Além das actions principais, este arquivo já possui actions auxiliares para:

- voltar/cancelar pedido pela tela de novo pedido e pelo carrinho;
- filtro `Todos` e busca genérica (`Pdv - Orders - Search Item`);
- abertura, confirmação e confirmação de troca da tabela de preço;
- edição direta do campo de quantidade;
- cancelamento/confirmacão dos dialogs de remoção e cancelamento;
- ações genéricas no carrinho e ações ancoradas por nome do produto;
- preenchimento de CPF/CNPJ e abertura do cadastro pelo modal de cliente;
- remoção de desconto/acréscimo aplicado.

Este arquivo também usa a biblioteca `Process` para inserir código de barras via ADB na keyword:

```robotframework
Pdv - Orders - Input Barcode By Adb
```

Essa keyword depende de `${DEVICE_UDID}`.

### `checkout_page.resource`

Contém ações atômicas de checkout e pagamento.

Exemplos já existentes:

```robotframework
Pdv - Checkout - Click Back
Pdv - Checkout - Click Sync
Pdv - Checkout - Click Method By Name
Pdv - Checkout - Click Selected Method Actions
Pdv - Checkout - Click Finish Sale
Pdv - Checkout - Click Value Clear
Pdv - Checkout - Click Value Backspace
Pdv - Checkout - Click Value Cancel
Pdv - Checkout - Click Value Confirm
Pdv - Checkout - Click Bank Slip Add
Pdv - Checkout - Click Bank Slip Sub
Pdv - Checkout - Input Bank Slip Term
Pdv - Checkout - Click Value Key
Pdv - Checkout - Click Calendar
Pdv - Checkout - Verify Calendar Day Visible
Pdv - Checkout - Click Day By Number
```

Comportamentos importantes já implementados para boleto:

- `Pdv - Checkout - Click Bank Slip Add` valida o incremento da quantidade de parcelas comparando o texto anterior com o esperado.
- `Pdv - Checkout - Click Bank Slip Sub` valida o decremento da quantidade de parcelas comparando o texto anterior com o esperado.
- `Pdv - Checkout - Input Bank Slip Term` não digita diretamente no input: ele abre o campo, limpa usando `Pdv - Checkout - Click Value Clear` e informa cada dígito pelo teclado numérico do modal com `Pdv - Checkout - Click Value Key`.

### `settings_page.resource`

Contém ações atômicas das telas de configuração, organizadas por seção.

Keywords de navegação no menu principal:

```robotframework
Pdv - Settings Click Back
Pdv - Settings Click Smart Pdv
Pdv - Settings Click Orders
Pdv - Settings Click Printing
Pdv - Settings Click Payment Methods
Pdv - Settings Click Acquirer
Pdv - Settings Click Softcompay
Pdv - Settings Click Fiscal
Pdv - Settings Click Ticket
Pdv - Settings Click Device
Pdv - Settings Click Others
Pdv - Settings Click Option By Name
```

Keywords de Smart PDV:

```robotframework
Pdv - Smart Pdv Select Operation Mode
Pdv - Smart Pdv Toggle Request Client
Pdv - Smart Pdv Toggle Show Stock
Pdv - Smart Pdv Toggle Discount Per Item
Pdv - Smart Pdv Toggle Require Payment
Pdv - Smart Pdv Toggle Price Table
Pdv - Smart Pdv Toggle Edit Item Price
Pdv - Smart Pdv Toggle Option By Name
```

Keywords de Pedidos:

```robotframework
Pdv - Orders Settings Toggle Finish After Payment
Pdv - Orders Settings Toggle Send Order To Server
Pdv - Orders Settings Toggle Fractional Quantity
Pdv - Orders Settings Toggle Credit Limit Block
Pdv - Orders Settings Toggle Option By Name
Pdv - Orders Settings Open Product Code Size Menu
Pdv - Orders Settings Select Product Code Size
Pdv - Orders Settings Open Barcode Reading Menu
Pdv - Orders Settings Select Barcode Reading
```

Keywords de Impressoras:

```robotframework
Pdv - Printing Settings Open Print On Finish Menu
Pdv - Printing Settings Select Print On Finish
Pdv - Printing Settings Toggle Print Header
Pdv - Printing Settings Toggle Group Kitchen Print
Pdv - Printing Settings Toggle Option By Name
Pdv - Printing Settings Click Printer List
Pdv - Printer List Modal Click Printer Icon Area
Pdv - Printer List Modal Click Close
```

Keywords de Formas de Pagamento:

```robotframework
Pdv - Payment Settings Toggle Method By Name
Pdv - Payment Settings Toggle Voucher
Pdv - Payment Settings Toggle Money
Pdv - Payment Settings Toggle Check
Pdv - Payment Settings Toggle Credit Card
Pdv - Payment Settings Toggle Debit Card
Pdv - Payment Settings Toggle Store Credit
Pdv - Payment Settings Toggle Bank Slip
Pdv - Payment Settings Toggle Pix
Pdv - Payment Settings Toggle Pix Off
Pdv - Payment Settings Toggle Others
Pdv - Payment Settings Toggle Pos
```

Keywords de Fiscal:

```robotframework
Pdv - Fiscal Settings Toggle Enable Nfce
Pdv - Fiscal Settings Toggle Enable Nfe
```

Keywords de Ticket:

```robotframework
Pdv - Ticket Settings Open Ticket On Finish Menu
Pdv - Ticket Settings Select Ticket On Finish
Pdv - Ticket Settings Toggle Allow Reprint
```

As actions `Select ...` de dropdown normalmente encapsulam uma action `Open ... Menu`. Ao criar novos dropdowns em settings, seguir o padrão:

1. criar `Open <Campo> Menu`;
2. criar `Select <Campo>` chamando o Open e selecionando a opção por texto exibido.

### `clients_page.resource`

Contém ações atômicas da tela Lista de Clientes e formulário de cadastro. O modal de sucesso da sincronização é tratado por `sync_page.resource`.

Keywords da Lista de Clientes:

```robotframework
Client List - Click Back
Client List - Click Sync
Client List - Search Client
Client List - Click Client By Name
Client List - Client Should Be Visible
Client List - Click New Client
```

A confirmação de sincronização da lista de clientes é feita pelas keywords compartilhadas de `sync_page.resource`: após `Client List - Click Sync`, a navigation `Pdv - Navigate To Sync Client List` usa `Sync - Success Modal Should Be Visible` e `Sync - Click Success Ok`.

Keywords do Cadastro de Cliente:

```robotframework
Client Register - Click Tab Details
Client Register - Click Tab Address
Client Register - Open Person Type Menu
Client Register - Select Person Type
Client Register - Fill Cpf
Client Register - Fill Cnpj
Client Register - Fill Fantasy Name
Client Register - Fill Social Reason
Client Register - Fill Name
Client Register - Open Icms Contributor Menu
Client Register - Select Icms Contributor
Client Register - Fill Phone
Client Register - Fill Email
Client Register - Fill Note
Client Register - Fill Cep
Client Register - Click Consultar Cep
Client Register - Fill Address
Client Register - Fill Number
Client Register - Fill Neighborhood
Client Register - Open State Menu
Client Register - Select State
Client Register - Open City Menu
Client Register - Select City
Client Register - Fill Complement
Client Register - Click Init Order
Client Register - Click Cancel
Client Register - Click Save
```

O cadastro de cliente segue o mesmo padrão de dropdowns: cada seleção possui uma keyword `Open ... Menu` e uma keyword `Select ...` que seleciona por texto exibido.

As keywords `Fill Cnpj`, `Fill Fantasy Name` e `Fill Social Reason` são usadas exclusivamente no fluxo de cadastro de cliente Jurídico.

### `orderslist_page.resource`

Contém ações atômicas da tela Lista de Pedidos, modal de ações, modal de impressão, cancelamento e status de impressão.

Keywords da Lista de Pedidos:

```robotframework
Orders List - Click Back
Orders List - Click Print
Orders List - Search
Orders List - Click Filters
Orders List - Click First Order
Orders List - Should Be Visible
```

Keywords do Modal de Ações:

```robotframework
Orders List - Actions Modal Should Be Visible
Orders List - Actions Modal Should Not Be Visible
Orders List - Actions Modal Click View Order
Orders List - Actions Modal Click Reprint Receipt
Orders List - Actions Modal Click Fiscal Details
Orders List - Actions Modal Click Cancel Order
Orders List - Actions Modal Close By Overlay
Orders List - View Order Screen Should Be Visible
Orders List - Fiscal Details Screen Should Be Visible
```

Keywords do Modal de Impressão:

```robotframework
Orders List - Print Options Modal Should Be Visible
Orders List - Print Options Modal Should Not Be Visible
Orders List - Print Options Click Receipts
Orders List - Print Options Click Sales Summary
Orders List - Print Options Click Back
```

Keywords de Cancelamento de Pedido:

```robotframework
Orders List - Cancel Order Modal Should Be Visible
Orders List - Cancel Order Modal Click Yes
Orders List - Cancel Order Success Should Be Visible
Orders List - Cancel Order Click Ok
```

Keywords de Status de Impressão:

```robotframework
Orders List - Print Status Should Be Printing
Orders List - Print Status Should Be Completed
Orders List - Print Status Should Not Be Completed
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
Resource    ../pages/clients_page.resource
Resource    ../pages/orderslist_page.resource
Resource    ../pages/sync_page.resource
```

As keywords de navigation agrupam ações atômicas das pages em passos de navegação reutilizáveis.

Padrão de nomenclatura atual:

```text
Pdv - Navigate To <Destino/Ação>
```

Exemplos já existentes:

Navegação — Home:

```robotframework
Pdv - Navigate To New Order
Pdv - Navigate To Initial Screen
```

Ações de sincronização pela Home são compostas diretamente no fluxo completo `PDV - Complete FLow - Sync Options`, usando `Pdv - Home - Click Sync` e as actions de `sync_page.resource`.

Navegação — Pedido:

```robotframework
Pdv - Navigate To Select Product
Pdv - Navigate To Search Product
Pdv - Navigate To Search And Select First Product Card
Pdv - Navigate To Input Barcode By Adb
Pdv - Navigate To Select Product With Stock
Pdv - Navigate To Select Product With Promotion Badge
Pdv - Navigate To Search Product And Verify Stock
Pdv - Navigate To Search Product And Verify Promotion Badge
Pdv - Navigate To Long Press Product
Pdv - Navigate To Search And Long Press Product
Pdv - Navigate To Clear Product Search
Pdv - Navigate To Select Price Table A
Pdv - Navigate To Cancel Order
Pdv - Navigate To Check Order
Pdv - Navigate To Finish Order
Pdv - Navigate To Finish Order From New Order
Pdv - Navigate To Select Client
Pdv - Navigate To Add Items From Cart
Pdv - Navigate To Add Quantity
Pdv - Navigate To Remove Quantity
Pdv - Navigate To Confirm Quantity
Pdv - Navigate To Edit Quantity
Pdv - Navigate To Remove Product From Order
Pdv - Navigate To Add Cart Item Quantity
Pdv - Navigate To Remove Cart Item Quantity
Pdv - Navigate To Remove Cart Item By Name
Pdv - Navigate To Remove Cart Item By Icon
Pdv - Navigate To Edit Cart Item Quantity By Name
Pdv - Navigate To Edit Cart Item Unit Price By Name
Pdv - Navigate To Apply Cart Item Discount Integer By Name
Pdv - Navigate To Apply Cart Item Discount Percent By Name
Pdv - Navigate To Apply Discount Integer
Pdv - Navigate To Apply Discount Percent
Pdv - Navigate To Apply Additional Percent
Pdv - Navigate To Apply Additional Integer
```

Navegação — Checkout:

```robotframework
Pdv - Navigate To Select Payment Method
Pdv - Navigate To Confirm Payment Value
Pdv - Navigate To Configure Bank Slip Payment
Pdv - Navigate To Finish Sale
```

Navegação — Lista de Pedidos:

```robotframework
Pdv - Navigate To View Order
Pdv - Navigate To Reprint First Order Receipt
Pdv - Navigate To Fiscal Details First Order
Pdv - Navigate To Cancel First Order
Pdv - Navigate To Print Receipts
Pdv - Navigate To Print Sales Summary
```

Navegação — Clientes:

```robotframework
Pdv - Navigate To Clients
Pdv - Navigate To Sync Client List
Pdv - Navigate To Search And Select Client
Pdv - Navigate To Init Order From Client
Pdv - Navigate To New Client
Pdv - Navigate To Fill Client Details
Pdv - Navigate To Fill Client Details Juridic
Pdv - Navigate To Fill Client Address
Pdv - Navigate To Save And Verify Client
Pdv - Navigate To Save And Verify Client By Cnpj
```

`Pdv - Navigate To Save And Verify Client` e `Pdv - Navigate To Save And Verify Client By Cnpj` aguardam o campo de busca da lista aparecer após salvar antes de pesquisar — isso evita `StaleElementReferenceException` durante a transição de tela. A variante `By Cnpj` pesquisa pelo CNPJ (sem formatação) e verifica pela Razão Social.

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
| `PDV - Complete FLow - Sync Options` | Sincroniza dados pela Home selecionando Produtos, Clientes e Pedidos e confirmando o modal de sucesso. |
| `PDV - Complete Flow - Order Common` | Pedido simples com produto e pagamento. |
| `PDV - Complete Flow - Filter Name Reference And Barcode` | Pesquisa produto por nome, referência e código de barras. |
| `PDV - Complete Flow - Alter Quantity And Remove Item` | Altera quantidade, remove item e finaliza venda. |
| `PDV - Complete Flow - Cancel Order After Select Product` | Seleciona produto e cancela pedido. |
| `PDV - Complete Flow - Alter Client And Add Itens From Cart` | Altera cliente no carrinho, adiciona item e finaliza venda. |
| `PDV - Complete Flow - Discount Integer` | Aplica desconto em valor fixo no carrinho. |
| `PDV - Complete Flow - Discount Percent` | Aplica desconto percentual no carrinho. |
| `PDV - Complete Flow - Discount Item` | Aplica desconto por item: valor fixo em um produto e percentual em outro. |
| `PDV - Complete Flow - Additional Percent` | Aplica acréscimo percentual no carrinho. |
| `PDV - Complete Flow - Additional Integer` | Aplica acréscimo em valor fixo no carrinho. |
| `PDV - Complete Flow - Item Edition` | Edita quantidades e remove itens no carrinho. |
| `PDV - Complete Flow - Bankslip` | Pedido com cliente e pagamento por boleto bancário. |
| `PDV - Complete Flow - Item Variations` | Pedido com item fracionado, composição, variações por código de barras e promoção. |
| `PDV - Complete Flow - Express Mode` | Pedido adicionando itens pelo modo expresso. |
| `PDV - Complete Flow - Mini PDV Mode` | Pedido usando código de barras via ADB. |
| `PDV - Complete Flow - Smart PDV Functions` | Valida estoque e altera preço unitário. |
| `PDV - Complete Flow - Price Table` | Seleciona tabela de preço A e finaliza venda. |
| `PDV - Complete Flow - Pix Off` | Pedido com pagamento via Pix Off. |
| `PDV - Complete Flow - NFCe Disable` | Pedido realizado com fiscal desativado. |
| `PDV - Complete Flow - No Payment Method` | Pedido finalizado sem selecionar método de pagamento. |
| `PDV - Complete Flow - Ticket Order` | Pedido com emissão de ticket de retirada (quantidade aumentada 10x no carrinho). |
| `PDV - Complete Flow - Sync Search Client And Init Order` | Sincroniza lista de clientes, seleciona cliente, inicia pedido via "Iniciar Venda" e finaliza. |
| `PDV - Complete Flow - Register Client` | Cadastra cliente pessoa Física ou Jurídica com dados gerados pelo Faker e verifica o registro. |
| `PDV - Complete Flow - List Orders Functions` | Navega pela Lista de Pedidos: visualiza, reimprimi, cancela pedido e imprime relatórios. |

### Diferenças e comportamentos específicos dos fluxos atuais

- `PDV - Complete FLow - Sync Options` está implementado com `FLow` usando `L` maiúsculo no meio do nome. A suíte chama exatamente esse nome; manter consistência ou renomear a keyword e o teste juntos.
- `PDV - Complete Flow - Bankslip` possui defaults: `${term_days}=7`, `${parcels_add_times}=4` e `${payment_method}=bankslip`. A data de vencimento vem de `${payment_data.bank_slip_calendar_day}` na suíte.
- `PDV - Complete Flow - Item Variations` não é fixo em Pix Off; ele usa o argumento `${payment_method}`. Na suíte atual o cenário passa `money`, apesar da tag `pixoff`.
- `PDV - Complete Flow - Mini PDV Mode` recebe `${product_name}`, `${barcode}` e `${payment_method}`, mas atualmente usa apenas `${barcode}` para entrada via ADB antes de finalizar.
- `PDV - Complete Flow - Smart PDV Functions` recebe `${client_name}`, mas a chamada `Pdv - Navigate To Select Client` está comentada. O comportamento atual valida estoque, altera preço unitário e finaliza.
- `PDV - Complete Flow - NFCe Disable` não altera configuração fiscal dentro do fluxo; ele delega para `PDV - Complete Flow - Order Common`. A desativação/reativação de NFC-e deve ser feita antes/depois via `Pdv - Setup Active/Deactive NFCe`.
- `PDV - Complete Flow - No Payment Method` finaliza a venda sem chamar `Pdv - Navigate To Select Payment Method` e sem confirmar valor de pagamento. Ele depende da configuração `Pdv - Setup Active/Deactive Payment Method` para permitir venda sem pagamento obrigatório.
- `PDV - Complete Flow - List Orders Functions` não executa detalhes fiscais atualmente; a navigation `Pdv - Navigate To Fiscal Details First Order` existe, mas está comentada no fluxo. O comportamento atual cobre visualizar pedido, reimprimir comprovante, cancelar pedido e imprimir relatórios.
- Na Lista de Pedidos, a reimpressão de comprovante valida `Realizando a impressão!` e depois espera `Impressão concluída!` não estar visível. Os relatórios `Recebimentos` e `Resumo de Vendas` validam `Realizando a impressão!`, `Impressão concluída!` e o desaparecimento da conclusão.
- As validações de status de impressão em `orderslist_page.resource` são ignoradas em dispositivo com `${DEVICE_TAG}` igual a `cielo`, registrando `Log Action` com nível `WARN`.

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

## Configuração do app (Settings Setup)

Arquivo:

```text
modules/pdv/navigation/pdv_settings_setup.resource
```

Este arquivo é importado diretamente por `base_pdv.resource` e centraliza fluxos de configuração do app que são usados como setup de suíte ou de cenário. Ele importa todas as pages diretamente:

```robotframework
Resource    ../pages/home_page.resource
Resource    ../pages/orders_page.resource
Resource    ../pages/checkout_page.resource
Resource    ../pages/settings_page.resource
```

O padrão de nomenclatura das keywords de setup é:

```text
Pdv - Setup <O Que Configura>
```

### Keywords de setup já implementadas

| Keyword | O que configura |
| --- | --- |
| `Pdv - Setup Printers` | Impressão ao finalizar venda e impressora padrão. |
| `Pdv - Setup Payment Methods` | Ativa Boleto Bancário, PIX e PIX OFF. |
| `Pdv - Setup Active Fractional Units` | Ativa quantidade fracionada nas configurações de pedidos. |
| `Pdv - Setup Active Price Tables` | Ativa tabela de preço nas configurações do Smart PDV. |
| `Pdv - Setup Active Operation Mode` | Seleciona o modo de operação do Smart PDV (Padrao, Express ou Mini PDV). |
| `Pdv - Setup Active Smart PDV Functions` | Ativa exibição de estoque e alteração de preço unitário. A alternância de `Solicitar cliente ao iniciar pedido` existe na page, mas está comentada neste setup. |
| `Pdv - Setup Active/Deactive NFCe` | Alterna NFC-e nas configurações fiscais. |
| `Pdv - Setup Active/Deactive Discount Item` | Alterna Desconto/Acréscimo por item no Smart PDV. |
| `Pdv - Setup Active/Deactive Payment Method` | Alterna Obrigar pagamentos na venda no Smart PDV. |
| `Pdv - Setup Active/Deactive Ticket` | Seleciona opção de ticket ao finalizar e alterna reimpressão de ticket. |

### Alias de modo de operação

A keyword `Pdv - Resolve Operation Mode Name` converte aliases para o nome exibido no dropdown:

| Alias | Nome exibido |
| --- | --- |
| `Padrao` / `Padrão` | `Padrão (Conferência Ativa)` |
| `Express` | `Express (Venda Rápida)` |
| `Mini PDV` | `Mini PDV` |

### Boas práticas para settings setup

- Usar `pdv_settings_setup.resource` somente para fluxos de configuração do app, não para fluxos de negócio.
- Cada keyword de setup deve iniciar na Home, acessar a opção de configuração necessária, aplicar a alteração e retornar para a Home.
- Reutilizar keywords da `settings_page.resource` — evitar chamar locators diretamente no setup.
- Se um novo toggle, dropdown ou opção de configuração for necessário, criar a action atômica em `settings_page.resource` primeiro e depois compô-la no setup.
- Se um novo arquivo de locator de configuração for criado, adicioná-lo em `base_pdv.resource` no carregamento do `locators_loader.py`.

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

Cenários implementados na suíte atual:

| Test Case | Fluxo chamado |
| --- | --- |
| `PDV - Setup` | `Pdv - Setup Printers    Nenhuma Ação` e `Pdv - Setup Payment Methods` |
| `PDV - Order common` | `PDV - Complete Flow - Order Common` |
| `PDV - Filter name, reference and barcode` | `PDV - Complete Flow - Filter Name Reference And Barcode` |
| `PDV - Alter Quantity and Remove item` | `PDV - Complete Flow - Alter Quantity And Remove Item` |
| `PDV - Cancel Order` | `PDV - Complete Flow - Cancel Order After Select Product` |
| `PDV - Alter Client and Add Itens from Cart` | `PDV - Complete Flow - Alter Client And Add Itens From Cart` |
| `PDV - Discount Integer` | `PDV - Complete Flow - Discount Integer` |
| `PDV - Discount Percent` | `PDV - Complete Flow - Discount Percent` |
| `PDV - Discount Item` | `PDV - Complete Flow - Discount Item` |
| `PDV - Additional Percent` | `PDV - Complete Flow - Additional Percent` |
| `PDV - Additional Integer` | `PDV - Complete Flow - Additional Integer` |
| `PDV - Item edition` | `PDV - Complete Flow - Item Edition` |
| `PDV - Bankslip` | `PDV - Complete Flow - Bankslip` |
| `PDV - Pix Off` | `PDV - Complete Flow - Pix Off` |
| `PDV - Item Variations` | `PDV - Complete Flow - Item Variations` |
| `PDV - Price Table` | `PDV - Complete Flow - Price Table` |
| `PDV - Express Mode` | `PDV - Complete Flow - Express Mode` |
| `PDV - Mini PDV Mode` | `PDV - Complete Flow - Mini PDV Mode` |
| `PDV - Smart PDV Functions` | `PDV - Complete Flow - Smart PDV Functions` |
| `PDV - NFCe Disable` | `PDV - Complete Flow - NFCe Disable` |
| `PDV - No Payment Method` | `PDV - Complete Flow - No Payment Method` |
| `PDV - Ticket` | `PDV - Complete Flow - Ticket Order` |
| `PDV - Sync Search Client And Init Order` | `PDV - Complete Flow - Sync Search Client And Init Order` |
| `PDV - Register Client Type Fisic` | `PDV - Complete Flow - Register Client` com `Física` |
| `PDV - Register Client Type Juridic` | `PDV - Complete Flow - Register Client` com `Jurídica` |
| `PDV - List Orders Functions` | `PDV - Complete Flow - List Orders Functions` |
| `PDV - Sync Options` | `PDV - Complete FLow - Sync Options` |

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
     - `modules/pdv/locators/syncLocators.yml`;
     - `modules/pdv/locators/ordersLocators.yml`;
     - `modules/pdv/locators/checkoutLocators.yml`;
     - `modules/pdv/locators/settingsLocators.yml`;
     - `modules/pdv/locators/clientsLocators.yml`;
     - `modules/pdv/locators/orderslistLocators.yml`.
   - Criar novos locators apenas quando necessário.

4. **Criar ou atualizar PageObjects**
   - Arquivos:
     - `modules/pdv/pages/home_page.resource`;
     - `modules/pdv/pages/sync_page.resource` (para ações dos modais de sincronização);
     - `modules/pdv/pages/orders_page.resource`;
     - `modules/pdv/pages/checkout_page.resource`;
     - `modules/pdv/pages/settings_page.resource` (para ações nas telas de configuração);
     - `modules/pdv/pages/clients_page.resource` (para ações na Lista de Clientes e cadastro);
     - `modules/pdv/pages/orderslist_page.resource` (para ações na Lista de Pedidos).
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
   - Se nova page de fluxo de negócio for criada, importar em `pdv_navigation.resource`.
   - Se nova page de configuração for criada, importar em `pdv_settings_setup.resource`.

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
- `pdv_navigation.resource` importa as pages de fluxo de negócio (home, orders, checkout, clients, orderslist) e a page compartilhada de sincronização (`sync_page.resource`).
- `pdv_settings_setup.resource` importa as pages de configuração (home, orders, checkout, settings).
- Se uma nova page de fluxo de negócio for criada, importar em `pdv_navigation.resource`.
- Se uma nova page de configuração for criada, importar em `pdv_settings_setup.resource`.
- Se um novo arquivo de locator for criado, incluí-lo no `Variables` de `base_pdv.resource`.
- Para métodos de pagamento com alias, atualizar `Pdv - Resolve Payment Method Name`.
- Para modos de operação com alias, atualizar `Pdv - Resolve Operation Mode Name`.
- Para fluxos com código de barras via ADB, garantir que `${DEVICE_UDID}` esteja disponível.
- Para elementos com texto dinâmico, usar placeholder no locator e `Replace String` na PageObject.
- Evitar duplicação de fluxo: antes de criar nova keyword, procurar se já existe uma navigation ou PageObject que atende.
- Sempre que um fluxo finalizar venda, manter o padrão de retorno para a tela inicial e validação da Home.
- Fluxos de configuração do app pertencem a `pdv_settings_setup.resource`, não a `pdv_complete_streams.resource`.
- `FakerLibrary` (locale `pt_BR`) está disponível globalmente via `base.resource` — use para gerar CPF, nome, telefone, e-mail e número de edificação em fluxos de cadastro.
- O eixo XPath `following::` causa `ClassCastException` no UiAutomator2 — substituir sempre por `following-sibling::` ou âncora direta.
- Campos de formulário que ficam abaixo do teclado virtual devem usar o padrão: `Wait Visible And Click Element` → `Safe Swipe By Percent    50    70    50    30` → `Input Text`. O swipe após o clique reposiciona o campo que o teclado ocultou.
- Após `Client Register - Click Save`, aguardar `${client_list.search_input}` ficar visível antes de interagir com a lista — evita `StaleElementReferenceException` durante a transição de tela.

## Lacunas conhecidas / atenção antes de reutilizar

- `PDV - Complete FLow - Sync Options` está implementado com grafia diferente do padrão (`FLow`). Se for padronizar para `Flow`, renomear a keyword e a chamada em `tests/regression/pdv/pdv.robot` no mesmo ajuste.
- `Pdv - Setup Active Smart PDV Functions` não alterna `Solicitar cliente ao iniciar pedido` atualmente, pois a chamada `Pdv - Smart Pdv Toggle Request Client` está comentada no setup.
- `PDV - Complete Flow - Smart PDV Functions` recebe `${client_name}`, mas não seleciona cliente porque `Pdv - Navigate To Select Client` está comentada no fluxo completo.
- `PDV - Complete Flow - Mini PDV Mode` recebe `${product_name}`, mas usa apenas `${barcode}` via ADB.
- `PDV - Complete Flow - List Orders Functions` não acessa detalhes fiscais atualmente; `Pdv - Navigate To Fiscal Details First Order` existe, mas está comentada no fluxo completo.
- `PDV - Complete Flow - Item Variations` usa o argumento `${payment_method}`. Na suíte atual o cenário passa `money`, apesar da tag `pixoff`.
- `client_register.btn_consultar_cnpj` existe em `clientsLocators.yml`, mas ainda não possui PageObject correspondente em `clients_page.resource`.
- `Client Register - Select State` depende de `${client_register.state_input}`, que não está definido atualmente em `clientsLocators.yml`; evitar reutilizar essa keyword até alinhar o locator.
- Revisar os dropdowns de Pedidos em settings antes de reutilizar: `settings_page.resource` referencia `${orders_settings.product_code_size_input}` e `${orders_settings.barcode_reading_input}`, enquanto `settingsLocators.yml` define `product_code_size_open_menu` e `barcode_reading_open_menu`.
- `smart_pdv_settings.operation_mode_description` aparenta estar incompleto em `settingsLocators.yml` e não é usado pelas pages atuais; revisar antes de criar validações com esse locator.

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
- [ ] Os locators necessários existem nos arquivos `.yml` corretos (incluindo `syncLocators.yml` para sincronização, `settingsLocators.yml` para fluxos de configuração e `orderslistLocators.yml` para fluxos da Lista de Pedidos).
- [ ] As PageObjects foram criadas como ações atômicas.
- [ ] As navigations reutilizáveis foram criadas ou reaproveitadas.
- [ ] A keyword de fluxo completo foi criada em `pdv_complete_streams.resource` (fluxos de negócio) ou em `pdv_settings_setup.resource` (fluxos de configuração do app).
- [ ] A suíte `tests/regression/pdv/pdv.robot` chama o fluxo completo.
- [ ] Novos arquivos de locator/dados foram adicionados em `base_pdv.resource`, se existirem.
- [ ] Novas pages de fluxo de negócio foram importadas em `pdv_navigation.resource`, se existirem.
- [ ] Novas pages de configuração foram importadas em `pdv_settings_setup.resource`, se existirem.
- [ ] Os namespaces referenciados nas pages (`${namespace.key}`) batem exatamente com os definidos nos arquivos `.yml` correspondentes.
- [ ] A nomenclatura segue o padrão existente.
- [ ] O fluxo final retorna para a tela inicial quando aplicável.
