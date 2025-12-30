# 🛠️ Oficina Mecânica – Sistema de Banco de Dados Relacional

Projeto de modelagem, implementação e validação de banco de dados relacional para um sistema de gerenciamento de oficina mecânica, desenvolvido com foco em boas práticas de modelagem, integridade dos dados e escalabilidade.

Este projeto faz parte do meu portfólio profissional e demonstra competências em SQL, modelagem ER, normalização e análise de regras de negócio.

---

## 🎯 Visão Geral do Projeto

O sistema foi projetado para atender os principais processos de uma oficina mecânica, permitindo o controle de:

- Clientes (Pessoa Física e Jurídica)
- Veículos
- Ordens de Serviço
- Equipe Mecânica
- Peças e Controle de Estoque

Toda a estrutura foi pensada para refletir cenários reais de negócio, possibilitando relatórios operacionais e financeiros.

---

## 🧠 Principais Competências Demonstradas

- Modelagem de Dados (Modelo ER)
- Normalização (até 3FN)
- Criação de tabelas com **DDL**
- Manipulação de dados com **DML**
- Uso de:
  - Chaves primárias e estrangeiras
  - Relacionamentos 1:N e N:N
  - Constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`)
  - Tipos adequados (`ENUM`, `DECIMAL`, `DATE`)
- Escrita de **queries analíticas**
- Estruturação de projeto para versionamento (Git/GitHub)

---

## 🗂️ Estrutura do Banco de Dados

### Entidades Principais
- clientes – Cadastro de clientes com validação de CPF/CNPJ
- carros – Veículos atendidos pela oficina
- ordem_servico – Controle das ordens de serviço
- equipe_mecanica – Mecânicos e especialidades
- peca– Cadastro de peças
- estoque – Controle de quantidade disponível

### Tabelas Associativas
- cliente_carro – Relacionamento N:N entre clientes e veículos
- equipe_ordem_servico – Relacionamento N:N entre equipe e ordens
- ordem_servico_peca – Controle de peças utilizadas por ordem

---

## 🔗 Regras de Negócio Implementadas

- Um cliente pode possuir múltiplos veículos
- Um veículo pode ter diversas ordens de serviço
- Uma ordem de serviço pode envolver mais de um mecânico
- Cada ordem de serviço pode consumir múltiplas peças
- O estoque controla a disponibilidade de peças por item
- Status da ordem de serviço controlado por ENUM

---

## 🛠️ Tecnologias Utilizadas

- **MySQL 8+**
- **SQL (DDL / DML)**
- MySQL Workbench (modelagem e testes)
- Git e GitHub para versionamento
