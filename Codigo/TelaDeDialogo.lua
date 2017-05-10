require ("sqlite3")
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local transition = require("transition")
-- Caminho para o banco
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path) 
local indice = 0
local imagemDeFundo
local texto
local caixaDeDialogo
local textoDialogo = {}
local pular=false
cont_ad=0
local Sons = require( "Sons" )
sound = Sons:new{1,2}
sound:add( "GameDesign/Audio/Dialogo_inicial.mp3", "GameDesign/Audio/Dialogo_inicial")
sound:setVolume( 0.4 )
sound:play("GameDesign/Audio/Dialogo_inicial", {loops=-1} )

for row in db:nrows("SELECT ds_idioma FROM t_Jogador") do
   	ds_idioma = row.ds_idioma
end

-- Classe
TelaDeDialogo = {}
function TelaDeDialogo:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Buscando o sexo do personagem no banco 
function buscaSexoPersonagem()
	local db = sqlite3.open(path)
	local sexo 
	for row in db:nrows("SELECT id_genero FROM t_Jogador") do
		if row.id_genero == 1 then
			sexo = "M"
		else
			sexo = "F"
		end
	end
	return sexo
end	

-- Buscando a fase no banco 
function buscaFaseAtual()
	local db = sqlite3.open(path)
	local desafio 
	for row in db:nrows("SELECT id_fase FROM t_Jogador") do 
		if row.id_fase == nil then
			fase=1
		else
			fase=row.id_fase 
		end
	end
	return fase
end	

-- Buscando o desafio no banco 
function buscaDesafioAtual()
	local db = sqlite3.open(path)
	local desafio 
	for row in db:nrows("SELECT ds_puzzle FROM t_Puzzle WHERE id_puzzle=(SELECT id_puzzle FROM t_Jogador)") do
		puzzle=row.ds_puzzle
	end
	return puzzle
end	

-- Método que cria o background
function TelaDeDialogo:criaFundo(aImagem)
	-- Inserindo imagem de fundo
 	imagemDeFundo = display.newImage(aImagem)
 	imagemDeFundo.x = display.contentWidth/2
 	imagemDeFundo.y = display.contentHeight/2 
 	imagemDeFundo.width = display.contentWidth
 	imagemDeFundo.height = display.contentHeight*1.2
 	imagemDeFundo:toFront()
end

function TelaDeDialogo:criaCaixaDialogo()
	-- inserindo caixa de dialogo
 	caixaDeDialogo = display.newImage("GameDesign/DesignGrafico/CaixaDialogo/caixaDeDialogo.png")
 	caixaDeDialogo.x = display.contentWidth/2
 	caixaDeDialogo.y = display.contentHeight/1.4
 	caixaDeDialogo.width = display.contentWidth
	caixaDeDialogo.height = display.contentHeight*0.5  
	caixaDeDialogo:toFront()
end

-- Método que cria o texto
-- newText(posX, posY, largX, largY,tipoFonte,tamanho)
function TelaDeDialogo:criaTexto(oTexto,oEmissor)
	-- caixa de texto
	texto = display.newText(
		oTexto, 
		display.contentWidth/2.2,
		display.contentHeight/1.35,
		display.contentWidth/1.3, 
		display.contentHeight/4, 
		"arial", display.contentWidth/35)
	texto:setFillColor(0,0,0)
 	-- Emissor do texto
 	personagemEmissor = display.newText(
 		oEmissor, 
		display.contentWidth/2.2,
		display.contentHeight/1.54,
		display.contentWidth/1.3, 
		display.contentHeight/4, 
		"arial", display.contentWidth/35)
	personagemEmissor:setFillColor(0,0,0)
end

-- Método que cria o botão Proximo 
function TelaDeDialogo:criaBotaoProximo()
 	botaoProximo = widget.newButton{		
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoAvancar.png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoAvancarPressionado.png",
 	-- Posição do botão em x e y
 		x = display.contentWidth/1.13,
 		y = display.contentHeight/1.45,
 	-- Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10*0.85,
 	-- Função para o botão
 		onRelease = atualizaDialogo,
 	}
end

-- Método que cria o botão Anterior 
function TelaDeDialogo:criaBotaoAnterior()
  	botaoAnterior = widget.newButton{
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoVoltar.png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoVoltarPressionado.png",
 	-- Posição do botão em x e y
 		x = display.contentWidth/1.13,
 		y = display.contentHeight/1.17,
 	-- Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10*0.85,	
 	-- Função para o botão
 		onRelease = voltaDialogo,
 	}
end

-- Método que cria o botão Anterior 
function TelaDeDialogo:criaBotaoPular()
	--Botão de Pular diálogo
	botaoPular = display.newImage("GameDesign/DesignGrafico/CaixaDialogo/botao"..ds_idioma.."Pular.png") -- cima
	--Cria botão para cima atraves de uma imagem
	botaoPular.x = largura *.2
	--Eixo x do botão
	botaoPular.y = altura *.15
	botaoPular.width= display.contentWidth/3
	botaoPular.height= display.contentWidth/8*0.85
	--Nomeia o botão
	botaoPular.myName = "pular"
end

-- Método que atualiza o dialogo para o anterior
function voltaDialogo()	
	local soundEffect = audio.loadSound("GameDesign/Audio/retornar.mp3")
	audio.play( soundEffect )
	retornaDialogo()
	alteraTexto()
	alteraFundo()
end

-- Método que atualiza o dialogo
function atualizaDialogo()
	indice = indice + 1 
	if textoDialogo[indice][1] ~= "fim" then
		avancaDialogo()
		alteraFundo()
		alteraTexto()
	else
		encerraDialogo()
	end
end

-- Método que altera texto
function alteraTexto()
	if oEmissor == "Narrador" then
		texto.text = oTexto
		texto:setFillColor(0.0, 0.2, 0.0)
		personagemEmissor.text = oEmissor
		personagemEmissor:setFillColor(0.0, 0.2, 0.0)
	else
		texto.text = oTexto
		texto:setFillColor(0,0,0)
		personagemEmissor.text = oEmissor
		personagemEmissor:setFillColor(0,0,0)
	end
end

-- Método que altera plano de fundo
function alteraFundo()
	imagemDeFundo:removeSelf()
	imagemDeFundo = nil
	imagemDeFundo = display.newImage(aImagem)
	imagemDeFundo.x = display.contentWidth/2
 	imagemDeFundo.y = display.contentHeight/2 
 	imagemDeFundo.width = display.contentWidth
 	imagemDeFundo.height = display.contentHeight*1.2
	caixaDeDialogo:toFront()
	texto:toFront()
	botaoProximo:toFront()
	botaoAnterior:toFront()
	personagemEmissor:toFront()
end

local appodeal = require( "plugin.appodeal" )
local function adListener( event )
    if ( event.phase == "init" ) then  -- Successful initialization
        print( event.isError )
    end
end

-- Initialize the Appodeal plugin
appodeal.init( adListener, { appKey="281bc7e6da677bf36e000c3727014e0b2d8b5117b26bcfae" } )

function encerraDialogo()
	-- Matar objetos de tela e limpar memoria
	indice = 0
	botaoAnterior:removeSelf()
	botaoAnterior = nil
	botaoProximo:removeSelf()
	botaoProximo = nil		
	eliminarFundo = 1
	caixaDeDialogo:removeSelf()
	caixaDeDialogo = nil
	texto:removeSelf()
	personagemEmissor:removeSelf()	
	imagemDeFundo:removeSelf()
	imagemDeFundo=nil
	if botaoPular~=nil then botaoPular:removeSelf() end
	botaoPular = nil
	if cont_ad == 2 then
		appodeal.show("interstitial")
		cont_ad=0
	end
	-- Remove o som da tela de diálogo.
	sound:stopAll(sound)
	for row in db:nrows("SELECT id_fase FROM t_Jogador") do
		--Para todos os sons atuais
		sound:stopAll(sound)

		if id_fase==0 then
  			require ("TelaDeCredito")
  			tc = TelaDeCredito:new()
  			tc:creditos()
	  	elseif id_fase == 2 then
      		sound:add( "GameDesign/Audio/song"..row.id_fase..".mp3", "GameDesign/Audio/song"..row.id_fase)
      		sound:setVolume( 0.4 )
      		sound:play("GameDesign/Audio/song"..row.id_fase, {loops=-1} )
			sound:add("GameDesign/Audio/Cav01.mp3", "GameDesign/Audio/Cav01")
			sound:setVolume(0.8)
			sound:play("GameDesign/Audio/Cav01",{loops=-1})
		else
			-- Adiciona o som que sera utilizado nas fases
			sound:add( "GameDesign/Audio/song"..row.id_fase..".mp3", "GameDesign/Audio/song"..row.id_fase)
			sound:setVolume( 0.4 )
			sound:play("GameDesign/Audio/song"..row.id_fase, {loops=-1} )
		end
	end
end

-- Método responsavel pelo avanço do diaogo
function avancaDialogo()
		local soundEffect = audio.loadSound("GameDesign/Audio/avançar.mp3")
		audio.play( soundEffect )
		oTexto = textoDialogo[indice][1]
		oEmissor = textoDialogo[indice][2]
		aImagem = textoDialogo[indice][3]
end

-- Método que retorna ao dialogo anterior e incremeta indice
function retornaDialogo()
	if indice >= 2 then
		indice = indice - 1
		if textoDialogo[indice] ~= "fim" then
			oTexto = textoDialogo[indice][1]
			oEmissor = textoDialogo[indice][2]
			aImagem = textoDialogo[indice][3] 		
		else
		indice = 0
		end 
	end	
end

-- Dialogo de inicio do jogo
function TelaDeDialogo:dialogoFase()
	-- sp recebe o resultado da busca pelo sexo do personagem "M" ou "F"
	local sp = buscaSexoPersonagem()
	local faseAtual = buscaFaseAtual()
	if faseAtual==0 then faseAtual=3 end
	local cont = 1
	local contador=1
	local caminhoArquivo = system.pathForFile("GameDesign/DesignGrafico/Dialogos/"..ds_idioma.."/dialogoInicial"..sp..faseAtual..".txt")
	local arquivo = io.open(caminhoArquivo, "r")
	local savedData = arquivo:read("*a")
	io.close(arquivo)
	arquivo = nil
	aImagem = "GameDesign/DesignGrafico/Fases/TelaDialogo"..faseAtual.."/fundoDialogo00.jpg"
	oTexto = "..."
	if ds_idioma == 'eng' then 
		oEmissor = "Character"
	else
		oEmissor = "Personagem"
	end
	TelaDeDialogo:criaFundo(aImagem)
	TelaDeDialogo:criaCaixaDialogo()
	TelaDeDialogo:criaTexto(oTexto,oEmissor)
	TelaDeDialogo:criaBotaoProximo()
	TelaDeDialogo:criaBotaoAnterior()
	for word in string.gmatch(savedData, '([^|]+)') do
		if cont==1 then
			text=nil
			text=word
			cont=cont+1
		elseif cont==2 then
			locutor=nil
			locutor=word
			cont=cont+1
		else
			imagem=nil
			imagem=word
			cont=1
			textoDialogo[contador] = {text,locutor,imagem}
			contador=contador+1	
		end
	end
	atualizarDados = [[UPDATE t_Fase SET fg_dialogo='false' WHERE id_fase=1]]
	db:exec(atualizarDados)
end

-- Dialogo inicial do desafio verificar coco 
function TelaDeDialogo:desafios(tipoDialogo)
	-- sp recebe o resultado da busca pelo sexo do personagem "M" ou "F"
	local sp = buscaSexoPersonagem()
	local desafioAtual=buscaDesafioAtual()
	local faseAtual=buscaFaseAtual()
	if faseAtual==0 then faseAtual=3 end
	local cont = 1
	local contador=1
	local caminhoArquivo
	for row in db:nrows("SELECT fg_dialogo FROM t_Fase WHERE id_fase="..faseAtual) do
			primeiroAcesso=row.fg_dialogo
 	end

	for row in db:nrows("SELECT ds_idioma FROM t_Jogador") do
    	ds_idioma = row.ds_idioma
	end
	if tipoDialogo==nil then
		caminhoArquivo = system.pathForFile("GameDesign/DesignGrafico/Dialogos/"..ds_idioma.."/"..desafioAtual..sp..".txt")
	else
		caminhoArquivo = system.pathForFile("GameDesign/DesignGrafico/Dialogos/"..ds_idioma.."/"..tipoDialogo..sp..".txt")
	end
	k=0
	s=''
	if tipoDialogo ~=nil then
		k=string.len(tipoDialogo)-4
		s=s..tipoDialogo:sub(k)
	end

	if s =='Falha' then
		cont_ad=cont_ad+1
		s=''
	end
	local arquivo = io.open(caminhoArquivo, "r")
	local savedData = arquivo:read("*a")
	io.close(arquivo)
	arquivo = nil
	aImagem = "GameDesign/DesignGrafico/Fases/TelaDialogo"..faseAtual.."/fundoDialogo.jpg"
	if (primeiroAcesso=='true' and faseAtual>1) then
		atualizarDados = [[UPDATE t_Fase SET fg_dialogo='false' WHERE id_fase=]]..id_fase
		db:exec(atualizarDados)

	 	for row in db:nrows("SELECT MAX(id_Fase) AS max FROM t_Puzzle WHERE fg_realizado='true'") do
 			faseAtual=nil
 			faseAtual=row.max
 		end

	elseif faseAtual==1 then
		atualizarDados = [[UPDATE t_Fase SET fg_dialogo='false' WHERE id_fase=]]..id_fase
		db:exec(atualizarDados)
	end
	if tipoDialogo ~= nil then
		for row in db:nrows("SELECT id_puzzle, id_fase FROM t_Puzzle WHERE fg_transicao='true'") do
			if tipoDialogo:sub(9,9) == tostring(row.id_puzzle) then
				aImagem = "GameDesign/DesignGrafico/Fases/TelaDialogo"..row.id_fase.."/fundoDialogo.jpg"
				cont_ad=2
			end
		end
	end
	oTexto = ""
	oEmissor = ""
	TelaDeDialogo:criaFundo(aImagem)
	TelaDeDialogo:criaCaixaDialogo()
	TelaDeDialogo:criaTexto(oTexto,oEmissor)
	TelaDeDialogo:criaBotaoProximo()
	TelaDeDialogo:criaBotaoAnterior()
	TelaDeDialogo:criaBotaoPular()
	botaoPular:addEventListener("touch", encerraDialogo)

-- Cria função de toque
local acessarJogo = function(e)
	local opcao = e.target.myName
		if e.phase =="began" or e.phase == "moved" then
			if opcao=='pular' then
				encerraDialogo()
			end
		end
	end
	for word in string.gmatch(savedData, '([^|]+)') do
		if cont==1 then
			text=nil
			text=word
			cont=cont+1
		elseif cont==2 then
			locutor=nil
			locutor=word
			cont=cont+1
		else
			imagem=nil
			imagem=word
			cont=1
			textoDialogo[contador] = {text,locutor,imagem}
			contador=contador+1	
		end
	end
end