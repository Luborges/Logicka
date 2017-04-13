local sqlite3 = require ("sqlite3")
local log = require("Log")
local storyboard = require ("storyboard")

local function main()
	
	local path = system.pathForFile("sample.db", system.DocumentsDirectory)
	db = sqlite3.open(path)

	log:set(db, "logickapgp@gmail.com")
	
	log:log("Advanced logging module is now ready", "Comment on: http://forums.coronalabs.com/topic/50004-corona-advanced-logging/")

	storyboard.gotoScene("MenuInicial")

end

main();

-- Chama classe de Testes
-- require("TesteUnitario")

-- testaValoresDeOperacao()
-- testaValoresDeDecisao()
-- testaVerificacaoDeDesafio()
-- testaMapaExistente()
-- testaGenero()
-- testaLaco()
-- testaBuscaFase()
-- testaBuscaDesafio()