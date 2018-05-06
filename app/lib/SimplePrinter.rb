require_relative './../config/constants'

class SimplePrinter
	def print(matriz)
		ret = String.new
		ret << '_' * matriz[0].size
		ret << "\n"
		for x in 0..matriz.size-1
			for y in 0..matriz[x].size-1
				if matriz[x][y] == $_CELULA_VAZIA
					ret <<  $_CELULA_VAZIA_PRINTER
				else
					ret << matriz[x][y].to_s
				end
			end
			ret << "\n"
		end
		ret << '=' * matriz[0].size
		ret << "\n"

		puts ret
	end
end