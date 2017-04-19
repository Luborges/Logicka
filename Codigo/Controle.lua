-- Botões

-- meta Classe
Controle= {}

-- Localize
require ("sqlite3")
require ("MensagemDeAlerta")

-- Define a fisica do programa
local fisica = require("physics")

fisica.start()
fisica.setGravity(0, 0)

-- Largura e altura
local largura = display.contentWidth
local altura = display.contentHeight

-- Variaveis de movimentação
local passosX=0
local passosY=0

-- Variaveis referentes ao personagem
local colisao=false
local storyboard = require ("storyboard")

-- referentes ao banco
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path)
mensagemSemColisao=false

-- construtor da Clase
function Controle:new (o)

  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o

end

function objeto(obj,flag)

  	for row in db:nrows("SELECT id_fase FROM t_Jogador") do

    	-- Exibe dados na tela
    	fase = row.id_fase

  	end

	if flag==true then
		j=1

  	for row in db:nrows("SELECT MIN(id_puzzle) as MIN FROM t_Puzzle WHERE id_fase = "..fase) do

		primeiroPuzzle = row.MIN

	end

  	for row in db:nrows("SELECT MAX(id_puzzle) as MAX FROM t_Puzzle WHERE id_fase = "..fase) do

		ultimoPuzzle = row.MAX

	end

		for j=primeiroPuzzle,ultimoPuzzle,1 do
			obj[j].collision = verificarColisao
			obj[j]:addEventListener("collision", obj[j])

		end

	end

end

function Controle:criarBotoes()
	--Botões
	botoes = {}

	--Cria imagens dos botões
	botoes[1] = display.newImage("GameDesign/DesignGrafico/Controles/botaoDirecional.png") -- cima
	botoes[1].x = largura*.15
	botoes[1].y = altura*.62
	botoes[1].myName="cima"
	botoes[1]:scale(largura*.0006,altura*.00104)

	botoes[2] = display.newImage("GameDesign/DesignGrafico/Controles/botaoDirecional.png") -- direita
	botoes[2].rotation=90
	botoes[2].x = largura*.2
	botoes[2].y = altura*.737
	botoes[2].myName="direita"
	botoes[2]:scale(largura*.0006,altura*.00104)

	botoes[3] = display.newImage("GameDesign/DesignGrafico/Controles/botaoDirecional.png") -- baixo
	botoes[3].rotation=-180
	botoes[3].x = largura*.15
	botoes[3].y = altura*.85
	botoes[3].myName="baixo"
	botoes[3]:scale(largura*.0006,altura*.00104)

	botoes[4] = display.newImage("GameDesign/DesignGrafico/Controles/botaoDirecional.png") -- esquerda
	botoes[4].rotation=-90
	botoes[4].x = largura*.1
	botoes[4].y = altura*.737
	botoes[4].myName="esquerda"
	botoes[4]:scale(largura*.0006,altura*.00104)

	botoes[5] = display.newImage("GameDesign/DesignGrafico/Controles/botaoAcao.png") -- esquerda
	botoes[5].x = largura*.9
	botoes[5].y = altura*.737
	botoes[5].myName="acao"
	botoes[5]:scale(largura*.0006,altura*.00104)

	return botoes

end

--Cria função de toque
local touchFunction = function(e)
	local direcao = e.target.myName
	--Se o botão for precionado o movido
	if e.phase =="began" or e.phase == "moved" then
		-- Se o botão pra cima for tocado
		if direcao=="cima" then
			passosY=0
			passosX=0
			passosY=-13
			personagemRecebido:setSequence("cima")
			personagemRecebido:setSequence("move")
			personagemRecebido:play()

		elseif direcao=="baixo" then

			passosY=0
			passosX=0
			passosY=13
			personagemRecebido:setSequence("baixo")
			personagemRecebido:setSequence("move")
			personagemRecebido:play()
		elseif direcao=="direita" then

			passosX=0
			passosY=0
			passosX=13
			personagemRecebido:setSequence("direita")
			personagemRecebido:setSequence("move")
			personagemRecebido:play()

		elseif direcao=="esquerda" then

			passosX=0
			passosY=0
			passosX=-13
			personagemRecebido:setSequence("esquerda")
			personagemRecebido:setSequence("move")
			personagemRecebido:play()

		elseif direcao=="acao" then

			passosY=0
			passosX=0

			if (colisao==false or objetoColidido==nil) and mensagemSemColisao==false then
				ma = MensagemDeAlerta:new()
				mensagemSemColisao=ma:alertaSemColisao()
			else
				selecionarDesafio = [[UPDATE t_Jogador SET id_puzzle=]]..objetoColidido.desafio..[[;]]
				db:exec(selecionarDesafio)

				-- Laço que irá rodar enquanto houverem linhas na tabela
				for row in db:nrows("SELECT max(id_puzzle) AS puzzle FROM t_Puzzle WHERE fg_liberado='true' AND id_fase= (SELECT id_fase FROM t_Jogador)") do
					faseLiberada = row.puzzle
				end

				if objetoColidido.desafio<=faseLiberada then
					removerCena()
					atualizarDesafioAnterior = [[UPDATE t_Jogador SET id_puzzle_anterior=]]..objetoColidido.desafio..[[;]]
					db:exec(atualizarDesafioAnterior)
					atualizarDesafioAnterior=nil
				else
					if mensagemSemColisao==false then
						ma = MensagemDeAlerta:new()
						mensagemSemColisao=ma:alertaColisaoSuperior()
					end
				end			
			end
		end

	elseif e.phase =="ended" or e.phase == "cancelled" then

		passosY=0
		passosX=0

		if direcao=="baixo" then
	
			personagemRecebido:setSequence("paradoBaixo")
			personagemRecebido:play()
	
		elseif direcao=="cima" then
	
			personagemRecebido:setSequence("paradoCima")
			personagemRecebido:play()

		elseif direcao=="direita" then
	
			personagemRecebido:setSequence("paradoDireita")
			personagemRecebido:play()

		elseif direcao=="esquerda" then
	
			personagemRecebido:setSequence("paradoEsquerda")
			personagemRecebido:play()

		end

	end

end

function removerCena()

local j=1

	--Toda vez que clicar, será criado um evento
	for j=1,#botoes,1 do
		
		--Cria evento onde a cada toque será chamada a função touchFunction
		botoes[j]:addEventListener("touch", touchFunction)
		botoes[j]:removeSelf()

		atualizarPosicao = [[UPDATE t_Jogador SET ini_x=]]..personagemRecebido.x..[[, ini_y=]]..personagemRecebido.y..[[;]]
		db:exec(atualizarPosicao)


	end

	passosY=0
	passosX=0
	personagemRecebido.x=nil
	personagemRecebido.y=nil
	personagemRecebido:removeSelf()
	personagemRecebido=nil
	mensagemSemColisao=false
	storyboard.gotoScene("Desafio")

end

--Colisão entre objetos
function verificarColisao(self, event)

	if event.phase == "began" then

		colisao=true
		objetoColidido=self

	elseif event.phase == "ended" or event.phase == "cancelled" then

		colisao=false

	end

end

--Atualizar posição do jogador
function update()
	if personagemRecebido==nil then
		passosX=0
		passosY=0
	else
		personagemRecebido.x=personagemRecebido.x + passosX
		personagemRecebido.y=personagemRecebido.y + passosY
		map.setCameraFocus(personagemRecebido)
	end
end

function Controle:testarMovimentos(botoes)
	
	--cria variavel
	local j=1

	--Toda vez que clicar, será criado um evento
	for j=1,#botoes,1 do
	
		--Cria evento onde a cada toque será chamada a função touchFunction
--		botoes[j].touch = touchFunction
		botoes[j]:addEventListener("touch", touchFunction)
	
	end
	
end


function atualizarMovimento(flag)

	if flag==true then

		-- Evento executado sozinho pelo proprio programa
		Runtime:addEventListener("enterFrame", update)
	
	else

		Runtime:removeEventListener("enterFrame", update)
		--Runtime:removeEventListener("collision", colisao)

	end

end