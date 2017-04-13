-- Menu Inicial

local Sons = require("Sons")
local sound = Sons:new{1,2,3}
sound:stopAll(sound)
sound:add("GameDesign/Audio/Menu_music.mp3", "GameDesign/Audio/Menu_music")
sound:setVolume(0.8)
sound:play("GameDesign/Audio/Menu_music", {loops=-1})


local storyboard = require ("storyboard")
local Scene = storyboard.newScene()

-- Calcula largura e altura da tela
local largura = display.contentWidth
local altura = display.contentHeight

-- Variaveis
local ceu
local background
local ceuMovendo
local logo
local botoesMenu = {}
mensagemSemSave=false

function Scene:exitScene(event)

	-- Remove evento que foi iniciado na função enterScene
	-- background:removeEventListener("touch", start)
	ceu:removeSelf()
	ceuMovendo:removeSelf()
	background:removeSelf()
	logo:removeSelf()
	botoesMenu[1]:removeSelf()
	botoesMenu[2]:removeSelf()
	botoesMenu[3]:removeSelf()

end

-- Cria cena
function Scene:createScene(event)

	local screenGroup = self.view

	-- Fundo
	-- Utiliza imagem já existente como imagem de fundo
	background = display.newImage("GameDesign/DesignGrafico/TelaInicial/Background/fundoDeTitulo_blur.png")

	ceu = display.newImage("GameDesign/DesignGrafico/TelaInicial/Background/ceu_blur.png")

	ceu.height = altura
	ceu.width = largura + 30
	ceu.x = 0
	ceu.y=altura *.5
	ceu.speed = 1

	ceuMovendo = display.newImage("GameDesign/DesignGrafico/TelaInicial/Background/ceu_blur.png")
	ceuMovendo.height = altura
	ceuMovendo.width = largura + 30
	ceuMovendo.x = ceu.x + ceu.width
	ceuMovendo.y = altura *.5
	ceuMovendo.speed = 1

	background.height = altura
	background.width = largura
	background.x = largura *.5
	background.y = altura *.5

	screenGroup:insert(ceu)
	screenGroup:insert(ceuMovendo)
	screenGroup:insert(background)

    logo = display.newImage("GameDesign/DesignGrafico/TelaInicial/LogotipoMenu/logotipo.png")

    logo.width = largura *.49
    logo.height = altura *.45
    logo.x = largura /2
    logo.y = altura /3
    logo.rotation = 0

	--Botão de Novo Jogo
	botoesMenu[1] = display.newImage("GameDesign/DesignGrafico/TelaInicial/LogotipoMenu/novoJogo.png") -- cima
	--Cria botão para cima atraves de uma imagem
	botoesMenu[1].x = largura *.5
	--Eixo x do botão
	botoesMenu[1].y = altura *.65
	--Nomeia o botão
	botoesMenu[1].myName = "novoJogo"

	--Tamanho do botão
	botoesMenu[1].width = largura *.395
	botoesMenu[1].height = altura *.15

	--Botão de Continuar Jogo
	botoesMenu[2] = display.newImage("GameDesign/DesignGrafico/TelaInicial/LogotipoMenu/carregar.png") -- cima
	
	--Cria botão para cima atraves de uma imagem
	botoesMenu[2].x = largura*.5
	
	--Eixo x do botão
	botoesMenu[2].y = altura*.78
	
	--Nomeia o botão
	botoesMenu[2].myName = "continuarJogo"
	
	--Tamanho do botão
--	botoesMenu[2]:scale(.6,.6)
	botoesMenu[2].width = largura *.435
	botoesMenu[2].height = altura *.15
	
	--Botão de Sair
	botoesMenu[3] = display.newImage("GameDesign/DesignGrafico/TelaInicial/LogotipoMenu/sair.png")
	--Cria botão para cima atraves de uma imagem
	botoesMenu[3].x = largura*.9
	--Eixo x do botão
	botoesMenu[3].y = altura*.93
	--Nomeia o botão
	botoesMenu[3].myName = "sair"
	--Tamanho do botão
	botoesMenu[3].width = largura *.18
	botoesMenu[3].height = altura *.15

end

--Cria função de toque
local acessarJogo = function(e)

	local opcao = e.target.myName

	--Se o botão for precionado o movido
	if e.phase =="began" or e.phase == "moved" then

		-- Se o botão Novo Jogo for tocado
		if opcao=="novoJogo" then

			--Para o audio da tela anterior caso o botao novo jogo seja apertado
			sound:remover( "GameDesign/Audio/Menu_music")
			
			--Inicia o audio do click
			local soundEffect = audio.loadSound("GameDesign/Audio/Click_0.mp3")
			audio.play( soundEffect )
		
     		local storyboard = require "storyboard"
  
     		storyboard.gotoScene("NovoJogo")
			

		elseif opcao=="continuarJogo" then
			
			local soundEffect = audio.loadSound("GameDesign/Audio/Click_0.mp3")
      		audio.play( soundEffect )

     		storyboard.gotoScene("Continuar")
			
		elseif opcao=="sair" then
		
			function quit() 
				os.exit() 
			end 
				timer.performWithDelay(1000,quit)
			
		end

	end

end

function Scene:enterScene(event)

	-- Chamando a função
	ceu.enterFrame = callbackMoverCeu

	-- Função sendo executada constantemente
	Runtime:addEventListener("enterFrame", ceu)

	-- Chamando a função
	ceuMovendo.enterFrame = callbackMoverCeu

	-- Função sendo executada constantemente
	Runtime:addEventListener("enterFrame", ceuMovendo)

	-- cria variavel
	local j=1

	--Toda vez que clicar, será criado um evento
	for j=1, #botoesMenu do

	--Cria evento onde a cada toque será chamada a função acessarJogo
		botoesMenu[j]:addEventListener("touch", acessarJogo)

	end

end

--Callback
--Função para mover a tela
function callbackMoverCeu(self,event)
	
	--Ceu se move na tela a cada vez que a função for chamada
	if self.x < largura*.5-self.contentWidth+10 then
		self.x = (largura*.5+self.contentWidth-30)
	
	else
		
		--Define a velocidade com a qual o céu se move
		self.x = self.x - self.speed

	end

end

Scene:addEventListener("createScene", Scene)
Scene:addEventListener("enterScene", Scene)
Scene:addEventListener("exitScene", Scene)

return Scene