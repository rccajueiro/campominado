require_relative './../config/constants'

class CampoMinado
	def initialize(linhas, colunas, qtd_bombas)
		if linhas < 1
			raise $ERRO_LINHAS_INVALIDA
		end

		if colunas < 1
			raise $ERRO_COLUNAS_INVALIDA
		end

		if qtd_bombas < 1 || qtd_bombas > linhas * colunas
			raise $ERRO_QTD_BOMBAS_INVALIDA
		end

		@flag_perdeu = false
		@flag_ganhou = false

		# quantidade de celulas validas (não bombas)
		@qtd_valida = (linhas * colunas) - qtd_bombas
		@qtd_descoberto = 0

		# monta celulas fechada
		@matriz = []
		for x in 0..linhas-1
			@matriz[x] = []
			for y in 0..colunas-1
				@matriz[x][y] = $_CELULA_FECHADA
			end
		end

		# posicao das bombas aleatoriamente
		contador = 0
		@bombas = []
		while contador < qtd_bombas do
			x = rand(linhas);
			y = rand(colunas);

			if !@bombas.include?([x, y])
				@bombas << [x, y]
				contador+= 1
			end
		end
	end


	def jogada_valida?(x, y)
		return x>=0 && x<=@matriz.size && y>=0 && y<=@matriz[0].size
	end	

	# retorna o total de bombas em volta da celula ou falso se não existe
	def tem_bombas_em_volta?(x, y)
		total_bombas_em_volta = 0

		for item in [[-1,-1], [-1,0], [-1,+1], [0,+1], [+1,+1], [+1,0], [+1,-1], [0,-1]]
			xx = x+item[0]
			if xx<0 || xx>@matriz.size-1 
				next
			end

			yy = y+item[1]
			if yy<0 || yy>@matriz[0].size-1
				next
			end

			if @bombas.include?([xx, yy])
				total_bombas_em_volta = total_bombas_em_volta + 1
			end
		end

		return total_bombas_em_volta > 0 ? total_bombas_em_volta : false
	end

	# metodo para percorrer as celulas em volta das celulas vazias
	def outras_vazia(posX, posY)
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
						@qtd_descoberto+= 1

						outras_vazia(x, y)
					end
				end
			end
		end while continuar
	end

	private :jogada_valida?, :tem_bombas_em_volta?, :outras_vazia

	def jogar(x, y)
		if jogada_valida?(x, y) && @matriz[x][y] == $_CELULA_FECHADA
			if @bombas.include?([x, y])
				@matriz[x][y] = $_CELULA_BOMBA
				@flag_perdeu = true
			else
				total_bombas_em_volta = tem_bombas_em_volta?(x, y)

				@matriz[x][y] = !total_bombas_em_volta ? $_CELULA_VAZIA : total_bombas_em_volta
				@qtd_descoberto+= 1

				if(!total_bombas_em_volta)
					outras_vazia(x, y)
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

	def ainda_jogando?
		# se a quantidade de celulas descobertas for igual a quantidade de celulas validas, o jogo ta ganho
		if(@qtd_descoberto == @qtd_valida)
			@flag_ganhou = true
		end

		if @flag_perdeu || @flag_ganhou
			return false
		end

		return true
	end

	def ganhou?
		return @flag_ganhou
	end

	def estado_atual(options = nil)

		if(options!=nil)
			formato = options[:formato]==nil ? "default" : options[:formato]
			xray = options[:xray]==nil ? false : options[:xray]
		else
			formato = "default"
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

		case formato
		when "json"
			require 'json'
			return retorno.to_json

		when "object"
			return retorno
		else
			s = String.new('')

			for x in 0..retorno.size-1
				for y in 0..retorno[x].size-1
					s << (retorno[x][y]==$_CELULA_VAZIA ? ' ' : retorno[x][y].to_s)
				end
				s << "\n"
			end
			s << '_' * retorno[0].size
			s << "\n"

			return s
		end
	end
end