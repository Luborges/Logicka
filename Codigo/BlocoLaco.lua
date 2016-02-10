-- Meta Classe
BlocoLaco = {}

-- Construtor da Clase
function BlocoLaco:new (o)

  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o

end

-- Metodo que irá receber os valores para executar o laço de repetição e devolverá o valor a cada rodagem
function BlocoLaco:laco (valorInicial, valorFinal, incremento)

  for cont=valorInicial,valorFinal,incremento do
  return valorInicial+incremento

  end
  
end