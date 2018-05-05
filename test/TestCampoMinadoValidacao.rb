require 'test/unit'
require_relative './../app/lib/CampoMinado/CampoMinadoValidacao'

class TestCampoMinadoValidacao < Test::Unit::TestCase
	def testJogadaValida
		game = CampoMinadoValidacao.new(10, 20, 50)
		assert_equal(true, game.jogada_valida?(0, 0))
	end

	def testJogadaInvalida
		game = CampoMinadoValidacao.new(10, 20, 50)
		assert_equal(false, game.jogada_valida?(-1, -1))
	end

	def testQtdBombaEmVolta
		# 3x5 / 3 bombas
		# _____
		# #21..
		# 3#2..
		# 2#2..
		# _____

		bombas_pre_definidas = [
			[0,0],
			[1,1],
			[2,1]
		]

		game = CampoMinadoValidacao.new(3, 5, 3, bombas_pre_definidas)

		assert_equal(2, game.tem_bombas_em_volta?(0,1))
		assert_equal(1, game.tem_bombas_em_volta?(0,2))
		assert_equal(3, game.tem_bombas_em_volta?(1,0))
		assert_equal(2, game.tem_bombas_em_volta?(1,2))
		assert_equal(2, game.tem_bombas_em_volta?(2,0))
		assert_equal(2, game.tem_bombas_em_volta?(2,2))
	end

	def testNaoTemBombaEmVolta
		# 3x5 / 3 bombas
		# _____
		# #21..
		# 3#2..
		# 2#2..
		# _____

		bombas_pre_definidas = [
			[0,0],
			[1,1],
			[2,1]
		]

		game = CampoMinadoValidacao.new(3, 5, 3, bombas_pre_definidas)

		assert_equal(false, game.tem_bombas_em_volta?(0, 3))
		assert_equal(false, game.tem_bombas_em_volta?(0, 4))
		assert_equal(false, game.tem_bombas_em_volta?(1, 3))
		assert_equal(false, game.tem_bombas_em_volta?(1, 4))
		assert_equal(false, game.tem_bombas_em_volta?(2, 3))
		assert_equal(false, game.tem_bombas_em_volta?(2, 4))
	end

	def testPosicaoInvalidaEmTemBombaEmVolta
		# 3x5 / 3 bombas
		# _____
		# #21..
		# 3#2..
		# 2#2..
		# _____

		bombas_pre_definidas = [
			[0,0],
			[1,1],
			[2,1]
		]

		game = CampoMinadoValidacao.new(3, 5, 3, bombas_pre_definidas)

		assert_equal(false, game.tem_bombas_em_volta?(-1, 4))
	end
end
