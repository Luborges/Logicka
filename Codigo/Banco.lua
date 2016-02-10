--Banco
Banco = {}

local sqlite3 = require("sqlite3")

function Banco:new(o)

	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o

end

function Banco:criarBanco()

	local caminhoArquivo = system.pathForFile("Banco/Logicka.sql")

	local arquivo = io.open(caminhoArquivo, "r")
	local savedData = arquivo:read("*a")

	local caminhoBanco = system.pathForFile("Logicka.db", system.DocumentsDirectory)
	local db = sqlite3.open(caminhoBanco) 
	db:exec(savedData)

	io.close(arquivo)
	arquivo = nil

end

local function onSystemEvent( event )
   	if ( event.type == "applicationExit" ) then              
   	    db:close()
    end
end