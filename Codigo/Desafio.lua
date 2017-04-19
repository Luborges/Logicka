-- Desafio

require ("CriarBloco")
require ("sqlite3")
require ("TelaDeDialogo")
require ("VerificarDesafio")
local Sons = require("Sons")
local sound = Sons:new{1,2,3}

local storyboard = require ("storyboard")

Scene = storyboard.newScene()

Scene:addEventListener("createScene", Scene)
Scene:addEventListener("enterScene", Scene)
Scene:addEventListener("exitScene", Scene)

--Variaveis referentes ao banco
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path) 

local numeroDesafio
local blocosMovidos = {}
local blocosPosicionamento = {}
local blocoDeOperacao = {}
local blocoDeDecisao = {}
local blocoDeIteracao = {}
local blocoDeExibicao = {}
local blocoDeEntrada = {}
local pontoDeSequencia = {}

-- Calcula largura e altura da tela
local largura = display.contentWidth
local altura = display.contentHeight

local cb = CriarBloco:new()
local vf = VerificarDesafio:new()

-- Laço que irá rodar enquanto houverem linhas na tabela
for row in db:nrows("SELECT id_fase FROM t_Jogador WHERE id_jogador=1") do
	fase = row.id_fase
end

for row in db:nrows("SELECT ds_idioma FROM t_Jogador") do
    ds_idioma = row.ds_idioma
end

function Scene:exitScene(event)

--Remove evento que foi iniciado na função enterScene

	j=1

	for j=1,quantidadeDeBlocosOperacao,1 do

		blocoDeOperacao[j]:removeEventListener("touch", blocoDeOperacao[j])
		blocoDeOperacao[j]:removeSelf()
		blocoDeOperacao[j]=nil

	end

	for j=1,quantidadeDeBlocosDecisao,1 do

		blocoDeDecisao[j]:removeEventListener("touch", blocoDeDecisao[j])
		blocoDeDecisao[j]:removeSelf()
		blocoDeDecisao[j]=nil

	end

	for j=1,quantidadeDeBlocosIteracao,1 do

		blocoDeIteracao[j]:removeEventListener("touch", blocoDeIteracao[j])
		blocoDeIteracao[j]:removeSelf()
		blocoDeIteracao[j]=nil

	end

	for j=1,quantidadeDeBlocosExibicao,1 do

		blocoDeExibicao[j]:removeEventListener("touch", blocoDeExibicao[j])
		blocoDeExibicao[j]:removeSelf()
		blocoDeExibicao[j]=nil

	end

	for j=1,quantidadeDeBlocosEntrada,1 do

		blocoDeEntrada[j]:removeEventListener("touch", blocoDeEntrada[j])
		blocoDeEntrada[j]:removeSelf()
		blocoDeEntrada[j]=nil

	end

	botaoTeste:removeEventListener("touch", botaoTeste)

	blocoDeTeste:removeSelf()
	background:removeSelf()
	blocoInicio:removeSelf()
	blocoFim:removeSelf()

	quantidadeDeBlocos=nil
	quantidadeDeBlocosOperacao=nil
	quantidadeDeBlocosDecisao=nil
	quantidadeDeBlocosIteracao=nil 
	quantidadeDeBlocosExibicao=nil 
	quantidadeDeBlocosEntrada=nil
	blocoDeOperacao = nil
	blocoDeDecisao = nil
	blocoDeIteracao = nil
	blocoDeExibicao = nil
	blocoDeEntrada = nil
	quantidadeDeBlocos=nil
	blocosMovidos=nil

	Runtime:removeEventListener("touch", botaoTeste)
	botaoTeste:removeSelf()
	botaoTeste=nil

	storyboard.removeScene("Desafio")
	storyboard.removeAll()

end

--Cria cena
function Scene:createScene(event)
sound:stopAll(sound)

	for row in db:nrows("SELECT id_puzzle FROM t_Jogador") do

		numeroDesafio=row.id_puzzle

	end

	-- Laço que irá rodar enquanto houverem linhas na tabela
	for row in db:nrows("SELECT ds_puzzle FROM t_Puzzle WHERE id_puzzle ="..numeroDesafio) do

		dialogoAtual = row.ds_puzzle

	end

	td = TelaDeDialogo:new()
	td:desafios()

	local screenGroup = self.view

	-- Verificar quantidade de blocos do tipo Operacao neste puzzle
	for row in db:nrows("SELECT COUNT(id_puzzle) AS count FROM t_Operacao WHERE id_puzzle="..numeroDesafio) do

		quantidadeDeBlocosOperacao=row.count

	end

	-- Verificar quantidade de blocos do tipo Decisao neste puzzle
	for row in db:nrows("SELECT COUNT(id_puzzle) AS count FROM t_Decisao WHERE id_puzzle="..numeroDesafio) do

		quantidadeDeBlocosDecisao=row.count

	end

	-- Verificar quantidade de blocos do tipo Decisao neste puzzle
	for row in db:nrows("SELECT COUNT(id_puzzle) AS count FROM t_Looping WHERE id_puzzle="..numeroDesafio) do

		quantidadeDeBlocosIteracao=row.count

	end

	-- Verificar quantidade de blocos do tipo Decisao neste puzzle
	for row in db:nrows("SELECT COUNT(id_puzzle) AS count FROM t_Exibicao WHERE id_puzzle="..numeroDesafio) do

		quantidadeDeBlocosExibicao=row.count

	end

	-- Verificar quantidade de blocos do tipo Decisao neste puzzle
	for row in db:nrows("SELECT COUNT(id_puzzle) AS count FROM t_Entrada_Dados WHERE id_puzzle="..numeroDesafio) do

		quantidadeDeBlocosEntrada=row.count


	end

	quantidadeDeBlocos = quantidadeDeBlocosOperacao + quantidadeDeBlocosDecisao + quantidadeDeBlocosIteracao + quantidadeDeBlocosExibicao + quantidadeDeBlocosEntrada
    
	background = display.newImage("GameDesign/DesignGrafico/Fases/TelaDialogo"..fase.."/fundoTelaDialogo"..fase..".jpg")
	screenGroup:insert(background)
	blocoEixoY=altura*.1
	blocoEixoX=largura*.55
	background.height=altura
	background.width=largura
	background.x=largura*.5
	background.y=altura*.5

	botaoTeste = display.newImage("GameDesign/DesignGrafico/Desafio/testarBlocos.jpg")
	botaoTeste.x=largura*.88
	botaoTeste.y=altura*.89
	botaoTeste.width=largura*.3
	botaoTeste.height=altura*.3
	screenGroup:insert(botaoTeste)

	pontoEixoX=largura*.14
	pontoEixoY=altura*.072
	pontoEixoXInicial=pontoEixoX
	pontoEixoYInicial=pontoEixoY
	
	for cont=0,7,1 do

		local circulo = display.newCircle( 0, 0, 15)
		circulo:setFillColor( 0,0,0 )

		local texto = display.newText( cont, 2, 0, native.systemFont, 16 )
		texto:setFillColor( 1, 1, 1 )

		local ponto = display.newGroup()
		ponto:insert(circulo)
		ponto:insert(texto)

		if cont%2==0  then

			ponto.x=pontoEixoX
			ponto.y=pontoEixoY
			pontoEixoX=pontoEixoX+pontoEixoXInicial*1.5
			pontoEixoY = pontoEixoY
			novapontoEixoY=pontoEixoY
		
		else 

			ponto.x=pontoEixoX
			ponto.y=pontoEixoY+30

			pontoEixoX=pontoEixoXInicial
			pontoEixoY=pontoEixoY+altura/3.8
			novapontoEixoY=pontoEixoY

		end
			
		screenGroup:insert(ponto)
		pontoEixoY = novapontoEixoY
		pontoDeSequencia[cont] = ponto

	end

	blocoDeTeste = display.newRect(0,0,largura/2.4,altura/1.03)

	blocoDeTeste.x=largura*.25
	blocoDeTeste.y=altura*.50
	blocoDeTeste.strokeWidth = 5
	blocoDeTeste:setStrokeColor(0,0,0)

	screenGroup:insert(blocoDeTeste)
	blocoDeTeste:toBack()
	background:toBack()

	quantidadeDeBlocos=4

	blocoEixoXInicial=blocoEixoX
	blocoEixoYInicial=blocoEixoY
	contadorGeral=1
	novaAltura=altura*.1

	for cont=1,quantidadeDeBlocosOperacao,1 do

		blocoDeOperacao[cont] = cb:blocoOperacao(0, 0, cont,numeroDesafio)
		screenGroup:insert(blocoDeOperacao[cont])

		if contadorGeral%3~=0 then

			blocoDeOperacao[cont].x=blocoEixoX
			blocoDeOperacao[cont].y=blocoEixoY
			blocoEixoX=blocoEixoX+blocoEixoXInicial/3

			blocoEixoY = novaAltura

			novaAltura=blocoEixoY

		elseif contadorGeral%3==0 then

			blocoDeOperacao[cont].x=blocoEixoX
			blocoDeOperacao[cont].y=blocoEixoY

			blocoEixoX=largura*.55

			blocoEixoY=blocoEixoY+altura/4.7

			novaAltura=blocoEixoY

		end
			
		blocoEixoY = novaAltura
		contadorGeral=contadorGeral+1

	end

	for cont=1,quantidadeDeBlocosDecisao,1 do

		blocoDeDecisao[cont] = cb:blocoDecisao(0, 0, cont,numeroDesafio)
		screenGroup:insert(blocoDeDecisao[cont])
		
		if contadorGeral%3~=0 then

			blocoDeDecisao[cont].x=blocoEixoX
			blocoDeDecisao[cont].y=blocoEixoY

			blocoEixoX=blocoEixoX+blocoEixoXInicial/3

			blocoEixoY = novaAltura

			novaAltura=blocoEixoY

		elseif contadorGeral%3==0 then

			blocoDeDecisao[cont].x=blocoEixoX
			blocoDeDecisao[cont].y=blocoEixoY

			blocoEixoX=largura*.55

			blocoEixoY=blocoEixoY+altura/4.7

			novaAltura=blocoEixoY

		end
			
		blocoEixoY = novaAltura
		contadorGeral=contadorGeral+1

	end

	for cont=1,quantidadeDeBlocosIteracao,1 do

		blocoDeIteracao[cont] = cb:blocoIteracao(0, 0, cont,numeroDesafio)
		screenGroup:insert(blocoDeIteracao[cont])

		if contadorGeral%3~=0 then

			blocoDeIteracao[cont].x=blocoEixoX
			blocoDeIteracao[cont].y=blocoEixoY

			blocoEixoX=blocoEixoX+blocoEixoXInicial/3

			blocoEixoY = novaAltura

			novaAltura=blocoEixoY

		elseif contadorGeral%3==0 then

			blocoDeIteracao[cont].x=blocoEixoX
			blocoDeIteracao[cont].y=blocoEixoY

			blocoEixoX=largura*.55

			blocoEixoY=blocoEixoY+altura/4.7

			novaAltura=blocoEixoY

		end
			
		blocoEixoY = novaAltura
		contadorGeral=contadorGeral+1

	end

	cont=1

	for cont=1,quantidadeDeBlocosExibicao,1 do
		blocoDeExibicao[cont] = cb:blocoExibicao(0, 0, cont,numeroDesafio)
		screenGroup:insert(blocoDeExibicao[cont])

		if contadorGeral%3~=0 then

			blocoDeExibicao[cont].x=blocoEixoX
			blocoDeExibicao[cont].y=blocoEixoY

			blocoEixoX=blocoEixoX+blocoEixoXInicial/3

			blocoEixoY = novaAltura

			novaAltura=blocoEixoY

		elseif contadorGeral%3==0 then

			blocoDeExibicao[cont].x=blocoEixoX
			blocoDeExibicao[cont].y=blocoEixoY

			blocoEixoX=largura*.55

			blocoEixoY=blocoEixoY+altura/4.7

			novaAltura=blocoEixoY

		end

		blocoEixoY = novaAltura
		contadorGeral=contadorGeral+1

	end

	for cont=1,quantidadeDeBlocosEntrada,1 do
		blocoDeEntrada[cont] = cb:blocoEntrada(0, 0, cont,numeroDesafio)
		screenGroup:insert(blocoDeEntrada[cont])

		if contadorGeral%3~=0 then

			blocoDeEntrada[cont].x=blocoEixoX
			blocoDeEntrada[cont].y=blocoEixoY

			blocoEixoX=blocoEixoX+blocoEixoXInicial/3

			blocoEixoY = novaAltura

		elseif contadorGeral%3==0 then

			blocoDeEntrada[cont].x=blocoEixoX
			blocoDeEntrada[cont].y=blocoEixoY

			blocoEixoX=largura*.55

			blocoEixoY=blocoEixoY+altura/4.7

			novaAltura=blocoEixoY
	
		end

		blocoEixoY = novaAltura
		contadorGeral=contadorGeral+1

	end

	blocoInicio=display.newImage("GameDesign/DesignGrafico/Desafio/inicio"..ds_idioma..".png")
	blocoInicio.width=largura*.13
	blocoInicio.height=altura*.09
	blocoInicio.x=largura*.14
	blocoInicio.y=altura*.08
	screenGroup:insert(blocoInicio)

	blocoFim=display.newImage("GameDesign/DesignGrafico/Desafio/fim"..ds_idioma..".png")
	blocoFim.width=largura*.13
	blocoFim.height=altura*.09
	blocoFim.x=largura*.35
	blocoFim.y=altura*.93
	screenGroup:insert(blocoFim)

	screenGroup:toBack()

end

-- Cria função de toque
function moverBloco(self, event)
	
	
	if event.phase == "began" then
		
		local soundEffect = audio.loadSound("GameDesign/Audio/pegar.mp3")
		audio.play(soundEffect)
	
		display.getCurrentStage():setFocus(event.target)
		self.markX = self.x 
		self.markY = self.y 
	
	elseif event.phase == "moved" then
		if self.markX~=nil then
			local x = (event.x - event.xStart) + self.markX	
			local y = (event.y - event.yStart) + self.markY
	
			self.x, self.y = x, y 

			varX=self.x
			varY=self.y
			varNome=self.name
			varTipo=self.tipo
			varId=self.id
		end

	elseif event.phase == "ended"  or event.phase == "cancelled" then
		
		local soundEffect = audio.loadSound("GameDesign/Audio/soltar.mp3")
		audio.play( soundEffect )

		if varX >largura*.125 and varY>altura*.107 and varY<altura*.884 and varX<largura*.38 then

			blocosPosicionamento[varNome]=self
			blocosPosicionamento[varNome].x=varX
			blocosPosicionamento[varNome].y=varY
			blocosPosicionamento[varNome].tipo=varTipo
			blocosPosicionamento[varNome].id=varId

			blocosMovidos[#blocosMovidos+1]=varNome

			varX=nil
			varY=nil
			varNome=nil
			varTipo=nil
			varId=nil

		end

			display.getCurrentStage():setFocus(nil)

	end

	return true
	
end 
blocosNovos = {}
blocosNovos2 = {}
function verificarDesafio(self, event)
		local soundEffect = audio.loadSound("GameDesign/Audio/testa.mp3")
			audio.play( soundEffect )

	if event.phase =="began" or event.phase == "moved" then

	for contadorDeBlocos0=1,#blocosMovidos,1 do 

		valor0=blocosMovidos[contadorDeBlocos0]
		blocosNovos[contadorDeBlocos0]=blocosPosicionamento[valor0]

	end
d=0
while d<3 do
	for i = 1, #blocosNovos, 1 do
    	for j = i + 1, #blocosNovos+1, 1 do
        	if (blocosNovos[i] == blocosNovos[j]) then
            	table.remove(blocosNovos, i)
            	i=1
        	end
    	end
	end
	d=d+1
end
j=1
	for contNovo=1,#blocosNovos,1 do
		if blocosNovos[contNovo]~=nil then
			blocosNovos2[j]=blocosNovos[contNovo]
			j=j+1
		end
	end
	blocosNovos=nil
	blocosNovos={}
	blocosNovos=blocosNovos2
	d=0
	while d<3 do
		for contador=1,#blocosNovos,1 do
			if blocosNovos[contador]==nil then
				contador=contador+1
			elseif blocosNovos[contador].x <largura*.125 or blocosNovos[contador].y<altura*.107 or blocosNovos[contador].y>altura*.884 or blocosNovos[contador].x>largura*.38 then
				table.remove(blocosNovos, contador)
			end
		end
		d=d+1
	end
		novoDialogo=vf:verificar(blocosNovos,numeroDesafio,quantidadeDeBlocos,blocosMovidos)

		quantidadeDeBlocos=nil

		for j=1,quantidadeDeBlocosExibicao,1 do

			blocoDeExibicao[j]:removeSelf()

		end

		for j=1,quantidadeDeBlocosIteracao,1 do

			blocoDeIteracao[j]:removeSelf()

		end

		for j=1,quantidadeDeBlocosEntrada,1 do

			blocoDeEntrada[j]:removeSelf()

		end

		for j=1,quantidadeDeBlocosOperacao,1 do

			blocoDeOperacao[j]:removeSelf()

		end

		for j=1,quantidadeDeBlocosDecisao,1 do

			blocoDeDecisao[j]:removeSelf()

		end

		for j=1,#pontoDeSequencia,1 do

			pontoDeSequencia[j]:removeSelf()

		end

		avancarDesafio(novoDialogo)

	end

end

function avancarDesafio(avancar)

	local transicao

	-- Laço que irá rodar enquanto houverem linhas na tabela
	for row in db:nrows("SELECT fg_transicao FROM t_Puzzle WHERE id_puzzle = (SELECT id_puzzle FROM t_Jogador)") do

		transicao = row.fg_transicao

	end

	   	storyboard.gotoScene("Fases")

		td = TelaDeDialogo:new()
		td:desafios(avancar.proximoDialogo)

end

function Scene:enterScene(event)

	storyboard.purgeScene("Fases")

	local j=1

	for j=1,#blocoDeOperacao,1 do
	blocoDeOperacao[j].touch = moverBloco
	blocoDeOperacao[j]:addEventListener("touch", blocoDeOperacao[j])
	end

	for j=1,#blocoDeDecisao,1 do
	blocoDeDecisao[j].touch = moverBloco
	blocoDeDecisao[j]:addEventListener("touch", blocoDeDecisao[j])
	end

	for j=1,#blocoDeIteracao,1 do
	blocoDeIteracao[j].touch = moverBloco
	blocoDeIteracao[j]:addEventListener("touch", blocoDeIteracao[j])
	end

	for j=1,#blocoDeExibicao,1 do
	blocoDeExibicao[j].touch = moverBloco
	blocoDeExibicao[j]:addEventListener("touch", blocoDeExibicao[j])
	end

	for j=1,#blocoDeEntrada,1 do
	blocoDeEntrada[j].touch = moverBloco
	blocoDeEntrada[j]:addEventListener("touch", blocoDeEntrada[j])
	end

	botaoTeste.touch = verificarDesafio
	botaoTeste:addEventListener("touch", botaoTeste)

end

return Scene