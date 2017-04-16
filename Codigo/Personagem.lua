--Personagem
--display.setStatusBar(display.HiddenStatusBar)

display.setDefault("minTextureFilter", "nearest")
display.setDefault("magTextureFilter", "nearest")

-- Localize
require ("sqlite3")

--Define a fisica do programa
local fisica = require("physics")
fisica.start()
fisica.setGravity(0, 0)

--Largura e altura
local largura = display.contentWidth
local altura = display.contentHeight

--Variaveis referentes ao personagem
local personagem
local genero

--Variaveis referentes ao banco
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

--Meta Classe
Personagem = {}

-- construtor da Clase
function Personagem:new (o)

  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o

end

function Personagem:criarPersonagem(posicaoInicialX, posicaoInicialY)

	local sheetInfo

	id_Jogador=1

		-- Laço que irá rodar enquanto houverem linhas na tabela
	for row in db:nrows("SELECT id_genero FROM t_Jogador WHERE id_jogador=1") do

		-- Exibe dados na tela
		if row.id_genero ==1 then

			genero="PersonagemMasculino"
			sheetInfo = require("PersonagemMasculino")
		else

			genero="PersonagemFeminina"
			sheetInfo = require("PersonagemFeminina")

		end

	end

	generoEscolhido="GameDesign/DesignGrafico/PersonagensPrincipais/"..genero

	sheetInfo = require(genero)

	local personagemImagem = graphics.newImageSheet( generoEscolhido..".png", sheetInfo:getSheet() )

	local sequenceData = {

		{name = "paradoBaixo", frames={1}, time = 1, loopCount=1},
		{name = "paradoDireita", frames={7}, time = 1, loopCount=1},
		{name = "paradoCima", frames={10}, time = 1, loopCount=1},
		{name = "paradoEsquerda", frames={4}, time = 1, loopCount=1},
		{name = "baixo", frames={2,3}, time=280, loopCount=30}, -- Indica a movimentação do personagem para baixo
		{name = "direita", frames={8,9,7}, time=300, loopCount=30}, -- Indica a movimentação do personagem para a direita
		{name = "cima", frames={11,12}, time=280, loopCount=30}, -- Indica a movimentação do personagem para cima
		{name = "esquerda", frames={5,6,4}, time=300, loopCount=30}, -- Indica a movimentação do personagem para a esquerda

	}

	-- Laço que irá rodar enquanto houverem linhas na tabela
	for row in db:nrows("SELECT id_fase FROM t_Jogador WHERE id_jogador="..id_Jogador) do

		-- Exibe dados na tela
		id_fase=row.id_fase

	end

	--Cria nova imagem do personagem e define sua sequencia de movimentos
	local personagem = display.newSprite( personagemImagem , sequenceData )
	--Define tamanho do personagem
	personagem:scale(2.5,2.5)
	-- Usado para identificar o personagem
	personagem.title = "personagem"
	--Define "corpo" para o fersonagem, para que ele possa ser afetado por ações de colisão
	physics.addBody(personagem, "dynamic", {radius = personagem.width})
	--Insere personagem numa layer no mapa
	map.layer["personagem"]:insert(personagem)

	-- Define o mapa da camera
	map.setTrackingLevel(0.1)
	personagem.x = posicaoInicialX+50
	personagem.y = posicaoInicialY+1

	return personagem

end