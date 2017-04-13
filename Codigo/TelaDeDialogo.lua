require ("sqlite3")
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local transition = require("transition")

-- caminho para o banco
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path) 

local indice = 0
local imagemDeFundo
local texto
local caixaDeDialogo
local textoDialogo = {}

local Sons = require( "Sons" )
sound = Sons:new{1,2}
sound:add( "GameDesign/Audio/Diaglogo_inicial.mp3", "GameDesign/Audio/Diaglogo_inicial")
sound:setVolume( 0.4 )
sound:play("GameDesign/Audio/Diaglogo_inicial", {loops=-1} )

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

	for row in db:nrows("SELECT id_genero FROM t_Jogador WHERE id_jogador=1") do
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

	for row in db:nrows("SELECT ds_puzzle FROM t_Puzzle WHERE id_puzzle=(SELECT id_puzzle FROM t_Jogador WHERE id_jogador=1)") do

		puzzle=row.ds_puzzle

	end

	return puzzle

end	

-- Metodo que cria o background
function TelaDeDialogo:criaFundo(aImagem)

	-- inserindo imagem de fundo
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

-- Metodo que cria o texto
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

 	-- emissor do texto
 	personagemEmissor = display.newText(
 		oEmissor, 
		display.contentWidth/2.2,
		display.contentHeight/1.54,
		display.contentWidth/1.3, 
		display.contentHeight/4, 
		"arial", display.contentWidth/35)

	personagemEmissor:setFillColor(0,0,0)

end

-- Metodo que cria o botão Proximo 
function TelaDeDialogo:criaBotaoProximo()
 	
 	botaoProximo = widget.newButton{		
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoAvancar.png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoAvancarPressionado.png",
 		
 	--Posição do botão em x e y
 		x = display.contentWidth/1.13,
 		y = display.contentHeight/1.45,

 	--Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10*0.85,
 	--função para o botão
 		onRelease = atualizaDialogo,
 	}
end

-- Metodo que cria o botão Anterior 
function TelaDeDialogo:criaBotaoAnterior()
 	
 	botaoAnterior = widget.newButton{
 		
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoVoltar.png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoVoltarPressionado.png",

 	--Posição do botão em x e y
 		x = display.contentWidth/1.13,
 		y = display.contentHeight/1.17,

 	--Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10*0.85,	

 	--função para o botão
 		onRelease = voltaDialogo,
 	}
end

-- metodo que atualiza o dialogo para o anterior
function voltaDialogo()	
	local soundEffect = audio.loadSound("GameDesign/Audio/retornar.mp3")
	audio.play( soundEffect )
	retornaDialogo()
	alteraTexto()
	alteraFundo()
end

-- metodo que atualiza o dialogo
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

-- metodo que altera texto
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

-- metodo que altera plano de fundo
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
		
	-- Remove o som da tela de dialogo.
	sound:stopAll(sound)
		
	for row in db:nrows("SELECT id_fase FROM t_Jogador WHERE id_jogador=1") do
		--Para todos os sons atuais
		sound:stopAll(sound)

		if id_fase==0 then
  			require ("TelaDeCredito")
  			tc = TelaDeCredito:new()
  			tc:creditos()

	  	elseif id_fase == 2 then
			sound:add("GameDesign/Audio/Cav01.wav", "GameDesign/Audio/Cav01")
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

-- metodo responsavel pelo avanço do diaogo
function avancaDialogo()
		local soundEffect = audio.loadSound("GameDesign/Audio/avançar.mp3")
		audio.play( soundEffect )
		oTexto = textoDialogo[indice][1]
		oEmissor = textoDialogo[indice][2]
		aImagem = textoDialogo[indice][3]
	
end

-- metodo que retorna ao dialogo anterior e incremeta indice
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

	local caminhoArquivo = system.pathForFile("GameDesign/DesignGrafico/Dialogos/dialogoInicial"..sp..faseAtual..".txt")

	local arquivo = io.open(caminhoArquivo, "r")
	local savedData = arquivo:read("*a")

	io.close(arquivo)
	arquivo = nil

	aImagem = "GameDesign/DesignGrafico/Fases/TelaDialogo"..faseAtual.."/fundoDialogo00.jpg"

	oTexto = "..."
	oEmissor = "Personagem"
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


	if tipoDialogo==nil then
		caminhoArquivo = system.pathForFile("GameDesign/DesignGrafico/Dialogos/"..desafioAtual..sp..".txt")
	else
		caminhoArquivo = system.pathForFile("GameDesign/DesignGrafico/Dialogos/"..tipoDialogo..sp..".txt")
	end

	local arquivo = io.open(caminhoArquivo, "r")
	local savedData = arquivo:read("*a")

	io.close(arquivo)
	arquivo = nil

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

	aImagem = "GameDesign/DesignGrafico/Fases/TelaDialogo"..faseAtual.."/fundoDialogo.jpg"
	oTexto = ""
	oEmissor = ""
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
end