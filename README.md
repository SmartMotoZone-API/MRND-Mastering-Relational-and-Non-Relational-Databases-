Perfeito! Abaixo está um **README mais elaborado e profissional**, mantendo a simplicidade e clareza. Adicionei também a autoria e a instituição conforme solicitado.

---

## 🛵 Projeto SQL – Sistema de Gestão de Motos

Este projeto foi desenvolvido como parte da disciplina **Mastering Relational and Non-Relational Databases (MRND)** do curso da **FIAP**. O objetivo é praticar conceitos de banco de dados relacional utilizando **Oracle SQL**, com foco em criação de tabelas, relacionamentos, consultas e programação PL/SQL.

---

### 📁 Estrutura do Projeto

O sistema simula o gerenciamento de motos dentro de uma empresa de logística e rastreamento. As seguintes entidades fazem parte do modelo:

* **Zonas** – Áreas onde as motos circulam.
* **Funcionários** – Responsáveis pela manutenção e supervisão.
* **Usuários** – Operadores, supervisores e administradores do sistema.
* **Motos** – Motos rastreadas com status e localizações.
* **Movimentações** – Histórico de movimentações das motos entre zonas.

---

### ⚙️ Funcionalidades Implementadas

* Criação completa das tabelas com chaves primárias e estrangeiras.

* Inserção de dados com integridade referencial (pais antes dos filhos).

* Bloco PL/SQL com **3 consultas** utilizando:

  * `JOIN`
  * `GROUP BY`
  * `ORDER BY`

* Bloco PL/SQL que exibe:

  * Valor **anterior**, **atual** e **próximo** de um campo (coluna `modelo` de motos), utilizando `LAG` e `LEAD`.

---

### 🧪 Exemplos de Saída

#### 📊 Relatório 1 – Motos por Zona

```
--- Motos por Zona ---
Zona: A1 - Total Motos: 1
Zona: A2 - Total Motos: 1
Zona: B1 - Total Motos: 1
...
```

#### 🔄 Relatório 2 – Contexto de Modelos (LAG/LEAD)

```
Modelo Anterior     | Modelo Atual   | Modelo Próximo   
---------------------|----------------|-------------------
Vazio               | Honda CG 160   | Yamaha Fazer      
Honda CG 160        | Yamaha Fazer   | Suzuki Yes        
Yamaha Fazer        | Suzuki Yes     | Honda Biz         
...
```

---

### 💻 Como Executar

1. Acesse o ambiente Oracle SQL Developer ou Oracle Live SQL.
2. Copie e cole o script `DDL + INSERT + PL/SQL`.
3. Execute com `SET SERVEROUTPUT ON` ativado para ver os resultados.

---

### 🏫 Instituição

**FIAP – Faculdade de Informática e Administração Paulista**

---

### 👨‍💻 Autor

**Kaio Cumpian Silva**
Disciplina: **MRND – Mastering Relational and Non-Relational Databases**

---

Se quiser, posso salvar esse conteúdo em um arquivo `.md` para você colar direto no GitHub. Deseja isso?
