--Novo Jogo

local storyboard = require ("storyboard")
require "sqlite3"
local Scene = storyboard.newScene()
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path)
local fasesFinalizadas = 0
  Scene:addEventListener("createScene", Scene)
  Scene:addEventListener("enterScene", Scene)

-- Calcula largura e altura da tela
  local largura = display.contentWidth
  local altura = display.contentHeight
  selecionarFase = {}
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

end

  --Cria função de toque
  local touchFunction = function(e)
  local opcao = e.target.id

    --Se o botão for precionado o movido
    if e.phase =="began" or e.phase == "moved" then

      atualizarFase = [[UPDATE t_Jogador SET id_fase=']]..opcao..[[';]]
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

      storyboard.gotoScene("Fases")
      caixaDeDialogo:removeSelf()
      fundoDaTela:removeSelf()

      for j=1,fasesFinalizadas+1,1 do
        if selecionarFase[j]~=nil then
          selecionarFase[j]:removeSelf()
        end
      end
    end
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
--[[
      --Inicia o audio do click

      require "sqlite3"

      local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)

      local db = sqlite3.open(path) 
    
        for row in db:nrows("SELECT id_fase, id_puzzle FROM t_Jogador WHERE id_jogador=1") do
      
        -- Exibe dados na tela
          id_fase = row.id_fase
        
      sound:add( "GameDesign/Audio/song"..row.id_fase..".mp3", "GameDesign/Audio/song"..row.id_fase)
      sound:setVolume( 0.4 )
      sound:play("GameDesign/Audio/song"..row.id_fase, {loops=-1} )

        end
      
        if id_fase == nil or id_fase == 0 then

          if mensagemSemSave == false then

            require ("MensagemDeAlerta")
          ma = MensagemDeAlerta:new()
          mensagemSemSave = ma:alertaSemSaveGame()

        end

      else

        --Para o audio da tela anterios caso o botao continuar seja apertado
        sound:remover("GameDesign/Audio/Menu_music")

          storyboard.loadScene("Fases")

          storyboard.gotoScene("Fases", "crossFade", 200)
        
        end
]]--

return Scene