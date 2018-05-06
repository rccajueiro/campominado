require_relative './../../config/constants'
require_relative './CampoMinadoValidacao'

class CampoMinado < CampoMinadoValidacao
	# método jogar
	# responsavel pelas jogadas
	# irá validar e executar a respectiva jogada
	# caso pegue uma célula com bomba, seta a flag_perdeu para true
	def jogar(x, y)
		if jogada_valida?(x, y) && @matriz[x][y] == $_CELULA_FECHADA
			if @bombas.include?([x, y])
				@matriz[x][y] = $_CELULA_BOMBA
				@flag_perdeu = true
			else
				total_bombas_em_volta = tem_bombas_em_volta?(x, y)

				@matriz[x][y] = !total_bombas_em_volta ? $_CELULA_VAZIA : total_bombas_em_volta
				add_qtd_descoberto

				if(!total_bombas_em_volta)
					outras_vazia?(x, y)
				end

				if(get_qtd_descoberto == get_qtd_valida)
					@flag_ganhou = true
				end
			end

			return true
		end

		return false
	end

	# método marcar_badeira
	# responsável para marcar e desmarcar uma badeira
	# se a célula não foi aberta e não possui bandeira, vai marcar uma bandeira (F)
	# se a célular já possui uma bandeira, irá remover a bandeira
	def marcar_bandeira(x, y)
		if jogada_valida?(x, y)
			@matriz[x][y] = @matriz[x][y] == $_CELULA_FLAG ? $_CELULA_FECHADA : $_CELULA_FLAG
			return true
		end

		return false
	end

	# método get_qtd_descoberto
	# retorna a quantidade de células que já foram abertas e não possuiam bomba
	def get_qtd_descoberto
		return @qtd_descoberto
	end

	# método jogando?
	# se não perdeu e não ganhou, continua jogando
	def jogando?
		return !perdeu? && !ganhou?
	end
	
	# método ganhou?
	# retorna a flag ganhou (true ou false)
	def ganhou?
		return @flag_ganhou
	end

	# método perdeu?
	# retorna a flag perdeu (true ou false)
	def perdeu?
		return @flag_perdeu
	end

	# método estado_atual
	# retorna a matriz do estado atual do jogo
	# caso passe a opção :xray: true e o jogo esta perdido, retorna a posição das bombas
	def estado_atual(options = nil)

		if(options!=nil)
			xray = options[:xray]!=nil ? options[:xray] : false
		else
			xray = false
		end

		retorno = @matriz

		if xray 
			for x in 0..retorno.size-1
				for y in 0..retorno[x].size-1
					if @bombas.include?([x, y]) && @flag_perdeu
						retorno[x][y] = $_CELULA_BOMBA
					end
				end
			end	
		end

		return retorno
	end

	private
		# método add_qtd_descoberto
		# responsável por incrementar o atributo @qtd_descoberto, 
		# quando clica em uma célula vazia ou com bomba em volta
		def add_qtd_descoberto
			@qtd_descoberto+= 1
		end
		
		# método outras_vazia?
		# Responsável por percorrer as células em volta da célula vazia clicada.
		# Se a célula em volta for uma célula válida, fechada e não possui bomba bomba em volta, é uma célula vazia.
		# Ela abre e continua percorrendo (recursivamente) as células em volta da mesma até encontrar uma célula
		# aberta (vazia ou com número de bomba em volta) ou fechada com bomba em volta.
		def outras_vazia?(posX, posY)
			begin 
				for x in posX-1..posX+1
					if x<0 || x>@matriz.size-1
						next
					end
					for y in posY-1..posY+1
						if y<0 || y>@matriz[0].size-1
							next
						end
						continuar = false
						if jogada_valida?(x, y) && @matriz[x][y] == $_CELULA_FECHADA && !tem_bombas_em_volta?(x, y)
							continuar = true
							@matriz[x][y] = $_CELULA_VAZIA
							add_qtd_descoberto
							outras_vazia?(x, y)
						end
					end
				end
			end while continuar
		end
end