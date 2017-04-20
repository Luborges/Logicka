local sqlite3 = require ("sqlite3")
local storyboard = require ("storyboard")
 
local function main()
	storyboard.gotoScene("SplashScreen")
end

local function controleDeErros(event)
	local erro = true
    if erro then
        print(event.errorMessage)
    end
    return erro
end

Runtime:addEventListener("unhandledError", controleDeErros)

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