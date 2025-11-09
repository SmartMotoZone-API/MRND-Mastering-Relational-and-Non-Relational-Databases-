---

## 🛵 Projeto SQL – Sistema de Gestão de Motos

Este projeto foi desenvolvido como parte da disciplina **Mastering Relational and Non-Relational Databases (MRND)** do curso da **FIAP**. O objetivo é praticar conceitos de banco de dados relacional utilizando **Oracle SQL**, com foco em criação de tabelas, relacionamentos, consultas e programação PL/SQL.

---

### 📁 Estrutura do Projeto

O sistema simula o **gerenciamento de manutenção e auditoria de motos em uma empresa de serviços automotivos**.  
As seguintes entidades fazem parte do modelo relacional desenvolvido:

* **Clientes** – Representam os proprietários das motos cadastradas no sistema.  
* **Motos** – Armazena informações detalhadas sobre os veículos, incluindo modelo, placa e cor, vinculadas a cada cliente.  
* **Ordens de Serviço** – Registra os atendimentos de manutenção realizados nas motos, com descrição, data e valor de serviço.  
* **Fatos de Saldos (FACT_SALDOS)** – Tabela de fatos utilizada para cálculos de somatórios, subtotais e total geral por agência e conta.  
* **Auditoria de Operações** – Responsável por registrar automaticamente todas as ações de **INSERT**, **UPDATE** e **DELETE** executadas nas ordens de serviço, garantindo rastreabilidade das alterações.
---

#---

## 🧠 Objetivo do Projeto

O objetivo deste projeto é demonstrar a **implementação completa de um banco de dados relacional Oracle**, com:
- Criação e carga de tabelas;
- Desenvolvimento de **funções e procedimentos PL/SQL**;
- Conversão de dados relacionais para JSON de forma **manual**;
- **Cálculo de somatórios** sem funções automáticas (ROLLUP, CUBE);
- **Gatilho (Trigger)** de auditoria para operações DML;
- Tratamento de exceções e documentação técnica.

---

## ⚙️ 1. Configuração e Conexão no VS Code

### 📦 Pré-requisitos:
- Oracle Database 21c XE (ou 19c XE);
- Oracle Instant Client (caso o banco não seja local);
- Extensão instalada:
  > **Oracle SQL Developer Extension for VS Code**

### 🔗 Criando a conexão no Oracle Explorer:
1. No VS Code, abra o **Oracle Explorer** (ícone de banco de dados na lateral esquerda).
2. Clique em **“+ Create Connection”**.
3. Preencha os campos:
   | Campo | Valor |
   |--------|--------|
   | Connection Name | Sprint3 |
   | Username | system |
   | Password | (sua senha Oracle) |
   | Hostname | localhost |
   | Port | 1521 |
   | Service Name | XEPDB1 |
4. Clique em **Test** → deve mostrar “Status: Success”.
5. Clique em **Save**.

---

## ⚙️ 2. Execução do Projeto

### ▶️ Passos para rodar o projeto:
1. Abra o arquivo **`Script_Geral.sql`**.
2. Certifique-se de que o **DBMS Output** está habilitado:
   - Vá em `View → Output` e selecione `Oracle Output`.
3. Execute o script completo com `Ctrl + F5` ou clicando no ícone ▶️.
4. A saída aparecerá no painel “Oracle Output”.

---

## 📄 3. Descrição dos Arquivos SQL

### 🧱 `Drop_Tables.sql`
Remove as tabelas existentes para recriação do ambiente, evitando conflitos.

### 🧩 `Create_Tables.sql`
Cria as tabelas do sistema:
- **TB_CLIENTE:** dados de clientes;
- **TB_MOTO:** motos vinculadas a clientes;
- **TB_ORDEM_SERVICO:** ordens de manutenção com data e valor;
- **FACT_SALDOS:** tabela de fatos com agência, conta e saldo;
- **AUDITORIA_OPERACOES:** registros da trigger de auditoria.

### 🧾 `Inserts.sql`
Popula o banco com dados de exemplo (mínimo de 5 registros por tabela).

### 🧮 `Funcoes.sql`
Contém duas funções PL/SQL:
1. **`FN_TO_JSON`** – Converte registros relacionais para JSON manualmente.  
   - Não usa funções nativas (ex: JSON_OBJECT).  
   - Contém tratamento de exceções para dados divergentes.  
2. **`FN_VALIDA_SENHA`** – Implementa regra de negócio para validação de senha.  
   - Exceções: senha nula, curta ou fraca.

### ⚙️ `Procedimentos.sql`
Define dois procedimentos principais:
1. **`PRC_LISTAR_OS_JSON`** – Realiza JOIN entre tabelas relacionais e converte o resultado em JSON.
2. **`PRC_SOMA_AG_CONTA`** – Calcula somatórios manuais com subtotais e total geral (sem funções automáticas).

### 🧰 `Trigger_Auditoria.sql`
Implementa trigger **AFTER INSERT/UPDATE/DELETE** sobre `TB_ORDEM_SERVICO`:
- Registra operação, usuário, data/hora, e valores antigos/novos em `AUDITORIA_OPERACOES`.

### 🧾 `Script_Geral.sql`
Executa todos os scripts na ordem correta:
```sql
@Drop_Tables.sql
@Create_Tables.sql
@Inserts.sql
@Funcoes.sql
@Procedimentos.sql
@Trigger_Auditoria.sql