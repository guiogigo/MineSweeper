# 💣 MineSweeper em Assembly (MIPS)

![Status](https://img.shields.io/badge/status-concluído-success)
![Assembly](https://img.shields.io/badge/language-MIPS%20Assembly-blue)
![UFCA](https://img.shields.io/badge/university-UFCA-orange)

Implementação do clássico **MineSweeper** utilizando **Assembly MIPS**, desenvolvida como projeto da disciplina de **Arquitetura e Organização de Computadores**.

---

## 📖 Sobre o Projeto

Este projeto tem como objetivo explorar conceitos de **baixo nível**, como manipulação direta de memória, uso de registradores e controle de fluxo, por meio da implementação da lógica do jogo MineSweeper.

A aplicação simula integralmente o comportamento do jogo, incluindo:

* Revelação de células
* Identificação de bombas
* Expansão de áreas seguras
* Verificação de condição de vitória

---

## 👨‍💻 Autores

* **Guilherme Viana Batista**
* **Antônio José Monteiro Neto**

---

## 🧠 Arquitetura da Solução

O sistema é estruturado em funções modulares, cada uma responsável por uma parte da lógica do jogo.

### ▶️ `Play`

Função principal responsável pela execução do jogo.

**Responsabilidades:**

* Gerenciamento de contexto (`save_context` / `restore_context`)
* Carregamento de parâmetros do tabuleiro
* Cálculo de endereços na memória
* Controle do fluxo principal do jogo
* Integração com funções auxiliares

---

### 💥 `CountAdjacentBombs`

Calcula o número de bombas adjacentes a uma célula.

**Detalhes técnicos:**

* Iteração em vizinhança 3x3
* Uso de loops com `branch`
* Incremento condicional com `addi`

---

### 🔍 `RevealNeighboringCells`

Responsável pela expansão de células seguras.

**Comportamento:**

* Verifica células adjacentes
* Chama `CountAdjacentBombs`
* Expande recursivamente regiões sem bombas

---

### 🏆 `CheckVictory`

Determina se o jogador venceu.

**Critério:**

* Todas as células seguras foram reveladas

---

## ⚙️ Detalhes de Implementação

### 🧮 Cálculo de Endereços

O acesso ao tabuleiro é feito via cálculo manual de índice:

* Uso de `sll` para multiplicação por potência de 2
* Combinação de:

  * deslocamento de linha
  * deslocamento de coluna
* Acesso final com `lw`

---

### 🔀 Controle de Fluxo

Simulação de estruturas de alto nível:

| Estrutura         | Instruções   |
| ----------------- | ------------ |
| `if`              | `beq`, `bne` |
| `for`             | `bgt`, `bge` |
| chamada de função | `jal`        |

---

### 🧾 Representação do Tabuleiro

| Valor  | Significado                 |
| ------ | --------------------------- |
| `-1`   | Bomba                       |
| `-2`   | Célula não revelada         |
| `>= 0` | Número de bombas adjacentes |

---

## 🚀 Como Executar

> ⚠️ Este projeto foi desenvolvido para execução em simuladores MIPS.

### Requisitos:

* MARS ou SPIM

### Passos:

1. Carregue o arquivo `.asm` no simulador
2. Execute o programa
3. Interaja conforme a lógica implementada

---

## 🎯 Objetivos de Aprendizado

* Manipulação de memória em baixo nível
* Uso eficiente de registradores
* Implementação de estruturas de controle sem abstrações
* Organização de código Assembly em módulos

---

## 📌 Observações

* Projeto focado em lógica — não possui interface gráfica
* Implementação orientada à performance e controle manual
* Estrutura baseada em chamadas de função e reutilização de código

---

## 🏫 Contexto Acadêmico

**Disciplina:** Arquitetura e Organização de Computadores
**Curso:** Ciência da Computação
**Instituição:** Universidade Federal do Cariri (UFCA)

---

## 📄 Licença

Este projeto é acadêmico e não possui licença definida.
