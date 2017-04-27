-- Meta Classe
Operacao = {}
-- Construtor da Clase
function Operacao:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Operacao:criarOperacao(operacao, valorUmOperacao, valorDoisOperacao)
    if operacao=="+" then
        return valorUmOperacao+valorDoisOperacao
   
    elseif operacao=="-" then
        return valorUmOperacao-valorDoisOperacao

    elseif operacao=="*" then
        return valorUmOperacao*valorDoisOperacao

    elseif operacao=="/" then
        return valorUmOperacao/valorDoisOperacao
    end
end