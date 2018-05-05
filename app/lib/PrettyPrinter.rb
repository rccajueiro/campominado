require_relative './../config/constants'

class PrettyPrinter
	def print(matriz)
		ret = String.new

		ret << " "*(matriz.size.to_s.size+1)
		ret << "[#{matriz.size} x #{matriz[0].size}]".center(((matriz[0].size.to_s.size+1)*matriz[0].size)-1, '_')
		ret << "\n"

		ret << ' '*matriz.size.to_s.size + '|'

		for y in 1..matriz[0].size
			ret << y.to_s.rjust(matriz[0].size.to_s.size, ' ') + '|'
		end

		ret << "\n"

		for x in 0..matriz.size-1

			posicaoX = (x+1).to_s.rjust(matriz.size.to_s.size, ' ')

			ret << posicaoX

			for y in 0..matriz[x].size-1
				if y == 0
					ret << '|'
				end

				if matriz[x][y] == $_CELULA_VAZIA
					ret << $_CELULA_VAZIA_PRINTER.rjust(matriz[0].size.to_s.size, ' ')
				else
					ret << matriz[x][y].to_s.rjust(matriz[0].size.to_s.size, ' ')
				end

				ret << '|'
			end

			ret << "\n"
		end

		ret << " "*(matriz.size.to_s.size+1)
		ret << '=' * (((matriz[0].size.to_s.size+1)*matriz[0].size)-1)

		ret << "\n"

		puts ret
	end
end