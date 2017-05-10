local widget = require("widget")
local texto
local caixaDeAlerta
local botaoFechar
require "sqlite3"
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path)
for row in db:nrows("SELECT ds_idioma FROM t_Jogador") do
    ds_idioma = row.ds_idioma
end
-- Classe
MensagemDeAlerta = {}
function MensagemDeAlerta:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
	
function criaCaixaDeAlerta()
	-- Inserindo caixa de alerta
 	caixaDeAlerta = display.newImage("GameDesign/DesignGrafico/CaixaDialogo/caixaAlerta.png")
 	caixaDeAlerta.x = display.contentWidth/2
 	caixaDeAlerta.y = display.contentHeight/2
 	caixaDeAlerta.width = display.contentWidth/1.5
	caixaDeAlerta.height = display.contentHeight*0.5
	caixaDeAlerta:toFront() 
end

-- Metodo que cria o texto
function criaTexto(oTexto)
	-- Caixa de texto
		texto = display.newText(
		oTexto, 
		display.contentWidth/2,
		display.contentHeight/1.9,
		display.contentWidth/2.1, 
		display.contentHeight/3.5, 
		"arial", display.contentWidth/29)
		texto:setFillColor(1,1,1)
		texto:toFront()
end

-- Metodo que cria o botão fechar 
function criaBotaoFechar()
 	botaoFechar = widget.newButton{		
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoFechar.png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoFecharPressisonado.png",
 	-- Posição do botão em x e y
 		x = display.contentWidth/1.35,
 		y = display.contentHeight/2.7,
 	-- Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10,
 	-- Função para o botão
 		onRelease = fechaAlerta
 	}
 	botaoFechar:toFront()
end

-- Metodo que cria o botão fechar 
function criaBotaoSim()
 	botaoSim = widget.newButton{		
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoSim"..ds_idioma..".png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoSim"..ds_idioma..".png",
 	-- Posição do botão em x e y
 		x = display.contentWidth*.35,
 		y = display.contentHeight/1.35,
 	-- Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10,
 	-- Função para o botão
 		onRelease = fechaAlerta
 	}
 	botaoSim:toFront()
end

-- Metodo que cria o botão fechar 
function criaBotaoNao()
 	botaoNao = widget.newButton{		
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoNao"..ds_idioma..".png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoNao"..ds_idioma..".png",
 	-- Posição do botão em x e y
 		x = display.contentWidth*.63,
 		y = display.contentHeight/1.35,
 	-- Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10,
 	-- Função para o botão
 		onRelease = retornarMenu
 	}
 	botaoNao:toFront()
end

function retornarMenu()
	fechaAlerta()
	caixaDeDialogo:removeSelf()
	botaoVoltarTela:removeSelf()
	voltarMenu()
end

-- Metodo que fecha caixa de dialogo
function fechaAlerta()	
	-- Matar objetos de tela e limpar memoria
	caixaDeAlerta:removeSelf()
	caixaDeAlerta = nil
	texto:removeSelf()
	texto = nil
	if botaoFechar ~=nil then botaoFechar:removeSelf() end
	botaoFechar = nil	
	mensagemSemColisao=false
	mensagemSemSave=false
	if botaoSim ~=nil then botaoSim:removeSelf() end
	botaoSim=nil
	if botaoNao ~=nil then botaoNao:removeSelf() end
	botaoNao=nil
end

-- Alerta save não encontrado 
function MensagemDeAlerta:alertaSemSaveGame()
	local mensagem
	if ds_idioma=='pt-br' then
		mensagem = "Você não possui um\n Jovo Salvo!\nPor favor inicie um Novo Jogo." 
	elseif ds_idioma=='eng' then
		mensagem = "You don't have a \n Saved Game !\n Please, start a New Game."
	end
	criaCaixaDeAlerta()
	criaTexto(mensagem)	
	criaBotaoFechar()
	return true
end

-- Alerta de deleção
function MensagemDeAlerta:alertaApagarJogo()
	local mensagem
	if ds_idioma=='pt-br' then
		mensagem = "Caso prossiga seu jogo atual será apagado.\nTem certeza que deseja continuar?"
	elseif ds_idioma=='eng' then
		mensagem = "If you continue your current game will be deleted.\nAre you sure you want to continue?"
	end
	criaCaixaDeAlerta()
	criaTexto(mensagem)	
	criaBotaoSim()
	criaBotaoNao()
	return true
end

-- Alerta não tocou em nada 
function MensagemDeAlerta:alertaSemColisao()
	local mensagem
	if ds_idioma=='pt-br' then
		mensagem = "Nada de interessante aqui..." 
	elseif ds_idioma=='eng' then
		mensagem = "Nothing interesting here..."
	end
	criaCaixaDeAlerta()
	criaTexto(mensagem)	
	criaBotaoFechar()
	return true
end

-- Alerta não tocou em nada 
function MensagemDeAlerta:alertaColisaoSuperior()
	local mensagem
	if ds_idioma=='pt-br' then
		mensagem = "Acho melhor irmos em outro lugar antes.\nDepois podemos voltar aqui" 
	elseif ds_idioma=='eng' then
		mensagem = "I think it's better for we to go in another place before.\n Later we can come back here"
	end
	criaCaixaDeAlerta()
	criaTexto(mensagem)	
	criaBotaoFechar()
	return true
end