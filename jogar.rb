require './app/lib/CampoMinado/CampoMinado'
require './app/lib/PrettyPrinter'

class Jogar

	def input(label)
		return [(print label+': '), gets.rstrip][1]
	end

	def input_number(label, message_invalid, default=nil)
		label+= default != nil ? " [padrão: #{default}]" : ''
		while true
			value = input label

			if value != '' && value.to_i >= 0
				break
			elsif value == ''
				value = default
				break
			else
				puts message_invalid
			end
		end

		return value.to_i
	end

	def get_linhas 
		return input_number "Qtd. linhas", "Qtd. de linhas inválida", 10
	end

	def get_colunas
		return input_number "Qtd. colunas", "Qtd. de colunas inválida", 20
	end

	def get_qtd_bombas
		return input_number "Qtd. de bombas", "Qtd. de bombas inválida", 50
	end

	def jogada
		puts "Informe a posição ou 0 para marcar uma bandeira (flag)"

		x = input_number "Posição(x)", "Número inválido"

		if x == 0
			marcar_bandeira
		else
			y = input_number "Posição(y)", "Número inválido"

			posicaoX = x-1
			posicaoY = y-1

			if !@jogo.jogar(posicaoX, posicaoY)
				puts "Jogada inválida"
			elsif !@jogo.perdeu?
				PrettyPrinter.new.print @jogo.estado_atual
			end
		end
	end

	def marcar_bandeira
		puts "Informe a posição da bandeira (Flag) ou 0 para fazer uma jogada"

		x = input_number "Posição(x)", "Número inválido"

		if x == 0
			jogada
		else
			y = input_number "Posição(y", "Número inválido"

			posicaoX = x-1
			posicaoY = y-1

			if !@jogo.marcar_bandeira(posicaoX, posicaoY)
				puts "Marcação de bandeira (Flag) inválida"
			else
				PrettyPrinter.new.print @jogo.estado_atual
			end
		end
	end

	private :input, :input_number, :get_linhas, :get_colunas, :get_qtd_bombas, :jogada, :marcar_bandeira

	def main 
		@linhas, @colunas, @qtd_bombas = get_linhas, get_colunas, get_qtd_bombas
		@jogo = CampoMinado.new(@linhas, @colunas, @qtd_bombas)

		PrettyPrinter.new.print @jogo.estado_atual

		while @jogo.jogando?
			jogada
		end

		if @jogo.ganhou?
			puts "**** Você ganhou! :D ****"
		else
			puts "Você perdeu! :("
			PrettyPrinter.new.print @jogo.estado_atual(xray: true)
			puts "Fim do jogo."
		end
	end
end

Jogar.new.main