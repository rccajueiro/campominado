# CAMPO MINADO

## Getting Started
Campo Minado desenvolvido em Ruby.

### Pré-requisito
- Ruby
```
$ ruby -v
ruby 2.2.3p173 (2015-08-18 revision 51636) [x86_64-darwin14]
```

### Instalação
```
git clone https://github.com/rccajueiro/campominado.git
```

### Uso
```
require './app/lib/CampoMinado'
require './app/lib/PrettyPrinter'

largura, altura, qtd_bombas = 10, 20, 50
jogo = CampoMinado.new(largura, altura, qtd_bombas)
PrettyPrinter.new.print jogo.estado_atual
```

Resultado
```
   _________________________[10 x 20]_________________________
  | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16|17|18|19|20|
 1| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 2| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 3| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 4| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 5| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 6| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 7| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 8| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 9| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
10| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
   ===========================================================
```

### Métodos

- jogar(x, y): recebe as coordenadas x e y do tabuleiro e clica na célula correspondente; a célula passa a ser "descoberta". Deve retornar um booleano informando se a jogada foi válida. A jogada é válida somente se a célula selecionada ainda não foi clicada e ainda não tem uma bandeira. Caso a célula clicada seja válida, não tenha uma bomba e seja vizinha de zero bombas, todos os vizinhos sem bomba e sem bandeira daquela célula também devem ser descobertas, e devem seguir esta mesma lógica para seus próprios vizinhos (esse é o comportamento de expansão quando clicamos em uma grande área sem bombas no jogo de campo minado).

```
jogo = CampoMinado.new(10, 20, 50)

if jogo.jogar(0, 0)
	puts "Jogada válida"
end
```

- marcar_bandeira(x, y): diciona uma bandeira a uma célula ainda não clicada ou remove a bandeira preexistente de uma célula. Retorna um booleano informando se a jogada foi válida.

```
jogo = CampoMinado.new(10, 20, 50)

if jogo.marcar_bandeira(0, 0)
	puts "Marcação de bandeira válida"
end
```

- jogando?: retorna true se o jogo ainda está em andamento, ou false se o jogador tiver alcançado a condição de vitória (todas as células sem bomba foram descobertas) ou de derrota (jogador clicou em uma célula sem bandeira e ela tinha uma bomba).

```
jogo = CampoMinado.new(10, 20, 50)

if jogo.jogando?
  puts "Jogo em andamento!"
end
```

- ganhou?: retorna true somente se o jogo já acabou e o jogador ganhou.

```
jogo = CampoMinado.new(10, 20, 50)

if jogo.ganhou?
  puts "Você ganhou! :D"
else
  puts "Você perdeu! :("
end
```

- estado_atual: retorna uma representação atual do tabuleiro, indicando quais células ainda não foram descobertas, se alguma foi descoberta e tem uma bomba, quais foram descobertas e têm células com bombas como vizinhas (indicar quantas são as vizinhas minadas), quais não estão descobertas e com bandeira. Se o cliente passar o hash {xray: true} como parâmetro, deve indicar a localização de todas as bombas, mas somente se o jogo estiver terminado.

```
jogo = CampoMinado.new(10, 20, 50)

puts jogo.estado_atual
```

onde,
```
estado_atual_formato: {
  CELULA_FECHADA:       '.',
  CELULA_VAZIA:         '',
  CELULA_COM_BOMBA:     '#',
  CELULA_COM_BANDEIRA:  'F'
}
```

### Testes unitário

```
ruby test/TestCampoMinadoIniciacao.rb
```

```
ruby test/TestCampoMinadoValidacao.rb
```

```
ruby test/TestCampoMinado.rb
```

## Aplicativos

### apptest.rb

Cria um jogo com 10 linhas, 20 colunas e 50 bombas. Realiza jogadas e marcações de bandeira aleatoriamente. Finaliza quando perde ou ganha.

```
ruby apptest.rb
```

Resultado

```
..........F.........
.......2............
....................
....................
....................
....................
....................
....................
....................
....................
____________________
..........F.#.......
.......2............
....................
...............F....
....................
....................
....................
....................
....................
....................
____________________
Fim do jogo!
Você perdeu! As minas eram:
   _________________________[10 x 20]_________________________
  | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16|17|18|19|20|
 1| .| #| .| .| .| .| .| .| .| .| #| .| #| .| .| .| #| .| .| .|
 2| .| .| .| #| .| #| .| 2| .| .| .| .| #| .| .| .| .| .| .| .|
 3| #| .| .| .| .| .| .| #| #| .| .| .| #| #| #| #| .| .| #| .|
 4| .| #| .| #| #| #| .| .| .| .| .| .| #| #| #| #| #| .| .| .|
 5| #| .| .| .| .| .| .| .| .| .| .| #| .| .| #| .| #| .| .| .|
 6| .| .| .| .| .| .| .| .| .| .| .| .| .| #| #| .| .| .| #| .|
 7| #| .| .| .| .| .| .| #| .| #| .| .| .| .| .| .| #| .| .| .|
 8| .| .| .| .| .| .| .| .| #| #| #| .| #| .| .| .| #| #| .| .|
 9| #| #| .| .| #| #| .| #| .| #| #| .| .| .| .| #| #| .| .| .|
10| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
   ===========================================================
```

### jogar.rb

Aplicativo interativo do jogo.

```
ruby jogar.rb
```

Resultado

```
....::::: CAMPO MINADO :::::....
CTRL+C para SAIR
Qtd. linhas [padrão: 10]: 5
Qtd. colunas [padrão: 20]: 10
Qtd. de bombas [padrão: 50]: 5_
```

```
....::::: CAMPO MINADO :::::....
CTRL+C para SAIR
Linhas: 5 / Colunas: 10 / Qtd.bombas: 5
  __________[5 x 10]___________
 | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|
1| .| .| .| .| .| .| .| .| .| .|
2| .| .| .| .| .| .| .| .| .| .|
3| .| .| .| .| .| .| .| .| .| .|
4| .| .| .| .| .| .| .| .| .| .|
5| .| .| .| .| .| .| .| .| .| .|
  =============================
Informe a posição ou 0 para marcar uma bandeira (flag)
Posição(x): _
```

## Extras

### SimplePrinter.rb

Visualiza a matriz do jogo de forma simples. Exemplo de um jogo com 10 linhas, 20 colunas e 50 bombas:

```
require './app/lib/CampoMinado/CampoMinado'
require './app/lib/SimplePrinter'

SimplePrinter.new.print CampoMinado.new(10, 20, 50).estado_atual
```

Resultado
```
____________________
....................
....................
....................
....................
....................
....................
....................
....................
....................
....................
====================
```

### PrettyPrinter.rb

Visualiza a matriz do jogo de forma mais completa, com as linhas e colunas mais visíveis, incluindo posições das linhas e colunas. Exemplo de um jogo com 10 linhas, 20 colunas e 50 bombas:

```
require './app/lib/CampoMinado/CampoMinado'
require './app/lib/PrettyPrinter'

PrettyPrinter.new.print CampoMinado.new(10, 20, 50).estado_atual
```

Resultado
```
   _________________________[10 x 20]_________________________
  | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16|17|18|19|20|
 1| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 2| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 3| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 4| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 5| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 6| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 7| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 8| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
 9| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
10| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .| .|
   ===========================================================
```

### SimpleJSON.rb

Classe de conversão para string JSON.

- stringfy: retorna uma string JSON.
```
require './app/lib/CampoMinado/CampoMinado'
require './app/lib/SimpleJSON'

puts SimpleJSON.new.stringfy matriz: CampoMinado.new(3, 5, 5).estado_atual
```

Resultado
```
{"matriz":[[".",".",".",".","."],[".",".",".",".","."],[".",".",".",".","."]]}
```

- pretty: retorna uma string JSON em formato mais amigável.
```
require './app/lib/CampoMinado/CampoMinado'
require './app/lib/SimpleJSON'

puts SimpleJSON.new.pretty matriz: CampoMinado.new(3, 5, 5).estado_atual
```

Resultado
```
{
  "matriz": [
    [
      ".",
      ".",
      ".",
      ".",
      "."
    ],
    [
      ".",
      ".",
      ".",
      ".",
      "."
    ],
    [
      ".",
      ".",
      ".",
      ".",
      "."
    ]
  ]
}
```

## Referências

* [Rubificando on Rails](https://rubificando.wordpress.com/2009/03/02/matrizes) - Matrizes
* [tutorialspoint](https://www.tutorialspoint.com/ruby/index.htm) - Ruby Tutorial
* [Stack Overflow](https://stackoverflow.com/questions/2889720/one-liner-in-ruby-for-displaying-a-prompt-getting-input-and-assigning-to-a-var) - One liner in Ruby for displaying a prompt, getting input, and assigning to a variable?

## Autor

* **Ricardo Cajueiro** - *Software Developer* - [rccajueiro](https://github.com/rccajueiro)

## Considerações

- No início foi realizado o desenvolvimento do core da engine principal, ou seja, toda lógica de funcionamento do sistema de campo minado;
- Em seguida realizado os testes unitários;
- Enquanto desenvolvia dos testes unitários foi tendo necessidade de eventuais ajustes no core com melhorias de performance, clean code e validações;
- Os testes realizados prevem todas situações possíveis;
- Interface "jogável" (jogar.rb) desenvolvida utilizando boas práticas de UX (dentro da limitação do console) visando simplicidade e facilidade de navegação/utilização.

## Outras considerações

- Esse foi meu primeiro contato mais aprofundado com a sintaxe Ruby;
- Da mesma forma em PHP, o Ruby é dinamicamente tipado e isso facilitou a adaptação;
- Estou acostumado com lingagens que utilizam chaves "{}" para iniciar e finalizar trechos como loops, condições, funcões/classes/métodos, etc; e ";" para finalizar instruções. No começo tive um pouco de dificuldade mas logo peguei o jeito;
- Em PHP, se testar 0 é considerado false, para testar se é 0 (número) deve usar ===. Em Ruby "nil" e "false" serem falso facilita muito o desenvolvimento;
- Sendo opcional o uso dos parêntesis, deixa o código mais clean e facilita a leitura e organização;
- Strings, números, arrays, hashes, etc serem objetos, também facilita o uso e organização;
- Nesse exercício tive a oportunidade de aprofundar no conhecimento do Ruby. Ainda tem muita à aprender e novos desafios a trilhar.