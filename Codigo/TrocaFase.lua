--Troca de Fase
-- meta Classe
TrocaFase = {}

-- Construtor da Clase
function TrocaFase:new (o)

  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o

end
	
-- Metodo que irá receber os valores para executar o laço de repetição e devolverá o valor a cada rodagem
function TrocaFase:trocaDeFase (fase)

	storyboard=nil
	
	local storyboard = require "storyboard"
	storyboard.gotoScene(fase)

	fase=nil

end