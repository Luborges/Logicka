local widget = require("widget")
local texto
local caixaDeAlerta
local botaoFechar

-- classe
MensagemDeAlerta = {}

function MensagemDeAlerta:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
	
function criaCaixaDeAlerta()
	-- inserindo caixa de alerta
 	caixaDeAlerta = display.newImage("GameDesign/DesignGrafico/CaixaDialogo/caixaAlerta.png")
 	caixaDeAlerta.x = display.contentWidth/2
 	caixaDeAlerta.y = display.contentHeight/2
 	caixaDeAlerta.width = display.contentWidth/1.5
	caixaDeAlerta.height = display.contentHeight*0.5
	caixaDeAlerta:toFront() 

end

-- Metodo que cria o texto
function criaTexto(oTexto)
	-- caixa de texto
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
 		
 	--Posição do botão em x e y
 		x = display.contentWidth/1.35,
 		y = display.contentHeight/2.7,

 	--Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10,
 	--função para o botão
 		onRelease = fechaAlerta
 	}
 	botaoFechar:toFront()

end

-- Metodo que fecha caixa de dialogo
function fechaAlerta()	
	--matar objetos de tela e limpar memoria
		caixaDeAlerta:removeSelf()
		caixaDeAlerta = nil
		texto:removeSelf()
		texto = nil
		botaoFechar:removeSelf()
		botaoFechar = nil	
		mensagemSemColisao=false
		mensagemSemSave=false
end

-- Alerta save não encontrado 
function MensagemDeAlerta:alertaSemSaveGame()
		local mensagem = "Você não possui um\nSave Game!\nPor favor inicie um Novo Jogo." 
		criaCaixaDeAlerta()
		criaTexto(mensagem)	
		criaBotaoFechar()

		return true
end

-- Alerta não tocou em nada 
function MensagemDeAlerta:alertaSemColisao()
		local mensagem = "Nada de Interessante aqui..." 
		criaCaixaDeAlerta()
		criaTexto(mensagem)	
		criaBotaoFechar()

		return true
end