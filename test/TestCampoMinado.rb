require 'test/unit'
require_relative './../app/lib/CampoMinado'

class TestCampoMinado < Test::Unit::TestCase
	def testIniciar
		CampoMinado.new(10, 20, 50)
		assert(true)
	end

	def testQtdLinhasInvalido
		begin
			CampoMinado.new(-1, 20, 50)
		rescue => e
			assert(e.message, $ERRO_LINHAS_INVALIDA)
		end
	end

	def testQtdColunasInvalido
		begin
			CampoMinado.new(10, -1, 50)

		rescue => e
			assert(e.message, $ERRO_COLUNAS_INVALIDA)
		end
	end

	def testQtdBombasInvalido
		begin
			CampoMinado.new(10, 20, 300)
		rescue => e
			assert(e.message, $ERRO_QTD_BOMBAS_INVALIDA)
		end
	end

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
end