require_relative './../config/constants'

class PrettyPrinter
	def print(matriz)
		ret = String.new

		# ret << "#{matriz.size} x #{matriz[0].size}".center(((matriz.size*4) + 1), '_')
		ret << "[#{matriz.size} x #{matriz[0].size}]"
		ret << "\n"

		for x in 0..matriz.size-1
			for y in 0..matriz[x].size-1
				if y == 0
					ret << '|'
				end

				if matriz[x][y] == $_CELULA_VAZIA
					ret << $_CELULA_VAZIA_PRINTER
				else
					ret << matriz[x][y].to_s
				end

				ret << '|'
			end

			ret << "\n"
		end

		# ret << '_' * ((matriz.size*4) + 1)
		ret << '='

		# ret << "\n"

		puts ret
	end
end