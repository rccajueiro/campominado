require 'test/unit'
require_relative './../app/lib/CampoMinado/CampoMinado'
require_relative './../app/lib/PrettyPrinter'

class TestCampoMinado < Test::Unit::TestCase
	# teste de uma jogada válida
	def testJogadaValida
		game = CampoMinado.new(10, 20, 50)
		assert_equal(true, game.jogar(0, 0))
	end

	# teste de uma jogada inválida
	def testJogadaInvalida
		game = CampoMinado.new(10, 20, 50)
		assert_equal(false, game.jogar(-1, -1))
	end

	# teste para inserir uma marcação de bandeira (flag) válida
	def testInsereMarcacaoBandeiraValida
		game = CampoMinado.new(10, 20, 50)
		assert_equal(true, game.marcar_bandeira(5, 10))
	end

	# teste para inserir uma marcação de bandeira (flag) inválida
	def testInsereMarcacaoBandeiraInvalida
		game = CampoMinado.new(10, 20, 50)
		assert_equal(false, game.marcar_bandeira(20, 10))
	end

	# teste para inserir e remover uma marcação de bandeira válida
	def testInsereERemoveMarcacaoBandeira
		game = CampoMinado.new(10, 20, 50)
		assert_equal(true, game.marcar_bandeira(0, 0))
		assert_equal(true, game.marcar_bandeira(0, 0))
	end

	# teste de vitória
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
			assert_equal(true, game.jogando?)
			assert_equal(true, game.jogar(jogada[0], jogada[1]))
		end

		assert_equal(false, game.jogando?)
		assert_equal(true, game.ganhou?)
	end

	# teste de derrota
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
		assert_equal(true, game.jogando?)
		assert_equal(true, game.jogar(0, 0))

		assert_equal(false, game.jogando?)
		assert_equal(true, !game.jogando? && game.perdeu?)
	end

	# teste em abrir células vazias
	def testAbrirVazios
		# 5x8 / 4 bombas
		# ________
		# #21.....
		# 3#2.....
		# 2#2.....
		# ......11
		# ......1#
		# ========

		# BOMBAS
		bombas_pre_definidas = [
			[0,0],
			[1,1],
			[2,1],
			[4,7]
		]

		game = CampoMinado.new(5, 8, 4, bombas_pre_definidas)

		assert_equal(true, game.jogando?)
		assert_equal(true, game.jogar(2, 4))
		
		assert_equal(true, game.jogando?)
		assert_equal(24, game.get_qtd_descoberto)
	end
end