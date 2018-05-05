require 'test/unit'
require_relative './../app/lib/CampoMinado/CampoMinadoIniciacao'

class TestCampoMinadoIniciacao < Test::Unit::TestCase
	# testa a inicilização da classe
	def testIniciacao
		CampoMinadoIniciacao.new(10, 20, 50)
		assert(true)
	end

	# testa quando enviado uma quantidade de linhas inválida
	def testQtdLinhasInvalido
		begin
			CampoMinadoIniciacao.new(-1, 20, 50)
		rescue => e
			assert(e.message, $ERRO_LINHAS_INVALIDA)
		end
	end

	# testa quando enviado uma quantidade de colunas inválida
	def testQtdColunasInvalido
		begin
			CampoMinadoIniciacao.new(10, -1, 50)
		rescue => e
			assert(e.message, $ERRO_COLUNAS_INVALIDA)
		end
	end

	# testa quando enviado uma quantidade de bombas inválida
	def testQtdBombasInvalido
		begin
			CampoMinadoIniciacao.new(10, 20, 300)
		rescue => e
			assert(e.message, $ERRO_QTD_BOMBAS_INVALIDA)
		end
	end
end