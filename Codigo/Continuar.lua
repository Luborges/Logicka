--Novo Jogo

local storyboard = require ("storyboard")
require "sqlite3"
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path)
local Scene = storyboard.newScene()
local fasesFinalizadas = 0
local Sons = require( "Sons" )
local widget = require("widget")
-- Calcula largura e altura da tela
local largura = display.contentWidth
local altura = display.contentHeight
sound = Sons:new{1,2}
sound:add("GameDesign/Audio/Dialogo_inicial.mp3", "GameDesign/Audio/Dialogo_inicial")
sound:setVolume(0.4)
sound:play("GameDesign/Audio/Dialogo_inicial", {loops=-1} )
Scene:addEventListener("createScene", Scene)
Scene:addEventListener("enterScene", Scene)

selecionarFase = {}
-- Cria cena
function Scene:createScene(event)
  
  local screenGroup = self.view

--Fundo
--Utiliza imagem já existente como imagem de fundo
  fundoDaTela = display.newImage("GameDesign/DesignGrafico/NovoPersonagem/backgroundTelaSelecao.png")
  caixaDeDialogo = display.newGroup()

  fundoDaTela.height=altura
  fundoDaTela.width=largura
  fundoDaTela.x=largura*.5
  fundoDaTela.y=altura*.5

  larguraSelecaoFase=largura*.17
  alturaSelecaoFase=altura*.23

    for row in db:nrows("SELECT id_fase FROM t_Fase WHERE fg_dialogo='false'") do
      
      selecionarFase[row.id_fase] = display.newImage("GameDesign/DesignGrafico/Fases/TelaDialogo"..row.id_fase.."/fundoDialogo.jpg") 
      selecionarFase[row.id_fase].id=row.id_fase
      selecionarFase[row.id_fase].width=largura*.3
      selecionarFase[row.id_fase].height=altura*.4
      selecionarFase[row.id_fase].x=larguraSelecaoFase
      selecionarFase[row.id_fase].y=alturaSelecaoFase

      larguraSelecaoFase=larguraSelecaoFase+largura*.32

      if larguraSelecaoFase>largura then
        larguraSelecaoFase = largura*.17
        alturaSelecaoFase = alturaSelecaoFase+largura*.25
      end
      fasesFinalizadas=fasesFinalizadas+1
    end

      criaBotaoVoltarTela()

end

  --Cria função de toque
  local touchFunction = function(e)
  local opcao = e.target.id

    --Se o botão for precionado o movido
    if e.phase =="began" or e.phase == "moved" then
      --Para o audio da tela anterios caso o botao continuar seja apertado
      sound:remover("GameDesign/Audio/Menu_music")
      sound:stopAll(sound)
    
      --Para todos os sons atuais
      sound:stopAll(sound)

      if opcao == 2 then
        sound:add( "GameDesign/Audio/song"..opcao..".mp3", "GameDesign/Audio/song"..opcao)
        sound:setVolume( 0.4 )
        sound:play("GameDesign/Audio/song"..opcao, {loops=-1} )
        sound:add("GameDesign/Audio/Cav01.mp3", "GameDesign/Audio/Cav01")
        sound:setVolume(0.8)
        sound:play("GameDesign/Audio/Cav01",{loops=-1})
      else
        -- Adiciona o som que sera utilizado nas fases
        sound:add( "GameDesign/Audio/song"..opcao..".mp3", "GameDesign/Audio/song"..opcao)
        sound:setVolume( 0.4 )
        sound:play("GameDesign/Audio/song"..opcao, {loops=-1} )

      end

      atualizarFase = [[UPDATE t_Jogador SET id_fase=']]..opcao..[[', fg_carregar='true';]]
      db:exec(atualizarFase)
      atualizarPosicao = [[UPDATE t_Jogador SET ini_x=(SELECT ini_x FROM t_Fase WHERE id_fase=']]..opcao..[['), ini_y=(SELECT ini_y FROM t_Fase WHERE id_fase=']]..opcao..[[');]]
      db:exec(atualizarPosicao)

      for row in db:nrows("SELECT max(id_fase) as fase FROM t_Fase WHERE fg_dialogo='false';") do
        max_fase = row.fase
      end

      for row in db:nrows("SELECT id_fase FROM t_Jogador") do
        faseAtual = row.id_fase
      end

      for cont_fase=1,max_fase-1,1 do
        atualizarDesafio = [[UPDATE t_Puzzle SET fg_realizado='false' WHERE id_puzzle=(SELECT MAX(id_puzzle) FROM t_Puzzle WHERE id_fase=']]..cont_fase..[[');]]
        db:exec(atualizarDesafio)
      end

      atualizarDesafio2 = [[UPDATE t_Jogador SET id_puzzle=(SELECT MAX(id_puzzle) FROM t_Puzzle WHERE id_fase=']]..opcao..[[');]]
      db:exec(atualizarDesafio2)

      botaoVoltarTela:removeSelf()
      caixaDeDialogo:removeSelf()
      fundoDaTela:removeSelf()

      for j=1,fasesFinalizadas+1,1 do
        if selecionarFase[j]~=nil then
          selecionarFase[j]:removeSelf()
        end
      end
      storyboard.gotoScene("Fases")
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
  fundoDaTela:removeSelf()  
  botaoVoltarTela:removeSelf()
  caixaDeDialogo:removeSelf()
  fundoDaTela:removeSelf()

  for j=1,fasesFinalizadas+1,1 do
    if selecionarFase[j]~=nil then
      selecionarFase[j]:removeSelf()
    end
  end

  storyboard.gotoScene("MenuInicial")
  storyboard.removeScene("Fases")
  storyboard.removeScene("Continuar")
end


function Scene:enterScene(event)

-- Cria variavel
  local j=1

   --Toda vez que clicar, será criado um evento
  for j=1, fasesFinalizadas+1,1 do
    if selecionarFase[j]~=nil then
      -- Cria evento onde a cada toque será chamada a função touchFunction
      selecionarFase[j]:addEventListener("touch", touchFunction)
    end
  end
end

return Scene