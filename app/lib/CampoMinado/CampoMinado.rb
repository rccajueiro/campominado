require_relative './../../config/constants'
require_relative './CampoMinadoValidacao'

class CampoMinado < CampoMinadoValidacao
	
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

	def marcar_bandeira(x, y)
		if jogada_valida?(x, y) && (@matriz[x][y] == $_CELULA_FLAG || @matriz[x][y] == $_CELULA_FECHADA)
			if @matriz[x][y] == $_CELULA_FECHADA
				@matriz[x][y] = $_CELULA_FLAG
				
				# quando coloca uma flag em cima de uma bomba, ela se torna uma celula valida
				if tem_bombas_em_volta?(x, y) != false
					@qtd_valida+= 1
				end
			else
				@matriz[x][y] = $_CELULA_FECHADA
				
				# e quando remove a flag e tem bomba, ela volta a ser uma celula invalida (com bomba)
				if tem_bombas_em_volta?(x, y) != false
					@qtd_valida-= 1
				end
			end

			return true
		end

		return false
	end

	def get_qtd_descoberto
		return @qtd_descoberto
	end

	def jogando?
		return !@flag_perdeu && !@flag_ganhou
	end

	def ganhou?
		return @flag_ganhou
	end

	def perdeu?
		return @flag_perdeu
	end

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
		def add_qtd_descoberto
			@qtd_descoberto+= 1
		end
		
		# metodo para percorrer as celulas em volta das celulas vazias
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