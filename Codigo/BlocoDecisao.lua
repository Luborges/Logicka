-- Meta Classe
Decisao = {}
-- Construtor da Clase
function Decisao:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Decisao:criarDecisao(decisao, valorUmDecisao, valorDoisDecisao)
  if decisao=="==" then
    if valorUmDecisao==valorDoisDecisao then
      return true
    else
      return false
    end

  elseif decisao=="~=" then
    if valorUmDecisao~=valorDoisDecisao then
      return true
    else
      return false
    end

  elseif decisao==">" then
    if valorUmDecisao>valorDoisDecisao then
      return true
    else
      return false
    end

  elseif decisao=="<" then
    if valorUmDecisao<valorDoisDecisao then
      return true
    else
      return false
    end

  elseif decisao==">=" then
    if valorUmDecisao>=valorDoisDecisao then
      return true
    else
      return false
    end

    elseif decisao=="<=" then
      if valorUmDecisao<=valorDoisDecisao then
        return true
      else
        return false
      end
    end
end