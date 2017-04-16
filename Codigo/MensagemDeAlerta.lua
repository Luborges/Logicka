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

-- Metodo que cria o botão fechar 
function criaBotaoSim()

 	botaoSim = widget.newButton{		
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoSim.png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoSim.png",
 		
 	--Posição do botão em x e y
 		x = display.contentWidth*.35,
 		y = display.contentHeight/1.35,

 	--Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10,
 	--função para o botão
 		onRelease = fechaAlerta
 	}
 	botaoSim:toFront()

end

-- Metodo que cria o botão fechar 
function criaBotaoNao()

 	botaoNao = widget.newButton{		
 	-- Adiciona imagem 
 		defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoNao.png",
 		overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoNao.png",
 		
 	--Posição do botão em x e y
 		x = display.contentWidth*.63,
 		y = display.contentHeight/1.35,

 	--Define tamanho do botão em pixels
 		width = display.contentWidth/10,
 		height = display.contentWidth/10,
 	--função para o botão
 		onRelease = retornarMenu
 	}
 	botaoNao:toFront()

end

function retornarMenu()
	fechaAlerta()
	caixaDeDialogo:removeSelf()
    fundoDaTela:removeSelf()

    for j=1, #selecionarGenero do
    	selecionarGenero[j]:removeSelf()
    end

	botaoVoltarTela:removeSelf()
	
	local storyboard = require ("storyboard")
	storyboard.gotoScene("MenuInicial")
end

-- Metodo que fecha caixa de dialogo
function fechaAlerta()	
	--matar objetos de tela e limpar memoria
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
		local mensagem = "Você não possui um\n Jovo Salvo!\nPor favor inicie um Novo Jogo." 
		criaCaixaDeAlerta()
		criaTexto(mensagem)	
		criaBotaoFechar()

		return true
end

-- Alerta de deleção
function MensagemDeAlerta:alertaApagarJogo()
		local mensagem = "Caso prossiga seu jogo atual será apagado.\nTem certeza que deseja continuar?" 
		criaCaixaDeAlerta()
		criaTexto(mensagem)	
		criaBotaoSim()
		criaBotaoNao()
		return true
end

-- Alerta não tocou em nada 
function MensagemDeAlerta:alertaSemColisao()
		local mensagem = "Nada de interessante aqui..." 
		criaCaixaDeAlerta()
		criaTexto(mensagem)	
		criaBotaoFechar()

		return true
end

-- Alerta não tocou em nada 
function MensagemDeAlerta:alertaColisaoSuperior()
		local mensagem = "Acho melhor irmos em outro lugar antes.\nDepois podemos voltar aqui" 
		criaCaixaDeAlerta()
		criaTexto(mensagem)	
		criaBotaoFechar()

		return true
end