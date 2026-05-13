# Tests Coverage — Cenários Implementados

> Última atualização: 2026-05-13
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

> **Nota:** os cenários de Login, Configurações e Cadastro de Cliente estão comentados no arquivo fonte — ainda não implementados.

### Grupo: Pedidos (Orders)

| #   | Cenário                                                                      | Severidade | Tags               |
| --- | ---------------------------------------------------------------------------- | ---------- | ------------------ |
| 1   | Pedido iniciado a partir da tela de clientes                                 | normal     | orders             |
| 2   | Cancelar pedido em andamento na tela de novo pedido                          | normal     | orders, cancel     |
| 3   | Cancelar pedido em andamento na tela de carrinho                             | normal     | orders, cancel     |
| 4   | Abrir cancelamento na tela de novo pedido, escolher Não e finalizar o pedido | minor      | orders, cancel     |
| 5   | Abrir cancelamento na tela de carrinho, escolher Não e finalizar o pedido    | minor      | orders, cancel     |
| 6   | Alterar a quantidade de um item no carrinho e finalizar o pedido             | normal     | orders             |
| 7   | Pedido com conferência desativada (fluxo direto)                             | normal     | orders, conference |
| 8   | Pedido com conferência desativada validando o carrinho                       | normal     | orders, conference |
| 9   | Aplicar desconto percentual em um item e finalizar o pedido                  | normal     | orders, discount   |
| 10  | Aplicar desconto em valor inteiro em um item e finalizar o pedido            | normal     | orders, discount   |
| 11  | Remover itens via long press e ícone do carrinho (confirma)                  | normal     | orders             |
| 12  | Tentar remover itens e cancelar as remoções                                  | minor      | orders             |
| 13  | Pedido com ticket configurado para impressão automática                      | normal     | orders, ticket     |
| 14  | Pedido com ticket configurado para perguntar — responde Sim                  | normal     | orders, ticket     |
| 15  | Pedido com ticket configurado para perguntar — responde Não                  | normal     | orders, ticket     |
| 16  | Pedido com pagamento em dinheiro                                             | critical   | orders, payment    |
| 17  | Pedido com pagamento em Pix Off                                              | critical   | orders, payment    |
| 18  | Pedido com pagamento em boleto bancário                                      | normal     | orders, payment    |

### Grupo: Lista de Pedidos (List Orders)

| #   | Cenário                                                           | Severidade | Tags        |
| --- | ----------------------------------------------------------------- | ---------- | ----------- |
| 19  | Visualizar detalhes do primeiro pedido na lista                   | minor      | list_orders |
| 20  | Reimprimir o primeiro pedido na lista                             | minor      | list_orders |
| 21  | Cancelar o primeiro pedido na lista                               | normal     | list_orders |
| 22  | Imprimir recebimentos a partir da lista de pedidos                | minor      | list_orders |
| 23  | Imprimir resumo de vendas a partir da lista de pedidos            | minor      | list_orders |
| 24  | Abrir menu de impressão da lista de pedidos e voltar sem imprimir | minor      | list_orders |

### Grupo: Sincronização (Sync)

| #   | Cenário                                          | Severidade | Tags |
| --- | ------------------------------------------------ | ---------- | ---- |
| 25  | Abrir sincronização e cancelar antes de concluir | minor      | sync |
| 26  | Sincronizar produtos                             | normal     | sync |
| 27  | Sincronizar clientes                             | normal     | sync |
| 28  | Sincronizar pedidos                              | normal     | sync |
| 29  | Sincronizar todos os dados                       | normal     | sync |

**Total implementado:** 29 cenários

### Cenários comentados (não implementados) — PDV

| Cenário                                                   | Motivo                          |
| --------------------------------------------------------- | ------------------------------- |
| Login — email inválido                                    | Comentado, keyword não definida |
| Login — senha inválida                                    | Comentado, keyword não definida |
| Login — logoff                                            | Comentado, keyword não definida |
| Login — sucesso                                           | Comentado, keyword não definida |
| Configurações — setup de impressora e formas de pagamento | Comentado, keyword não definida |
| Clientes — cadastrar novo cliente                         | Comentado, keyword não definida |

### Agrupamento por funcionalidade — PDV

| Funcionalidade                | Cenários               |
| ----------------------------- | ---------------------- |
| Pedidos — fluxo de cliente    | 1                      |
| Pedidos — cancelamento        | 2, 3, 4, 5             |
| Pedidos — quantidade de itens | 6                      |
| Pedidos — conferência         | 7, 8                   |
| Pedidos — desconto            | 9, 10                  |
| Pedidos — remoção de itens    | 11, 12                 |
| Pedidos — ticket              | 13, 14, 15             |
| Pedidos — formas de pagamento | 16, 17, 18             |
| Lista de pedidos              | 19, 20, 21, 22, 23, 24 |
| Sincronização                 | 25, 26, 27, 28, 29     |

---

## Resumo Geral

| Suite          | Implementados | Comentados / Pendentes |
| -------------- | :-----------: | :--------------------: |
| commands.robot |      18       |           0            |
| pdv.robot      |      29       |           6            |
| **Total**      |    **47**     |         **6**          |

### Distribuição por severidade (cenários implementados)

| Severidade | Commands | PDV | Total |
| ---------- | :------: | :-: | :---: |
| critical   |    10    |  3  |  13   |
| normal     |    8     | 18  |  26   |
| minor      |    0     |  8  |   8   |
