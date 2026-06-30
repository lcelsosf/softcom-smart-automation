# Tests Coverage — Cenários Implementados

> Última atualização: 2026-06-30
> Suites analisadas: `tests/regression/commands/commands.robot` · `tests/regression/pdv/pdv.robot`

---

## Módulo: Commands (Comanda/Mesa)

Pré-condição: app iniciado no Painel de Mesas.

| #   | Cenário                                                                                      | Severidade | Tags                            |
| --- | -------------------------------------------------------------------------------------------- | ---------- | ------------------------------- |
| 1   | Abrir mesa, selecionar produto, alterar quantidade e faturar com dinheiro                    | critical   | commands, invoice               |
| 2   | Abrir mesa, selecionar produto com adicionais e faturar com dinheiro                         | critical   | commands, additionals           |
| 3   | Abrir mesa, selecionar produto marcado para não contabilizar serviço e faturar com dinheiro  | critical   | commands, not_selling           |
| 4   | Abrir mesa, selecionar produto desativado e faturar com dinheiro                             | critical   | commands, not_selling           |
| 5   | Abrir mesa, selecionar produto marcado como não enviar para a comanda e faturar com dinheiro | critical   | commands, not_selling           |
| 6   | Abrir mesa, selecionar produto marcado como não vender e faturar com dinheiro                | critical   | commands, not_selling           |
| 7   | Abrir mesa, selecionar produto em promoção e faturar com dinheiro                            | critical   | commands, promotion             |
| 8   | Abrir mesa, imprimir conferência e faturar com dinheiro                                      | critical   | commands, invoice               |
| 9   | Abrir mesa, adicionar itens e faturar com dinheiro                                           | critical   | commands, invoice               |
| 10  | Abrir mesa, adicionar itens e faturar com Pix Off                                            | critical   | commands, invoice               |
| 11  | Abrir mesa, registrar adiantamento com dinheiro e faturar com dinheiro                       | normal     | commands, advance               |
| 12  | Abrir mesa, registrar adiantamento com dinheiro e faturar com Pix Off                        | normal     | commands, advance               |
| 13  | Abrir mesa, dividir conta e pagar                                                            | normal     | commands, split_account         |
| 14  | Abrir mesa, alterar cliente e pagar                                                          | normal     | commands, change_client         |
| 15  | Abrir mesa, juntar contas e pagar                                                            | normal     | commands, join_accounts         |
| 16  | Abrir mesa e cancelar informando motivo                                                      | normal     | commands, cancel                |
| 17  | Abrir mesa e cancelar sem informar motivo                                                    | normal     | commands, cancel                |
| 18  | Abrir mesa, gerenciar taxa de serviço e pagar                                                | normal     | commands, manage_service_charge |

**Total implementado:** 18 cenários

### Agrupamento por funcionalidade — Commands

| Funcionalidade                                                             | Cenários    |
| -------------------------------------------------------------------------- | ----------- |
| Faturamento / Pagamento                                                    | 1, 8, 9, 10 |
| Adicionais de produto                                                      | 2           |
| Restrições de produto (não vender / não enviar / desativado / sem serviço) | 3, 4, 5, 6  |
| Promoção                                                                   | 7           |
| Adiantamento                                                               | 11, 12      |
| Divisão de conta                                                           | 13          |
| Alteração de cliente                                                       | 14          |
| Junção de contas                                                           | 15          |
| Cancelamento                                                               | 16, 17      |
| Taxa de serviço                                                            | 18          |

---

## Módulo: PDV (Smart PDV)

Pré-condição: app iniciado na tela inicial do Smart PDV.

### Grupo: Setup

| #  | Cenário                         | Severidade | Tipo         | Tags       |
| -- | ------------------------------- | ---------- | ------------ | ---------- |
| 1  | Configuração do ambiente do PDV | critical   | automatizado | pdv, setup |

### Grupo: Pedidos (Orders)

| #  | Cenário                                                                          | Severidade | Tipo         | Tags                   |
| -- | -------------------------------------------------------------------------------- | ---------- | ------------ | ---------------------- |
| 2  | Pedido simples                                                                   | critical   | automatizado | orders                 |
| 3  | Pedido pesquisando produto por nome, referência e código de barras               | normal     | automatizado | orders, filter         |
| 4  | Alterar quantidade de um item e remover outro item antes de finalizar a venda    | normal     | automatizado | orders, quantity       |
| 5  | Selecionar item, limpar pesquisa e cancelar pedido retornando à tela inicial     | normal     | automatizado | orders, cancel         |
| 6  | Alterar cliente no carrinho, adicionar outro item e finalizar a venda            | normal     | automatizado | orders, client         |
| 7  | Aplicar desconto em valor fixo no carrinho e finalizar a venda                   | normal     | automatizado | orders, discount       |
| 8  | Aplicar desconto percentual no carrinho e finalizar a venda                      | normal     | automatizado | orders, discount       |
| 9  | Aplicar desconto percentual em um item e desconto em valor fixo em outro item    | normal     | automatizado | orders, discount, item |
| 10 | Aplicar acréscimo percentual no carrinho e finalizar a venda                     | normal     | automatizado | orders, additional     |
| 11 | Aplicar acréscimo em valor fixo no carrinho e finalizar a venda                  | normal     | automatizado | orders, additional     |
| 12 | Editar quantidades e remover item no carrinho antes de finalizar a venda         | normal     | automatizado | orders, quantity       |
| 13 | Alterar cliente e finalizar pedido com boleto bancário                           | critical   | automatizado | orders, bankslip       |
| 14 | Pedido com pagamento em Pix Off                                                  | critical   | automatizado | orders, pixoff         |
| 15 | Pedido com variações de item e promoção                                          | normal     | automatizado | orders, item           |
| 16 | Pedido com tabela de preço                                                       | normal     | automatizado | orders, price-table    |
| 17 | Pedido adicionando itens pelo modo expresso                                      | normal     | automatizado | orders, express        |
| 18 | Pedido adicionando item pelo modo mini PDV                                       | normal     | automatizado | orders, mini-pdv       |
| 19 | Selecionar cliente no início do pedido, validar estoque e alterar preço unitário | normal     | automatizado | orders, smart-pdv      |
| 20 | Pedido com fiscal desativado (NFCe)                                              | critical   | automatizado | orders, fiscal         |
| 21 | Pedido sem método de pagamento configurado                                       | normal     | automatizado | orders, no-payment     |
| 22 | Pedido com emissão e reimpressão de ticket de retirada                           | normal     | automatizado | orders, ticket         |
| 23 | Sincronizar lista de clientes, selecionar cliente e iniciar pedido               | normal     | automatizado | orders, client         |
| 28 | Pedido com pagamento em Cartão de Crédito                                        | critical   | manual       | orders, payment        |
| 29 | Pedido com pagamento em Cartão de Débito                                         | critical   | manual       | orders, payment        |
| 30 | Pedido com pagamento em Pix (Adquirente)                                         | critical   | manual       | orders, payment        |
| 31 | Pedido com pagamento em Pix (Softcompay)                                         | critical   | manual       | orders, payment        |

### Grupo: Clientes (Clients)

| #  | Cenário                                                                     | Severidade | Tipo         | Tags              |
| -- | --------------------------------------------------------------------------- | ---------- | ------------ | ----------------- |
| 24 | Cadastrar cliente pessoa física com dados do Faker e verificar o registro   | normal     | automatizado | clients, register |
| 25 | Cadastrar cliente pessoa jurídica com dados do Faker e verificar o registro | normal     | automatizado | clients, register |

### Grupo: Lista de Pedidos (List Orders)

| #  | Cenário                                                                                                  | Severidade | Tipo         | Tags        |
| -- | -------------------------------------------------------------------------------------------------------- | ---------- | ------------ | ----------- |
| 26 | Navegar pela lista de pedidos: visualizar, reimprimir, acessar NF, cancelar pedido e imprimir relatórios | normal     | automatizado | orders-list |

### Grupo: Sincronização (Sync)

| #  | Cenário                             | Severidade | Tipo         | Tags |
| -- | ----------------------------------- | ---------- | ------------ | ---- |
| 27 | Sincronizar dados via modal na Home | critical   | automatizado | sync |

### Grupo: Estornos (Chargebacks)

| #  | Cenário                                    | Severidade | Tipo   | Tags              |
| -- | ------------------------------------------ | ---------- | ------ | ----------------- |
| 32 | Estorno com pagamento em Cartão de Crédito | critical   | manual | estorno, payment  |
| 33 | Estorno com pagamento em Cartão de Débito  | critical   | manual | estorno, payment  |
| 34 | Estorno com pagamento em Pix               | critical   | manual | estorno, payment  |
| 35 | Estorno com pagamento em Softcompay        | critical   | manual | estorno, payment  |

**Total implementado:** 35 cenários (27 automatizados · 8 manuais)

### Agrupamento por funcionalidade — PDV

| Funcionalidade                 | Cenários               |
| ------------------------------ | ---------------------- |
| Setup                          | 1                      |
| Pedidos — fluxo padrão         | 2, 3                   |
| Pedidos — quantidade e remoção | 4, 12                  |
| Pedidos — cancelamento         | 5                      |
| Pedidos — cliente              | 6, 23                  |
| Pedidos — desconto             | 7, 8, 9                |
| Pedidos — acréscimo            | 10, 11                 |
| Pedidos — formas de pagamento  | 13, 14, 28, 29, 30, 31 |
| Pedidos — variações e promoção | 15                     |
| Pedidos — tabela de preço      | 16                     |
| Pedidos — modos de operação    | 17, 18                 |
| Pedidos — funções Smart PDV    | 19                     |
| Pedidos — fiscal               | 20                     |
| Pedidos — sem pagamento        | 21                     |
| Pedidos — ticket               | 22                     |
| Clientes — cadastro            | 24, 25                 |
| Lista de pedidos               | 26                     |
| Sincronização                  | 27                     |
| Estornos                       | 32, 33, 34, 35         |

---

## Resumo Geral

| Suite          | Automatizados | Manuais | Total |
| -------------- | :-----------: | :-----: | :---: |
| commands.robot |      18       |    0    |  18   |
| pdv.robot      |      27       |    8    |  35   |
| **Total**      |    **45**     |  **8**  | **53** |

### Distribuição por severidade (cenários implementados)

| Severidade | Commands | PDV | Total |
| ---------- | :------: | :-: | :---: |
| critical   |    10    | 14  |  24   |
| normal     |    8     | 21  |  29   |
| minor      |    0     |  0  |   0   |
