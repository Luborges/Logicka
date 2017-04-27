local sqlite3 = require ("sqlite3")
local storyboard = require ("storyboard")

local function main()
	storyboard.gotoScene("MenuInicial")
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