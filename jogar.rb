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
			end
		end
	end

	def cabecalho
		system "cls"
		system "clear"

		puts "....::::: CAMPO MINADO :::::...."
		puts "CTRL+C para SAIR"
	end

	def tela
		cabecalho

		puts "Linhas: #{@linhas} / Colunas: #{@colunas} / Qtd.bombas: #{@qtd_bombas}"
		
		if @jogo.jogando?
			PrettyPrinter.new.print @jogo.estado_atual
		elsif @jogo.ganhou?
			PrettyPrinter.new.print @jogo.estado_atual
			puts "Você ganhou! :D"
		else
			PrettyPrinter.new.print @jogo.estado_atual(xray: true)
			puts "Você perdeu! :("
		end
	end

	private :input, :input_number, :get_linhas, :get_colunas, :get_qtd_bombas, :jogada, :marcar_bandeira, :cabecalho, :tela

	def main
		begin
			cabecalho

			@linhas, @colunas, @qtd_bombas = get_linhas, get_colunas, get_qtd_bombas
			@jogo = CampoMinado.new(@linhas, @colunas, @qtd_bombas)

			while @jogo.jogando?
				tela
				jogada
			end

			tela
		rescue Exception => e
			if e.message != ''
				puts "\nErro: " + e.message
			else
				puts "\nJogo fechado!"
			end
		end
	end
end

Jogar.new.main