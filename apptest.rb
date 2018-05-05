require './app/lib/CampoMinado/CampoMinado'
require './app/lib/SimpleJSON'
require './app/lib/SimplePrinter'
require './app/lib/PrettyPrinter'

class AppTest
	def main
		@largura, @altura, @qtd_bombas = 10, 20, 50

		@jogo = CampoMinado.new(@largura, @altura, @qtd_bombas)

		while @jogo.jogando?
			jogada_valida = @jogo.jogar(rand(@largura-1), rand(@altura-1))
			bandeira_valida = @jogo.marcar_bandeira(rand(@largura-1), rand(@altura-1))

			if jogada_valida or bandeira_valida
				
				printer = rand > 0.5 ? SimplePrinter.new : PrettyPrinter.new 

				printer.print(@jogo.estado_atual)
			end
		end

		puts "Fim do jogo!"
		if @jogo.ganhou?
		 	puts "Você venceu!"
		else
			puts "Você perdeu! As minas eram:"
			PrettyPrinter.new.print(@jogo.estado_atual(xray: true))
		end

		puts SimpleJSON.new.stringfy matriz: @jogo.estado_atual(xray: true)
	end
end

AppTest.new.main