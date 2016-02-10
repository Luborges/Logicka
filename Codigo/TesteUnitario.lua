-- Teste da classe FactoryOperacao
function testaValoresDeOperacao()

	require ("BlocoOperacao")
	
	-- Seleciona a factory baseada no tipo de operação.
	op = Operacao:new()

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo somados
	assert(op:criarOperacao('+',5,5)==10,"Os valores não estão sendo somados")

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo subtraidos
	assert(op:criarOperacao(5,5)==0,"Os valores não estão sendo subtraidos")

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo multiplicados
	assert(op:criarOperacao(5,5)==25,"Os valores não estão sendo multiplicados")

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo dividos
	assert(op:criarOperacao(5,5)==1,"Os valores não estão sendo dividos")

end

-- Teste da classe FactoryOperacao
function testaValoresDeDecisao()
	
	require ("BlocoDecisao")

	dc = Decisao:new()

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo somados
	assert(dc:criarDecisao('>',6,5)==true, "Os valores não estão sendo comparados corretamente na comparacao de 'valor1 > valor2'")

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo somados
	assert(dc:criarDecisao('<',16,20)==true, "Os valores não estão sendo comparados corretamente na comparacao de 'valor1 < valor2'")

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo somados
	assert(dc:criarDecisao('>=',16,16)==true, "Os valores não estão sendo comparados corretamente na comparacao de 'valor1 >= valor2'")

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo somados
	assert(dc:criarDecisao('<=',40,50)==true, "Os valores não estão sendo comparados corretamente na comparacao de 'valor1 <= valor2'")

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo somados
	assert(dc:criarDecisao('==',100,100)==true, "Os valores não estão sendo comparados corretamente na comparacao de 'valor1 == valor2'")

	-- Verifica se os valores que estão indo para a FactoryOperacao estão sendo somados
	assert(dc:criarDecisao('~=',1000,10)==true, "Os valores não estão sendo comparados corretamente na comparacao de 'valor1 ~= valor2'")

end

function testaVerificacaoDeDesafio()

	require ("VerificarDesafio")

	assert(verificarResultado(1,1,true).atualizacao==true, "A verificação está errada")

end

function testaLaco()

	vInicial=1
	vFinal=10
	vIncremento=2

	for cont=vInicial,vFinal,vIncremento do

		require("BlocoLaco")
		bl = BlocoLaco:new()
		assert(bl:laco(vInicial,vFinal,vIncremento)==vInicial+vIncremento,"Laço não está rodando")

  end
  
end

function testaMapaExistente()

	require ("Mapa")

	mp = Mapa:new()
	assert(mp:criarMapa(1)~=nil, "Não existe esse mapa")

end

function testaGenero()

	require ("TelaDeDialogo")

	assert(buscaSexoPersonagem()=="M" or buscaSexoPersonagem()=="F", "O genero do personagem não existe")

end

function testaBuscaFase()

	require ("sqlite3")
	require ("TelaDeDialogo")
	
	-- caminho para o banco
	local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
	local db = sqlite3.open(path) 

	for row in db:nrows("SELECT MAX(id_fase) AS max FROM t_Puzzle") do 
		ultimaFase = row.max
	end

	assert(buscaFaseAtual()~=nil and buscaFaseAtual()<=ultimaFase,"O usuário não está presente em nenhuma fase")

end

function testaBuscaDesafio()
	require ("TelaDeDialogo")

	-- caminho para o banco
	local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
	local db = sqlite3.open(path) 

	assert(buscaDesafioAtual()~=nil,"O usuário não está presente em nenhum desafio")

	end