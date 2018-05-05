require 'test/unit'
require_relative './../app/lib/CampoMinado/CampoMinado'
require_relative './../app/lib/PrettyPrinter'

class TestCampoMinado < Test::Unit::TestCase
	def testJogadaValida
		game = CampoMinado.new(10, 20, 50)
		assert_equal(true, game.jogar(0, 0))
	end

	def testJogadaInvalida
		game = CampoMinado.new(10, 20, 50)
		assert_equal(false, game.jogar(-1, -1))
	end

	def testInsereFlagValida
		game = CampoMinado.new(10, 20, 50)
		assert_equal(true, game.marcar_bandeira(5, 10))
	end

	def testInsereFlagInvalida
		game = CampoMinado.new(10, 20, 50)
		assert_equal(false, game.marcar_bandeira(20, 10))
	end

	def testInsereERemoveFlag
		game = CampoMinado.new(10, 20, 50)
		assert_equal(true, game.marcar_bandeira(0, 0) && game.marcar_bandeira(0, 0))
	end

	def testGanhou
		# 3x5 / 3 bombas
		# _____
		# #21..
		# 3#2..
		# 2#2..
		# _____

		# BOMBAS
		bombas_pre_definidas = [
			[0,0],
			[1,1],
			[2,1]
		]

		# JOGADAS
		jogadas = [
			[0,3],
			[0,1],
			[0,2],
			[1,0],
			[1,2],
			[2,0],
			[2,2]				
		]
		game = CampoMinado.new(3, 5, 3, bombas_pre_definidas)

		jogadas.each do |jogada|
			# PrettyPrinter.new.print game.estado_atual
			assert_equal(true, game.jogar(jogada[0], jogada[1]))
		end

		# PrettyPrinter.new.print game.estado_atual
		
		assert_equal(true, !game.jogando? && game.ganhou?)
	end

	def testPerdeu
		# 3x5 / 3 bombas
		# _____
		# #21..
		# 3#2..
		# 2#2..
		# _____

		# BOMBAS
		bombas_pre_definidas = [
			[0,0],
			[1,1],
			[2,1]
		]

		game = CampoMinado.new(3, 5, 3, bombas_pre_definidas)
		assert_equal(true, game.jogar(0, 0))

		# PrettyPrinter.new.print game.estado_atual(xray: true)
		assert_equal(true, !game.jogando? && game.perdeu?)
	end

	def testAbrirVazios
		# 3x5 / 3 bombas
		# _____
		# #21..
		# 3#2..
		# 2#2..
		# _____

		# BOMBAS
		bombas_pre_definidas = [
			[0,0],
			[1,1],
			[2,1]
		]

		game = CampoMinado.new(3, 5, 3, bombas_pre_definidas)
		# PrettyPrinter.new.print game.estado_atual

		assert_equal(true, game.jogar(2, 4))

		# PrettyPrinter.new.print game.estado_atual
		assert_equal(true, game.jogando?)
		assert_equal(6, game.get_qtd_descoberto)
	end
end