-- AlterarIdioma

require "sqlite3"
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

function AlterarIdioma()
	for row in db:nrows("SELECT ds_idioma FROM t_Jogador") do
    	ds_idioma = row.ds_idioma
	end
	if ds_idioma == 'eng' then
		atualizarIdioma = [[UPDATE t_Operacao SET ds_variavel='Hit = Hit' WHERE id_operacao=1 or id_operacao=2;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Operacao SET ds_variavel='Take = Take' WHERE id_operacao=3 or id_operacao=4 or id_operacao=5 or id_operacao=6;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Operacao SET ds_variavel='Hit Rock = Hit Rock' WHERE id_operacao=7;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Operacao SET ds_variavel='Climb = Climb' WHERE id_operacao=8;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Decisao SET ds_variavel='Chosen Path', ds_texto='right' WHERE id_decisao=1;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Object' WHERE id_exibicao=1;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Hit' WHERE id_exibicao=2;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Release' WHERE id_exibicao=3;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Break' WHERE id_exibicao=4;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Coconut beats' WHERE id_exibicao=5;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Bite coconut' WHERE id_exibicao=6;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Hit' WHERE id_exibicao=7;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Go to right' WHERE id_exibicao=8;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Go to left' WHERE id_exibicao=9;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Take' WHERE id_exibicao=10 or id_exibicao=11;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Bite Rocks' WHERE id_exibicao=12;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Hit Rocks' WHERE id_exibicao=13;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Climb' WHERE id_exibicao=14;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Coconut beats = 0' WHERE id_entrada=1;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Coconut beats = 1' WHERE id_entrada=2;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Hit = 1' WHERE id_entrada=3;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Chosen Path = Right' WHERE id_entrada=4;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Chosen Path = Left' WHERE id_entrada=5;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Take = 1' WHERE id_entrada=6 or id_entrada=7;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Hit Rocks = 0' WHERE id_entrada=8;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Lose Rocks = 1' WHERE id_entrada=9;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Climb = 0' WHERE id_entrada=10;]]

	elseif ds_idioma == 'pt-br' then
		atualizarIdioma = [[UPDATE t_Operacao SET ds_variavel='Bater = Bater' WHERE id_operacao=1 or id_operacao=2;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Operacao SET ds_variavel='Pegar = Pegar' WHERE id_operacao=3 or id_operacao=4 or id_operacao=5 or id_operacao=6;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Operacao SET ds_variavel='Bater Pedra = Bater Pedra' WHERE id_operacao=7;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Operacao SET ds_variavel='Subir = Subir' WHERE id_operacao=8;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Decisao SET ds_variavel='Caminho Escolhido', ds_texto='direita' WHERE id_decisao=1;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Objeto' WHERE id_exibicao=1;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Bater' WHERE id_exibicao=2;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Soltar' WHERE id_exibicao=3;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Quebrar' WHERE id_exibicao=4;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Batidas no Coco' WHERE id_exibicao=5;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Morder Coco' WHERE id_exibicao=6;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Bater' WHERE id_exibicao=7;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Ir para a direita' WHERE id_exibicao=8;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Ir para a esquerda' WHERE id_exibicao=9;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Pegar' WHERE id_exibicao=10 or id_exibicao=11;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Morder Pedras' WHERE id_exibicao=12;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Bater Pedras' WHERE id_exibicao=13;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Exibicao SET ds_exibicao='Subir' WHERE id_exibicao=14;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Batidas no Coco = 0' WHERE id_entrada=1;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Batidas no Coco = 1' WHERE id_entrada=2;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Bater = 1' WHERE id_entrada=3;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Caminho Escolhido = Direita' WHERE id_entrada=4;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Caminho Escolhido = Esquerda' WHERE id_entrada=5;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Pegar = 1' WHERE id_entrada=6 or id_entrada=7;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Bater Pedras = 0' WHERE id_entrada=8;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Perder Pedras = 1' WHERE id_entrada=9;]]
		atualizarIdioma = atualizarIdioma.. [[UPDATE t_Entrada_Dados SET ds_entrada='Subir = 0' WHERE id_entrada=10;]]

	end
db:exec(atualizarIdioma)
end