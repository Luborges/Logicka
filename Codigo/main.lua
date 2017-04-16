local sqlite3 = require ("sqlite3")
local storyboard = require ("storyboard")

local function main()
 
	storyboard.gotoScene("SplashScreen")

end

local function myUnhandledErrorListener( event )
 
    local iHandledTheError = true
 
    if iHandledTheError then
        print(event.errorMessage)
    else
        print(event.errorMessage)
    end
    
    return iHandledTheError
end

Runtime:addEventListener("unhandledError", myUnhandledErrorListener)

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