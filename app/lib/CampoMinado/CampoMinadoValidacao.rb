require_relative './../../config/constants'
require_relative './CampoMinadoIniciacao'

class CampoMinadoValidacao < CampoMinadoIniciacao
	def get_qtd_valida
		return @qtd_valida
	end

	def jogada_valida?(x, y)
		return x>=0 && x<=@matriz.size-1 && y>=0 && y<=@matriz[0].size-1
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
				total_bombas_em_volta+= 1
			end
		end

		return total_bombas_em_volta > 0 ? total_bombas_em_volta : false
	end
end