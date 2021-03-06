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
	for row in db:nrows("SELECT id_fase FROM t_Jogador") do
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

  	for row in db:nrows("SELECT ini_x, ini_y FROM t_Jogador") do
		inicial_x=row.ini_x
  		inicial_y=row.ini_y
	end

	if id_fase==0 then
		id_fase=0
		atualizarFase3 = [[UPDATE t_Fase SET fg_dialogo='false']]
		db:exec(atualizarFase3)
		for row in db:nrows("SELECT id_fase FROM t_Fase") do
			atualizarFase4 = [[UPDATE t_Puzzle SET fg_liberado='true' WHERE id_puzzle=(SELECT min(id_puzzle) FROM t_Puzzle WHERE id_fase=']]..row.id_fase..[[');]]
			db:exec(atualizarFase4)
		end
		storyboard.reloadScene()
	else
		local mp = Mapa:new()
		local map = mp:criarMapa(id_fase)
		local pX=0
		local pY=0
		if primeiroAcesso=='true' then
			pX=ini_x
			pY=ini_y
			local posicaoInicial = [[UPDATE t_Jogador SET ini_y=]]..ini_y..[[, ini_x=]]..ini_x..[[;]]
			db:exec(posicaoInicial)
		else
			for row in db:nrows("SELECT max(id_puzzle) AS m_max FROM t_Puzzle WHERE fg_liberado='true' AND id_fase=(SELECT id_fase FROM t_Jogador);") do
				p_max=row.m_max
			end

			for row in db:nrows("SELECT min(id_puzzle) AS m_min FROM t_Puzzle WHERE id_fase=(SELECT id_fase FROM t_Jogador);") do
				p_min=row.m_min
			end

			for row in db:nrows("SELECT id_puzzle, id_puzzle_anterior FROM t_Jogador;") do
				i_p=row.id_puzzle
				i_pa=row.id_puzzle_anterior
			end
			print(i_p)
			print(i_pa)
			if (p_min==p_max and i_p~=i_pa) then
				pX=ini_x
				pY=ini_y
			else
				pX=inicial_x
				pY=inicial_y
			end
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

function voltarMenu()
	botaoVoltarTela:removeSelf()
	objetoColidido=nil
	if botaoAnterior~=nil then
		encerraDialogo()
	end
	local j=1
	-- Toda vez que clicar, será criado um evento
	for j=1,#botoes,1 do
		botoes[j]:removeSelf()
	end
	storyboard.gotoScene("MenuInicial")
 	storyboard.removeScene("Fases")
end

--Inicio da cena
function scene:enterScene(event)
	storyboard.removeScene("MenuInicial")
	storyboard.removeScene("NovoJogo")
	storyboard.removeScene("Continuar")
	storyboard.removeScene("Desafio")
	atualizarMovimento(true)
	Runtime:addEventListener("key", voltarMenuAndroid)
end

-- Quando clicar no botão voltar ir para o menu
local function voltarMenuAndroid( event )
    if (event.keyName == "back") then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
          voltarMenu()
          return true
        end
    end
    return false
end

-- Remove eventos e objetos da cena
function scene:exitScene(event)
	botaoVoltarTela:removeSelf()
	objetoColidido=nil
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