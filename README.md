# CAMPO MINADO

## Getting Started
Jogo Campo Minado desenvolvido em Ruby para fins teste de conhecimento

### Pré-requisito
Sem dependências

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

- jogando?: Verifica se o jogo esta em andamento, ou seja, quando não foi descoberto bomba ou aberto todas as células válidas. Se errar (clicar em uma bomba) ou abrir todas as células válidas, terá o retorno negativo.

```
jogo = CampoMinado.new(10, 20, 50)

if jogo.jogando?
	puts "Jogo em andamento!"
end
```

- jogar(x, y): Realiza jogada em uma célula. Recebe as coordenadas (X, Y) e clica na célula correpondendo, relevando espaço vazio, número de bombas em volta ou a própria bomba.

```
jogo = CampoMinado.new(10, 20, 50)

if jogo.jogar(0, 0)
	puts "Jogada válida"
end
```

- marcar_bandeira(x, y): Faz uma marcação de bandeira. A célula marcada com bandeira não permite jogada. Se enviar outra marcação na célula marcada com bandeira, irá desmarcar.

```
jogo = CampoMinado.new(10, 20, 50)

if jogo.marcar_bandeira(0, 0)
	puts "Marcação de bandeira válida"
end
```

- estado_atual: - Retorna a matriz do jogo com os campos já relevados. Passando como paramêtro *xray: true* e o jogo estiver perdido, retorna a matriz com as bombas reveladas.

```
jogo = CampoMinado.new(10, 20, 50)

puts jogo.estado_atual
```

- ganhou?: - Retorna positivo quando a partida finalizou e abriu todas as céluas válidas.

```
jogo = CampoMinado.new(10, 20, 50)

if jogo.ganhou?
	puts "Você ganhou! :D"
else
	puts "Você perdeu! :("
end
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

Cria um jogo com 10 linhas, 20 colunas e 50 bombas. Realiza jogadas e marcações de bandeira aleatoriamente. Finaliza o processo quando perde ou ganha.

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
Qtd. linhas [padrão: 10]: 5
Qtd. colunas [padrão: 20]: 10
Qtd. de bombas [padrão: 50]: 5
  __________[5 x 10]___________
 | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|
1| .| .| .| .| .| .| .| .| .| .|
2| .| .| .| .| .| .| .| .| .| .|
3| .| .| .| .| .| .| .| .| .| .|
4| .| .| .| .| .| .| .| .| .| .|
5| .| .| .| .| .| .| .| .| .| .|
  =============================
Informe a posição ou 0 para marcar uma bandeira (flag)
Posição(x): 
```

## Referências
* [Ruby on Rails](https://rubificando.wordpress.com/2009/03/02/matrizes) - Matrizes
* [tutorialspoint](https://www.tutorialspoint.com/ruby/index.htm) - Ruby Tutorial
* [Stack Overflow](https://stackoverflow.com/questions/2889720/one-liner-in-ruby-for-displaying-a-prompt-getting-input-and-assigning-to-a-var) - One liner in Ruby for displaying a prompt, getting input, and assigning to a variable?

## Autor
* **Ricardo Cajueiro** - *Software Developer* - [rccajueiro](https://github.com/rccajueiro)

## Considerações finais
