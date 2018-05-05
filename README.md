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

*jogando?*
*jogar(x, y)*
*marcar_bandeira(x, y)*
*estado_atual*
*ganhou?*

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
```
ruby apptest.rb
```

### jogar.rb
```
ruby jogar.rb
```

## Referências
* [Ruby on Rails](https://rubificando.wordpress.com/2009/03/02/matrizes) - Matrizes
* [tutorialspoint](https://www.tutorialspoint.com/ruby/index.htm) - Ruby Tutorial
* [Stack Overflow](https://stackoverflow.com/questions/2889720/one-liner-in-ruby-for-displaying-a-prompt-getting-input-and-assigning-to-a-var) - One liner in Ruby for displaying a prompt, getting input, and assigning to a variable?

## Autor
* **Ricardo Cajueiro** - *Software Developer* - [PurpleBooth](https://github.com/rccajueiro)

## Considerações finais
