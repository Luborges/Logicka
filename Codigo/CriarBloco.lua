--Criar Bloco

-- meta Classe
CriarBloco = {}

-- Calcula largura da tela
  largura = display.contentWidth
-- Calcula a altura da tela
  altura = display.contentHeight


-- construtor da Clase
function CriarBloco:new (o)

  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o

end

function CriarBloco:blocoOperacao (blocoEixoY, blocoEixoX, numeroDoBloco,desafioAtual)
  blocoFinalOperacao = display.newGroup();
  --local nameofrectangle = display.newRect(left-x-coordinate,top-y-coordinate,width,height)
  blocoOp=display.newImage("GameDesign/DesignGrafico/Desafio/Operacao.png")
  blocoOp.width=largura*.15
  blocoOp.height=altura/6

  require "sqlite3"
  --Variaveis referentes ao banco
  local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
  local db = sqlite3.open(path) 
  local blocoTexto=""

  for row in db:nrows("SELECT min(id_operacao) AS min FROM t_Operacao WHERE id_puzzle="..desafioAtual) do 

    blocoNovo=row.min

  end

  numeroDoBloco=numeroDoBloco-1+blocoNovo

  -- Laço que irá rodar enquanto houverem linhas na tabela
  for row in db:nrows("SELECT id_operacao, ds_variavel, ds_var_name, vlr_op_1, ds_operacao FROM t_Operacao WHERE id_puzzle="..desafioAtual.." AND id_operacao="..numeroDoBloco) do

    -- Exibe dados na tela
  blocoTextoOp = row.ds_variavel.." "..row.ds_operacao.." "..row.vlr_op_1
  id=row.id_operacao
  variavel=row.ds_var_name

  end

	options = 
	{
    --parent = textGroup,
    text = blocoTextoOp,     
    x = blocoEixoY,
    y = blocoEixoX,
    width = largura/7,     -- requerido para alinhamento em multiplas linhas
    font = native.systemFontBold,   
    fontSize = largura/45,
    align = "center"  -- parametro de alinhamento
	}

	textoOperacao = display.newText( options )
	textoOperacao:setFillColor( 0, 0, 0 )
  textoOperacao.x=blocoEixoX
  textoOperacao.y=blocoEixoY


	blocoFinalOperacao:insert(blocoOp)
	blocoFinalOperacao:insert(textoOperacao)
  blocoFinalOperacao.name=id.."operacao"
  blocoFinalOperacao.tipo="t_Operacao"
  blocoFinalOperacao.var=variavel
  blocoFinalOperacao.id=id

	return blocoFinalOperacao

end

function CriarBloco:blocoDecisao (blocoEixoY, blocoEixoX, numeroDoBloco,desafioAtual)
  blocoFinalDecisao = display.newGroup();
  --local nameofrectangle = display.newRect(left-x-coordinate,top-y-coordinate,width,height)
  blocoDe=display.newImage("GameDesign/DesignGrafico/Desafio/Decisao.png")--largura*.15,altura/7
  blocoDe.width=largura*.18
  blocoDe.height=altura/4.5

  require "sqlite3"
  --Variaveis referentes ao banco
  local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
  local db = sqlite3.open(path) 
  local blocoTexto=""

  for row in db:nrows("SELECT min(id_decisao) AS min FROM t_Decisao WHERE id_puzzle="..desafioAtual) do 

    blocoNovo=row.min

  end

  numeroDoBloco=numeroDoBloco-1+blocoNovo

  -- Laço que irá rodar enquanto houverem linhas na tabela
  for row in db:nrows("SELECT id_decisao, ds_variavel, ds_var_name, ds_texto, ds_decisao FROM t_Decisao WHERE id_puzzle="..desafioAtual.." AND id_decisao="..numeroDoBloco) do

    -- Exibe dados na tela
  blocoTextoDec = row.ds_variavel.." "..row.ds_decisao.." "..row.ds_texto
  id=row.id_decisao

  end


  options = 
  {
    --parent = textGroup,
    text = blocoTextoDec,     
    x = blocoEixoY,
    y = blocoEixoX,
    width = largura/7,     -- requerido para alinhamento em multiplas linhas
    font = native.systemFontBold,   
    fontSize = largura/51,
    align = "center"  -- parametro de alinhamento
  }

  textoDecisao = display.newText( options )
  textoDecisao:setFillColor( 0, 0, 0 )
  textoDecisao.x=blocoEixoX
  textoDecisao.y=blocoEixoY


  blocoFinalDecisao:insert(blocoDe)
  blocoFinalDecisao:insert(textoDecisao)
  blocoFinalDecisao.name=id.."decisao"
  blocoFinalDecisao.tipo="t_Decisao"
  blocoFinalDecisao.id=id

  return blocoFinalDecisao

end

function CriarBloco:blocoIteracao (blocoEixoY, blocoEixoX, numeroDoBloco,desafioAtual)
  blocoFinalIteracao = display.newGroup();
  --local nameofrectangle = display.newRect(left-x-coordinate,top-y-coordinate,width,height)
  blocoIt=display.newImage("GameDesign/DesignGrafico/Desafio/Iteracao.png")
  blocoIt.width=largura*.14
  blocoIt.height=altura/6

  require "sqlite3"
  --Variaveis referentes ao banco
  local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
  local db = sqlite3.open(path) 
  local blocoTexto=""

  for row in db:nrows("SELECT min(id_looping) AS min FROM t_Looping WHERE id_puzzle="..desafioAtual) do 

    blocoNovo=row.min

  end

  numeroDoBloco=numeroDoBloco-1+blocoNovo

  for row in db:nrows("SELECT ds_idioma FROM t_Jogador") do
    ds_idioma = row.ds_idioma
  end

  -- Laço que irá rodar enquanto houverem linhas na tabela
  for row in db:nrows("SELECT id_looping, vlr_inicial, vlr_final, vlr_incremento, ds_looping FROM t_Looping WHERE id_puzzle="..desafioAtual.." AND id_looping="..numeroDoBloco) do

  if ds_idioma =='pt-br' then
    -- Exibe dados na tela
    blocoTextoIt = "De: "..row.vlr_inicial.."\nAté: "..row.vlr_final.."\nPasso: "..row.vlr_incremento
  elseif ds_idioma =='eng' then
    blocoTextoIt = "For: "..row.vlr_inicial.."\nTo: "..row.vlr_final.."\nAdd: "..row.vlr_incremento
  end

  id=row.id_looping

  end

  options = 
  {
    --parent = textGroup,
    text = blocoTextoIt,     
    x = blocoEixoY,
    y = blocoEixoX,
    width = largura/7,     -- requerido para alinhamento em multiplas linhas
    font = native.systemFontBold,   
    fontSize = largura/55,
    align = "center"  -- parametro de alinhamento
  }

  textoIteracao = display.newText( options )
  textoIteracao:setFillColor( 0, 0, 0 )
  textoIteracao.x=blocoEixoX
  textoIteracao.y=blocoEixoY


  blocoFinalIteracao:insert(blocoIt)
  blocoFinalIteracao:insert(textoIteracao)
  blocoFinalIteracao.name=id.."iteracao"
  blocoFinalIteracao.tipo="t_Looping"
  blocoFinalIteracao.id=id


  return blocoFinalIteracao

end

function CriarBloco:blocoExibicao (blocoEixoY, blocoEixoX, numeroDoBloco,desafioAtual)
  blocoFinalExibicao = display.newGroup();
  --local nameofrectangle = display.newRect(left-x-coordinate,top-y-coordinate,width,height)
  blocoEx=display.newImage("GameDesign/DesignGrafico/Desafio/Exibicao.png")
  blocoEx.width=largura*.17
  blocoEx.height=altura/5.7

  require "sqlite3"
  --Variaveis referentes ao banco
  local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
  local db = sqlite3.open(path)                     

  for row in db:nrows("SELECT min(id_exibicao) AS min FROM t_Exibicao WHERE id_puzzle="..desafioAtual) do 

    blocoNovo=row.min

  end

  numeroDoBloco=numeroDoBloco-1+blocoNovo

  local blocoTexto=""
  -- Laço que irá rodar enquanto houverem linhas na tabela
  for row in db:nrows("SELECT ds_exibicao, id_exibicao FROM t_Exibicao WHERE id_puzzle="..desafioAtual.." AND id_exibicao="..numeroDoBloco) do

    -- Exibe dados na tela
  blocoTextoEx = row.ds_exibicao
  id=row.id_exibicao

  end

  options = 
  {
    --parent = textGroup,
    text = blocoTextoEx,    
    x = blocoEixoY,
    y = blocoEixoX,
    width = largura/7,     -- requerido para alinhamento em multiplas linhas
    font = native.systemFontBold,   
    fontSize = largura/46,
    align = "right"  -- parametro de alinhamento
 }

  textoExibicao = display.newText( options )
  textoExibicao:setFillColor( 0, 0, 0 )
  textoExibicao.x=blocoEixoX
  textoExibicao.y=blocoEixoY


  blocoFinalExibicao:insert(blocoEx)
  blocoFinalExibicao:insert(textoExibicao)
  blocoFinalExibicao.name=id.."exibicao"
  blocoFinalExibicao.tipo="t_Exibicao"
  blocoFinalExibicao.var=variavel
  blocoFinalExibicao.id=id


  return blocoFinalExibicao

end

function CriarBloco:blocoEntrada (blocoEixoY, blocoEixoX, numeroDoBloco,desafioAtual)
  
  blocoFinalEntrada = display.newGroup();

  blocoEn=display.newImage("GameDesign/DesignGrafico/Desafio/EntradaDados.png")
  blocoEn.width=largura*.16
  blocoEn.height=altura/5.5

  require "sqlite3"
  --Variaveis referentes ao banco
  local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
  local db = sqlite3.open(path) 
  local blocoTexto=""

  for row in db:nrows("SELECT min(id_entrada) AS min FROM t_Entrada_Dados WHERE id_puzzle="..desafioAtual) do 

    blocoNovo=row.min

  end

  numeroDoBloco=numeroDoBloco-1+blocoNovo

  -- Laço que irá rodar enquanto houverem linhas na tabela
  for row in db:nrows("SELECT id_entrada, ds_entrada FROM t_Entrada_Dados WHERE id_puzzle="..desafioAtual.." AND id_entrada="..numeroDoBloco) do

    -- Exibe dados na tela
  blocoTextoEn = row.ds_entrada
  id=row.id_entrada
  end

  options = 
  {
    text = blocoTextoEn,    
    x = blocoEixoY,
    y = blocoEixoX,
    width = largura/7,     -- requerido para alinhamento em multiplas linhas
    font = native.systemFontBold,   
    fontSize = largura/50,
    align = "center"  -- parametro de alinhamento
 }

  textoEntrada = display.newText( options )
  textoEntrada:setFillColor( 0, 0, 0 )
  textoEntrada.x=blocoEixoX
  textoEntrada.y=blocoEixoY


  blocoFinalEntrada:insert(blocoEn)
  blocoFinalEntrada:insert(textoEntrada)
  blocoFinalEntrada.name=id.."entrada"
  blocoFinalEntrada.tipo="t_Entrada_Dados"
  blocoFinalEntrada.var=variavel
  blocoFinalEntrada.id=id


  return blocoFinalEntrada

end