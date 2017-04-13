-- Gerar fases

local storyboard = require("storyboard")
require("sqlite3")
require("Controle")
require("Personagem")
require("Mapa")

local scene = storyboard.newScene()

local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path)
local cont
local objetosDeDesafio = {}

-- Requerimento(Importação) da biblioteca fisica
local physics = require "physics"
-- Inicia a fisica, necessário para o evento de colisão que vai ser utilizado posteriormente
physics.start()
-- Deixa a gravidade em zero
physics.setGravity(0, 0)

function scene:createScene(event)

	for row in db:nrows("SELECT id_fase FROM t_Jogador WHERE id_jogador=1") do

    	-- Exibe dados na tela
    	id_fase = row.id_fase

  	end

	for row in db:nrows("SELECT MIN(id_puzzle) as MIN FROM t_Puzzle WHERE id_fase = "..id_fase) do

		primeiroPuzzle = row.MIN

	end

 	for row in db:nrows("SELECT ini_x, ini_y, fg_dialogo FROM t_Fase WHERE id_fase="..id_fase) do

    	ini_y = row.ini_y
	   	ini_x = row.ini_x
		primeiroAcesso=row.fg_dialogo

  	end

  	for row in db:nrows("SELECT ini_x, ini_y FROM t_Jogador WHERE id_jogador=1") do

		inicial_x=row.ini_x
  		inicial_y=row.ini_y

	end

	if id_fase==0 then
		id_fase=0
		atualizarFase3 = [[UPDATE t_Fase SET fg_dialogo='false']]
		db:exec(atualizarFase3)

	else

		local mp = Mapa:new()
		local map = mp:criarMapa(id_fase)

		local pX=0
		local pY=0


		if primeiroAcesso=='true' then
			pX=ini_x
			pY=ini_y

			local posicaoInicial = [[UPDATE t_Jogador SET ini_y=]]..ini_y..[[, ini_x=]]..ini_x..[[ WHERE id_jogador=1;]]
			db:exec(posicaoInicial)
			if id_fase>1 then
				faseAnterior=id_fase-1
			end
			if faseAnterior ~=nil then
				atualizarFase2 = [[UPDATE t_Fase SET fg_dialogo='true' WHERE id_fase=']]..faseAnterior..[[']]
				db:exec(atualizarFase2)
			end
		else
			pX=inicial_x
			pY=inicial_y

		end

		pr = Personagem:new()
		personagemRecebido = pr:criarPersonagem(pX, pY)
		ct = Controle:new()
		botao=ct:criarBotoes()
		ct:testarMovimentos(botao)

		cont=primeiroPuzzle

		for row in db:nrows("SELECT img_objeto, ps_x, ps_y FROM t_Puzzle WHERE id_fase="..id_fase) do

			local obj = display.newImage("GameDesign/DesignGrafico/tilesets/"..row.img_objeto)
			obj:scale(1.2,1.2)
			-- Define "corpo" para o coco, para que ele possa ser afetado por ações de colisão
			physics.addBody(obj,"static",{radius=obj.width*.8})
			-- Insere objeto numa layer no mapa
			map.layer["personagem"]:insert(obj)
			obj.x=map.data.width*row.ps_x
			obj.y=map.data.height*row.ps_y

			objetosDeDesafio[cont]=obj
			objetosDeDesafio[cont].desafio=cont
			cont=cont+1

		end

		objeto(objetosDeDesafio,true)

		if (id_fase==1 and primeiroAcesso=='true') then
			require("TelaDeDialogo")
			td = TelaDeDialogo:new()
			td:dialogoFase()
		end
	end
end

--Inicio da cena
function scene:enterScene(event)

--	atualizarMovimento(false)
	storyboard.removeScene("MenuInicial")
	storyboard.removeScene("NovoJogo")
	storyboard.removeScene("ContinuarJogo")
	storyboard.removeScene("Desafio")
	atualizarMovimento(true)

end

--Remove eventos e objetos da cena
function scene:exitScene(event)

  	if id_fase~=0 then

		map:removeSelf()
		map=nil

  		for row in db:nrows("SELECT MIN(id_puzzle) as MIN FROM t_Puzzle WHERE id_fase = "..id_fase) do

			primeiroPuzzle = row.MIN

		end

		for j=primeiroPuzzle,#objetosDeDesafio,1 do

			objetosDeDesafio[j]:removeSelf()
			objetosDeDesafio[j]=nil

		end

		atualizarMovimento(false)
		objeto(objetosDeDesafio,false)
		storyboard.removeScene("Desafio")
		storyboard.removeAll()

	end
end

scene:addEventListener("createScene",scene)
scene:addEventListener("enterScene",scene)
scene:addEventListener("exitScene",scene)

return scene