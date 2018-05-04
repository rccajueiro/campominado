require './app/lib/CampoMinado'

largura, altura, qtd_bombas = 40, 80, 640

jogo = CampoMinado.new(largura, altura, qtd_bombas)

while jogo.ainda_jogando?
	bandeira_valida = jogo.marcar_bandeira(rand(largura), rand(altura))
	jogada_valida = jogo.jogar(rand(largura), rand(altura))

	if jogada_valida or bandeira_valida
		print jogo.estado_atual()
	end
end

puts "Fim do jogo!"

if jogo.ganhou?
 	puts "Você venceu!"
else
	puts "Você perdeu! As minas eram:"
	print jogo.estado_atual(xray: true)
end