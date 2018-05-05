require_relative './../../config/constants'
require_relative './CampoMinadoIniciacao'

class CampoMinadoValidacao < CampoMinadoIniciacao
	# método get_qtd_valida
	# retorna a quantidad e células válidas (não pussuem bomba)
	def get_qtd_valida
		return @qtd_valida
	end

	# método jogada_valida?
	# verifica se as coordenadas passadas são válidas
	def jogada_valida?(x, y)
		return x>=0 && x<=@matriz.size-1 && y>=0 && y<=@matriz[0].size-1
	end	

	# método tem_bombas_em_volta?
	# retorna o total de bombas em volta da célula ou falso se não existe
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
				total_bombas_em_volta+= 1
			end
		end

		return total_bombas_em_volta > 0 ? total_bombas_em_volta : false
	end
end