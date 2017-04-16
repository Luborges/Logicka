--Novo Jogo

local storyboard = require ("storyboard")
local Scene = storyboard.newScene()
Scene:addEventListener("createScene", Scene)
Scene:addEventListener("enterScene", Scene)
local widget = require("widget")

-- Calcula largura e altura da tela
local largura = display.contentWidth
local altura = display.contentHeight

require ("sqlite3")
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path) 

--Cria cena
function Scene:createScene(event)
  
  local screenGroup = self.view

--Fundo
--Utiliza imagem já existente como imagem de fundo
  fundoDaTela = display.newImage("GameDesign/DesignGrafico/NovoPersonagem/backgroundTelaSelecao.png")
  screenGroup:insert(fundoDaTela)
  caixaDeDialogo = display.newGroup()

  fundoDaTela.height=altura
  fundoDaTela.width=largura
  fundoDaTela.x=largura*.5
  fundoDaTela.y=altura*.5

  larguraBloco1=largura*.3
  alturaBloco1=altura*.3

  larguraBloco2=largura*.7
  alturaBloco2=altura*.3  
  
  local caixa = display.newImage("GameDesign/DesignGrafico/CaixaDialogo/caixaDeDialogo.png")
  caixa.width=largura*1.1
  caixa.height=altura*.5

  caixaDeDialogoOp = 
  {
    text = "Você acordou em uma ilha sem certeza de onde está, com certa dificuldade você tenta se lembrar se você é um garoto ou uma garota!",     
    x = -largura/100,
    y = caixaDeDialogo.height,
    width = largura/1.066, -- Para alinhar texto com mais de uma linha
    font = native.systemFontBold,   
    fontSize = largura/32,
    align = "left" -- Alinhamento a esquerda
  }

  textoCaixaDialogo = display.newText( caixaDeDialogoOp )
  textoCaixaDialogo:setFillColor( 0, 0, 0 )

  caixaDeDialogo:insert(caixa)
  caixaDeDialogo:insert(textoCaixaDialogo)

  caixaDeDialogo.x=largura*.5
  caixaDeDialogo.y=altura*.758

  selecionarGenero = {}

  --Botão de Novo Jogo
  selecionarGenero[1] = display.newImage("GameDesign/DesignGrafico/NovoPersonagem/menino.png")
  --Tamanho do botão
  selecionarGenero[1].width=largura*.32
  selecionarGenero[1].height=altura*.55 
  selecionarGenero[1].x=largura*.27
  selecionarGenero[1].y=altura*.3
  selecionarGenero[1].myName="Masculino"

  --Botão de Continuar Jogo
  selecionarGenero[2] = display.newImage("GameDesign/DesignGrafico/NovoPersonagem/menina.png")
  --Tamanho do botão
  selecionarGenero[2].width=largura*.32
  selecionarGenero[2].height=altura*.55
  selecionarGenero[2].x=largura*.72
  selecionarGenero[2].y=altura*.3
  selecionarGenero[2].myName="Feminino"
  
  criaBotaoVoltarTela()

  for row in db:nrows("SELECT id_puzzle FROM t_Jogador") do
      id_puzzle=row.id_puzzle
  end

  if id_puzzle ~=nil then
    if id_puzzle > 1 then
      require ("MensagemDeAlerta")
      ma = MensagemDeAlerta:new()
      ma:alertaApagarJogo() 
    end
  end

end

-- Metodo que cria o botão fechar 
function criaBotaoVoltarTela()

  botaoVoltarTela = widget.newButton{   
  -- Adiciona imagem 
    defaultFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoVoltarTela.png",
    overFile = "GameDesign/DesignGrafico/CaixaDialogo/botaoVoltarTela.png",
    
  --Posição do botão em x e y
    x = display.contentWidth/1.09,
    y = display.contentHeight/9.9,

  --Define tamanho do botão em pixels
    width = display.contentWidth/7,
    height = display.contentWidth/11,
  --função para o botão
    onRelease = voltarMenu
  }
  botaoVoltarTela:toFront()

end

function voltarMenu()
  botaoVoltarTela:removeSelf()
  caixaDeDialogo:removeSelf()
  fundoDaTela:removeSelf()
  storyboard.removeAll()

  for j=1, #selecionarGenero do
  
  selecionarGenero[j]:removeSelf()
  
  end
  storyboard.gotoScene("MenuInicial")
  storyboard.removeScene("NovoJogo")

end

--Cria função de toque
local touchFunction = function(e)
  local opcao = e.target.myName

  --Se o botão for precionado o movido
  if e.phase =="began" or e.phase == "moved" then  

    -- Se o botão Novo Jogo for tocado
    if opcao=="Masculino" then

      atualizarTabela = [[INSERT OR REPLACE INTO t_Jogador VALUES (1, 1, 1, 1, 0, 'false', 1248, 958)]]
      db:exec(atualizarTabela)
      atualizarDesafio = [[UPDATE t_Puzzle SET fg_realizado='false', fg_liberado='false']]
      db:exec(atualizarDesafio)

    elseif opcao=="Feminino" then

      atualizarTabela = [[INSERT OR REPLACE INTO t_Jogador VALUES (1, 2, 1, 1, 0, 'false', 1248, 958)]] 
      db:exec(atualizarTabela)
      atualizarDesafio = [[UPDATE t_Puzzle SET fg_realizado='false', fg_liberado='false']]
      db:exec(atualizarDesafio)

   end

      liberarDesafio = [[UPDATE t_Puzzle SET fg_liberado='true' WHERE id_puzzle=1]]
      db:exec(liberarDesafio)
      dialogosIniciais = [[UPDATE t_Fase SET fg_dialogo='true']]
      db:exec(dialogosIniciais)

  end

  botaoVoltarTela:removeSelf()
  caixaDeDialogo:removeSelf()
  fundoDaTela:removeSelf()
  storyboard.removeAll()

  for j=1, #selecionarGenero do
  
  selecionarGenero[j]:removeSelf()
  
  end
    storyboard.gotoScene("Fases")
    storyboard.removeScene("NovoJogo")
end

function Scene:enterScene(event)

-- Cria variavel
  local j=1

  --Toda vez que clicar, será criado um evento
  for j=1, #selecionarGenero do
  
  --Cria evento onde a cada toque será chamada a função touchFunction
    selecionarGenero[j]:addEventListener("touch", touchFunction)
  
  end

end

function Scene:exitScene(event)
    storyboard.removeScene("NovoJogo")
    storyboard.removeAll()

end

return Scene