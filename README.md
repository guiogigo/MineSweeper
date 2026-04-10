# [cite_start]Relatório MineSweeper [cite: 1]

[cite_start]**Disciplina:** Arquitetura e Organização de Computadores - Ciência da Computação UFCA [cite: 2]
[cite_start]**Autores:** Antônio José Monteiro Neto [cite: 3] [cite_start]e Guilherme Viana Batista [cite: 4]

[cite_start]Este projeto implementa as lógicas principais do jogo MineSweeper em Assembly MIPS[cite: 1, 2]. Abaixo estão descritas as funcionalidades de cada sub-rotina implementada no código.

---

## Funções Implementadas

### Função Play
* [cite_start]Antes de qualquer coisa, a instrução `save_context` foi utilizada para poder usar os registradores em segurança[cite: 6].
* [cite_start]O carregamento dos parâmetros foi feito através da instrução `move`: em `$s0` está o endereço do tabuleiro, em `$s1` estão as linhas da matriz e em `$s2` estão as colunas[cite: 7].
* [cite_start]Após o carregamento dos parâmetros, o tabuleiro é percorrido[cite: 12].
* [cite_start]Foram utilizadas três instruções em conjunto para descobrir a coordenada exata da posição do vetor: `sll`, `add` e `lw`[cite: 13].
* [cite_start]O `sll` é responsável por calcular o deslocamento correto da linha `i` no tabuleiro[cite: 19].
* [cite_start]Como cada palavra na memória é de 4 bits, e o tabuleiro tem 8 palavras por linha, multiplicar `i` por 8 e por 4 resulta na posição correta, o que reflete no deslocamento de 5 posições para a esquerda em `$s1`[cite: 18, 20]. [cite_start]Já `$s2` percorre as colunas com deslocamento de 2 posições[cite: 21, 29].
* [cite_start]A instrução `add` foi utilizada duas vezes: a primeira para somar os valores de endereço armazenados em `$t1` e `$t2` para guardar em `$t0`, e a segunda para somar o endereço do tabuleiro com os endereços das linhas e colunas[cite: 22, 23]. 
* [cite_start]Por fim, o `lw` foi utilizado para armazenar tudo em `$t4`, a fim de liberar o espaço ocupado em `$t0`[cite: 24].
* [cite_start]Para o sistema de verificação (se o jogador acertou bomba ou não), foram utilizadas as instruções `beq` e `bne`, que simulam os ifs do C com a lógica inversa[cite: 39, 40].
* [cite_start]Quando `$t4` for igual a `-1` (acertou bomba) pula para a função `return0`, e quando diferente de `-2` ele pula para a função `return1`, onde quer dizer que todas as coordenadas já foram reveladas e o jogador ganhou[cite: 45].
* [cite_start]Através da instrução `jal`, o código chama a função `CountAdjacentBombs`[cite: 46, 51].
* [cite_start]Após a chamada, o valor de `$v0` foi comparado para verificar se é necessário chamar a função `revealNeighboringCells`, que revela as coordenadas[cite: 54]. [cite_start]Se for igual a 0 chama a função e se for diferente pula para função `return1`[cite: 55].
* [cite_start]Por fim, as funções `return1` e `return0` servem para alterar o valor que guardam em `$v0`, que é o retorno da função play[cite: 57].

---

### Função CountAdjacentBombs
* [cite_start]Primeiramente foi utilizado a instrução `save_context` e em seguida passado os parâmetros[cite: 59].
* [cite_start]Após isso, foi utilizada a instrução `li` para adicionar o valor imediato 0 no registrador `$v0`[cite: 60].
* [cite_start]Foi declarado um valor de `i` somando-se -1 no registrador das linhas (`row - 1`) e, em seguida, adicionado 1 nas linhas (`row + 1`) para a condição do laço[cite: 67].
* [cite_start]Adiante, inicia-se o primeiro laço de repetição, denominado de `for_do_i`[cite: 70]. [cite_start]Através da instrução `bgt` foi verificado se `i > row + 1`; caso seja maior pula para a função `fim_for_do_i`, e caso contrário ele executa o segundo laço denominado de `for_do_j`[cite: 71].
* [cite_start]A primeira parte do `for_do_j` muda apenas a comparação, checando se `j > column + 1`[cite: 78, 79].
* [cite_start]O código realiza diversas outras comparações que seguem uma lógica inversa das que estão no C[cite: 115]. [cite_start]Caso todas sejam satisfeitas e o elemento seja `-1`, é utilizada a instrução `addi` como forma de `count++`[cite: 111, 114, 115].
* [cite_start]Na função `continue` ela faz `j++` e pula para o `for_do_j`[cite: 117].
* [cite_start]Já na função `fim_for_do_j` ela faz `i++` e pula para o `for_do_i`[cite: 118].
* [cite_start]Finalmente, na função `fim_for_do_i` ela usa a função `restore_context` e sai da função `CountAdjacentBombs`[cite: 119].

---

### Função RevealNeighboringCells
* [cite_start]Antes de tudo foi utilizado a instrução `save_context` e em seguida passado os parâmetros[cite: 130].
* [cite_start]Foi utilizada a instrução `li` para adicionar o valor imediato 0 no registrador `$v0`[cite: 131].
* [cite_start]Seguindo, são utilizadas as mesmas funções e argumentos que no `CountAdjacentBombs`, mas com o objetivo de, por meio da instrução `bne`, conferir se a coordenada adjacente foi realmente revelada[cite: 142, 143].
* [cite_start]Após conferir, é chamada a função `CountAdjacentBombs`[cite: 178].
* [cite_start]A coordenada só é revelada se a quantidade de bombas for 0; então o count é acionado e confere se é `> 0`[cite: 178].
* [cite_start]Se o valor for diferente de 0, existem bombas ao redor e não são reveladas coordenadas adjacentes[cite: 191]. [cite_start]Se for igual a 0, significa que não existem bombas ao redor e as coordenadas adjacentes são reveladas[cite: 192].
* [cite_start]Por fim, temos as funções responsáveis por marcar o fim dos loopings internos (`continue`, `fim_for_do_j`, `fim_for_do_i`)[cite: 203].

---

### Função CheckVictory
* [cite_start]Além do `save_context`, inicializamos um contador de coordenadas reveladas e um `i` para percorrer a matriz do tabuleiro[cite: 214].
* [cite_start]Abrimos o laço de repetição `i_for`, onde ele vai verificar, através do `bge`, se o `i >= SIZE`[cite: 220]. 
* [cite_start]Caso a condição seja satisfeita, pula para `fim_for_do_i` e sai do laço; caso contrário, é criado um `j` e o laço de repetição `j_for`[cite: 221, 222].
* [cite_start]Dentro do laço `j_for` é feita outra comparação: `j >= SIZE`[cite: 229]. [cite_start]Caso satisfeita, pula para o fim do laço; caso contrário, começa a ser calculado o índice da coordenada atual com o intuito de verificar se já foi revelada[cite: 230, 231].
* Após calcular, verifica através do `bge` se o valor da coordenada `>= 0`. [cite_start]Caso seja satisfeita, pula para a função `coord_nao_revelada`[cite: 248, 251].
* [cite_start]Caso `< 0`, continua a verificação, incrementando 1 ao contador criado no começo da `CheckVictory`[cite: 252].
* [cite_start]Entrando na função `coord_nao_revelada`, será incrementado 1 ao `j` criado e pulando pro `j_for` com esse valor, até satisfazer a condição[cite: 253, 254].
* [cite_start]Para finalizar, as funções de fim dos loopings analisam o contador; caso seja retornado 1 (`beq $t0, BOMB_COUNT`), o jogo é finalizado com a vitória do jogador[cite: 258, 259, 265].
