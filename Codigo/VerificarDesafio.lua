-- Verificar Desafio

require ("sqlite3")
require ("TelaDeDialogo")		

-- Meta Classe
VerificarDesafio = {}
-- Calcula largura e altura da tela
largura = display.contentWidth
altura = display.contentHeight

local blocosParaTeste = {}
local blocosExecutando = {}
local teste=nil
local valorBloco=0
local aguardar=0
local laco=false
local contadorDeTeste=1
local contadorBloco=1
local contadorPonto=1
local testeSequencia=1
local contador=1
local resposta=0
local respostaNumerica
local valor
local resposta
local exibicao=false
local retornoDaVerificacao = {}

-- Variaveis referentes ao banco
local caminhoBanco = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(caminhoBanco) 

-- Construtor da Clase
function VerificarDesafio:new (o)

  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o

end

-- Função que ordena os blocos utilizados do mais alto até o mais baixo
function organizarBlocos(blocosP,desafioA,blocosM)

local blocosRecebidos = {}
blocosRecebidos = blocosP
i=1

	-- Laço que irá rodar enquanto houverem linhas na tabela
	for row in db:nrows("SELECT res_num, ds_resultado FROM t_Puzzle WHERE id_puzzle="..desafioA) do

		if row.res_num ==true then
		
			resposta=resposta+row.ds_resultado 
		
		else
			resposta=""..row.ds_resultado

		end

		respostaNumerica=row.res_num

	end

	--Organizando A partir do Eixo Y
	while contadorBloco<=#blocosRecebidos do

		while contador<=#blocosRecebidos do

			if blocosRecebidos[contadorBloco].y>blocosRecebidos[contador].y then

				menor=blocosRecebidos[contador]
				blocosRecebidos[contador]=nil
				blocosRecebidos[contador]=blocosRecebidos[contadorBloco]
				blocosRecebidos[contadorBloco]=nil				
				blocosRecebidos[contadorBloco]=menor

			end
				
			contador=contador+1
				
		end

		contadorBloco=contadorBloco+1
		contador=contadorBloco+1

	end

	contador=1
	contadorBloco=1

	return blocosRecebidos

end

function VerificarDesafio:verificar (blocosPosicionados,desafioAtual,numeroDeBlocos,blocosMovimentados)

	blocosParaTeste = organizarBlocos(blocosPosicionados,desafioAtual,blocosMovimentados)

	while contadorDeTeste<=#blocosParaTeste do

		if teste==nil then

			teste=nil
		
		elseif teste==true then

			contadorDeTeste=contadorDeTeste+1

		elseif teste==false then

			if contadorDeTeste==aguardar then
				if contadorDeTeste==#blocosParaTeste then
				
					break
				
				else
					
					contadorDeTeste=contadorDeTeste+1
					teste=nil

				end
			end
		end

		if blocosParaTeste[contadorDeTeste].tipo=="t_Entrada_Dados" then
			-- Laço que irá rodar enquanto houverem linhas na tabela
			for row in db:nrows("SELECT vlr_entrada, ds_var_name FROM "..blocosParaTeste[contadorDeTeste].tipo.." WHERE id_entrada="..blocosParaTeste[contadorDeTeste].id) do
			
				blocosExecutando[row.ds_var_name]=row.vlr_entrada

			end
	
		elseif blocosParaTeste[contadorDeTeste].tipo=="t_Exibicao" then
			-- Laço que irá rodar enquanto houverem linhas na tabela
			for row in db:nrows("SELECT ds_var_name FROM "..blocosParaTeste[contadorDeTeste].tipo.." WHERE id_exibicao="..blocosParaTeste[contadorDeTeste].id) do
				
					if blocosExecutando[row.ds_var_name]==nil then

						valorBloco=row.ds_var_name

					else

						if respostaNumerica=='true' then

							valorBloco=blocosExecutando[row.ds_var_name]+0

						else

							valorBloco=blocosExecutando[row.ds_var_name]

						end

					end

			end

				if (contadorDeTeste==#blocosParaTeste) then
	
					exibicao=true
	
				elseif (contadorDeTeste==#blocosParaTeste-1 and aguardar~=0) then

					exibicao=true

				else
	
					exibicao=false
	
				end

		elseif blocosParaTeste[contadorDeTeste].tipo=="t_Operacao" then

			for row in db:nrows("SELECT ds_var_name, ds_operacao, vlr_op_1 FROM "..blocosParaTeste[contadorDeTeste].tipo.." WHERE id_operacao="..blocosParaTeste[contadorDeTeste].id) do

				-- Chama arquivo BlocoOperacao
				require ("BlocoOperacao")
			
				opera=row.ds_operacao

				if blocosExecutando[row.ds_var_name]==nil then
				
					blocosExecutando[row.ds_var_name]=0
				
				end

					op = Operacao:new()

					blocosExecutando[row.ds_var_name] = op:criarOperacao(opera,blocosExecutando[row.ds_var_name],row.vlr_op_1)
				
			end

		elseif blocosParaTeste[contadorDeTeste].tipo=="t_Decisao" then

			for row in db:nrows("SELECT ds_decisao, ds_var_name, vlr_dec_1 FROM "..blocosParaTeste[contadorDeTeste].tipo.." WHERE id_decisao="..blocosParaTeste[contadorDeTeste].id) do

				require ("BlocoDecisao")
				
				comparacao=""
				comparacao=row.ds_decisao

				if blocosExecutando[row.ds_var_name]==nil then

					blocosExecutando[row.ds_var_name]=0

				end

				dc = Decisao:new()
				teste=dc:criarDecisao(comparacao, blocosExecutando[row.ds_var_name]+0,row.vlr_dec_1+0)

				aguardar=contadorDeTeste+2

			end

		elseif blocosParaTeste[contadorDeTeste].tipo=="t_Looping" then

			for row in db:nrows("SELECT vlr_inicial, vlr_final, vlr_incremento FROM "..blocosParaTeste[contadorDeTeste].tipo.." WHERE id_looping="..blocosParaTeste[contadorDeTeste].id) do

				vi=row.vlr_inicial+0
				valorInicial=row.vlr_inicial+0
				valorFinal=row.vlr_final+0
				incremento=row.vlr_incremento+0

			end

			laco=true

		end

		if laco==true then
		
			if valorInicial<=valorFinal then
			
				if valorInicial==vi then
			
					valorInicial=valorInicial+incremento
			
				else
			
					valorInicial=valorInicial+incremento
					contadorDeTeste=contadorDeTeste-1
		
				end
		
			elseif valorInicial>=valorFinal then
			
				laco=false
			
			end
		
		end

		contadorDeTeste=contadorDeTeste+1

	end

	if valorBloco==nil then 

		valorBloco=0;

	elseif respostaNumerica==true then

		resposta=resposta+0
		valorBloco=valorBloco+0

	else
		
		reposta=""..resposta
		valorBloco=""..valorBloco

	end

		-- Laço que irá rodar enquanto houverem linhas na tabela
		for row in db:nrows("SELECT fg_transicao FROM t_Puzzle WHERE id_puzzle ="..desafioAtual) do

			transicao = row.fg_transicao

		end

		local retorno = {}

			retorno = verificarResultado(valorBloco,resposta,exibicao,desafioAtual,transicao)

		valorBloco=nil
		resposta=nil
		exibicao=nil
		desafioAtual=nil
		aguardar=nil
		transicao=nil
		teste=nil

		return retorno

end

function verificarResultado(valorDoBloco, resultado, flagExibicao, desafioAt, tran)

	if tran=='false' then

		if valorDoBloco==resultado and flagExibicao==true then
	
			-- Laço que irá rodar enquanto houverem linhas na tabela
			for row in db:nrows("SELECT ds_puzzle FROM t_Puzzle WHERE id_puzzle ="..desafioAt) do

				dialogo = row.ds_puzzle

			end

			desafioPr=desafioAt+1
			local solucao=[[UPDATE t_Puzzle SET fg_realizado='true' WHERE id_puzzle =]]..desafioAt..[[;]]
			local desbloqueio=[[UPDATE t_Puzzle SET fg_liberado='true' WHERE id_puzzle =]]..desafioPr..[[;]]
			local avancarDesafio = [[UPDATE t_Jogador SET id_puzzle_anterior=id_puzzle, id_puzzle=]]..desafioPr..[[;]]


			db:exec(avancarDesafio)
			db:exec(solucao)
			db:exec(desbloqueio)

			for row in db:nrows("SELECT id_fase FROM t_Jogador WHERE id_jogador=1") do 
				faseAtual=row.id_fase 
			end

			for row in db:nrows("SELECT id_fase FROM t_Jogador WHERE id_jogador=1") do 
				faseAtual=row.id_fase 
			end

			retornoDaVerificacao = {}
			retornoDaVerificacao.proximoDialogo=dialogo.."Sucesso"
			retornoDaVerificacao.atualizacao=true
			retornoDaVerificacao.fase=faseAtual

		else

			-- Laço que irá rodar enquanto houverem linhas na tabela
			for row in db:nrows("SELECT ds_puzzle FROM t_Puzzle WHERE id_puzzle ="..desafioAt) do
				dialogo = row.ds_puzzle
			end

			for row in db:nrows("SELECT id_fase FROM t_Jogador WHERE id_jogador=1") do 
				faseAtual=row.id_fase 
			end

			retornoDaVerificacao = {}
			retornoDaVerificacao.proximoDialogo=dialogo.."Falha"
			retornoDaVerificacao.atualizacao=false
			retornoDaVerificacao.fase=faseAtual

		end

	else

		-- Laço que irá rodar enquanto houverem linhas na tabela
		for row in db:nrows("SELECT id_proxima_fase_V, id_proxima_fase_F, vlr_falso FROM t_Fase WHERE id_fase =(SELECT id_fase FROM t_Jogador WHERE id_jogador=1)") do

			proximaFaseV = row.id_proxima_fase_V
			proximaFaseF = row.id_proxima_fase_F
			condicaoFalsa = row.vlr_falso

		end

		-- Laço que irá rodar enquanto houverem linhas na tabela
		for row in db:nrows("SELECT ds_puzzle FROM t_Puzzle WHERE id_puzzle ="..desafioAt) do

			dialogo = row.ds_puzzle

		end

		if valorDoBloco==resultado and flagExibicao==true then

			local solucao=[[UPDATE t_Puzzle SET fg_realizado='true' WHERE id_puzzle = (SELECT max(id_puzzle) FROM t_Puzzle WHERE fg_realizado='false' AND fg_liberado='true'); ]]
			local desbloqueio=[[UPDATE t_Puzzle SET fg_liberado='true' WHERE id_puzzle = (SELECT min(id_puzzle) FROM t_Puzzle WHERE id_fase=]]..proximaFaseV..[[); ]]
			local proximaFase=[[UPDATE t_Jogador SET id_fase=]]..proximaFaseV..[[ WHERE id_jogador = 1; ]]

			db:exec(solucao)
			db:exec(desbloqueio)
			db:exec(proximaFase)

			retornoDaVerificacao = {}
			retornoDaVerificacao.proximoDialogo=dialogo.."Sucesso"
			retornoDaVerificacao.atualizacao=true
			retornoDaVerificacao.fase=proximaFaseV

			local avancarFase = [[UPDATE t_Jogador SET id_puzzle_anterior=id_puzzle, id_puzzle=(SELECT MIN(id_puzzle) FROM t_Puzzle WHERE id_fase=]]..retornoDaVerificacao.fase..[[) WHERE id_jogador = 1;]]

			db:exec(avancarFase)


		elseif valorDoBloco==condicaoFalsa and flagExibicao==true then

			local solucao=[[UPDATE t_Puzzle SET fg_realizado='true' WHERE id_puzzle =]]..desafioAt..[[; ]]
			local desbloqueio=[[UPDATE t_Puzzle SET fg_liberado='true' WHERE id_puzzle = (SELECT min(id_puzzle) FROM t_Puzzle WHERE id_fase=]]..proximaFaseF..[[); ]]
			local proximaFase=[[UPDATE t_Jogador SET id_fase=]]..proximaFaseF..[[ WHERE id_jogador = 1; ]]

			db:exec(solucao)
			db:exec(desbloqueio)
			db:exec(proximaFase)

			retornoDaVerificacao = {}
			retornoDaVerificacao.proximoDialogo=dialogo.."AlternativoSucesso"
			retornoDaVerificacao.atualizacao=true
			retornoDaVerificacao.fase=proximaFaseF

			local avancarFase = [[UPDATE t_Jogador SET id_puzzle_anterior=id_puzzle, id_puzzle=(SELECT MIN(id_puzzle) FROM t_Puzzle WHERE id_fase=]]..retornoDaVerificacao.fase..[[) WHERE id_jogador = 1;]]

			db:exec(avancarFase)

		else

			-- Laço que irá rodar enquanto houverem linhas na tabela
			for row in db:nrows("SELECT ds_puzzle FROM t_Puzzle WHERE id_puzzle ="..desafioAt) do
				dialogo = row.ds_puzzle
			end

			for row in db:nrows("SELECT id_fase FROM t_Jogador WHERE id_jogador=1") do 
				faseAtual=row.id_fase 
			end

			db:exec([[UPDATE t_Jogador SET id_puzzle_anterior=id_puzzle;]])
			retornoDaVerificacao = {}
			retornoDaVerificacao.proximoDialogo=dialogo.."Falha"
			retornoDaVerificacao.atualizacao=false
			retornoDaVerificacao.fase=faseAtual

		end

	end

	desafioAtual=nil
	numeroDeBlocos=nil
	desafioAtual=nil
	blocosExecutando={}
	blocosMovimentados=nil
	blocosPosicionados=nil
	contadorDeTeste=1
	faseAtual=nil

	return retornoDaVerificacao

end