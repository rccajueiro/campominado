require_relative './../../config/constants'

class CampoMinadoIniciacao
	# método initialize
	# método construtor da classe
	# recebe as informações de número de linhas, número de colunas e quantidad e de bombas
	# recebe, mas não é obrigatório, uma matriz com posicionamento de bombas
	# esse último para fins de teste unitário
	def initialize(linhas, colunas, qtd_bombas, bombas_pre_definidas=nil)
		# valida quantidade de linhas
		if linhas < 1
			raise $ERRO_LINHAS_INVALIDA
		end

		# valida quantidade de colunas
		if colunas < 1
			raise $ERRO_COLUNAS_INVALIDA
		end

		# valida quantidade de bombas
		if qtd_bombas < 1 || qtd_bombas > linhas * colunas
			raise $ERRO_QTD_BOMBAS_INVALIDA
		end

		# valida quantidade de bombas pre definidas, para fins de testes
		if bombas_pre_definidas != nil && bombas_pre_definidas.size != qtd_bombas
			raise $ERRP_QTD_BOMBAS_PRE_DEFINIDAS
		elsif bombas_pre_definidas != nil && bombas_pre_definidas.size > 0
			bombas_pre_definidas.each do |bomba|
				if(bomba[0]>linhas-1 || bomba[1]>colunas-1)
					raise $ERRO_BOMBA_PREDEFINIDA_FORA_MATRIZ
				end
			end
		end

		@linhas, @colunas, @qtd_bombas = linhas, colunas, qtd_bombas

		@flag_perdeu = false
		@flag_ganhou = false

		# quantidade de celulas validas (não bombas)
		@qtd_valida = (linhas * colunas) - qtd_bombas
		@qtd_descoberto = 0

		gera_matriz
		insere_bombas(bombas_pre_definidas)
	end

	private 
		# método gera_matriz
		# responsável em montar celulas fechada da matriz principal
		def gera_matriz
			@matriz = []
			for x in 0..@linhas-1
				@matriz[x] = []
				for y in 0..@colunas-1
					@matriz[x][y] = $_CELULA_FECHADA
				end
			end
		end

		# método insere_bombas
		# cria uma matriz com posicao das bombas aleatoriamente, caso o parâmetro bombas_pre_definidas venha nulo (nil)
		def insere_bombas(bombas_pre_definidas)
			if bombas_pre_definidas == nil
				contador = 0
				@bombas = []
				while contador < @qtd_bombas do
					x = rand(@linhas-1);
					y = rand(@colunas-1);

					if !@bombas.include?([x, y])
						@bombas << [x, y]
						contador+= 1
					end
				end
			else
				@bombas = bombas_pre_definidas
			end
		end
end