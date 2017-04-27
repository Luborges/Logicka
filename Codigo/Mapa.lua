--Mapa
-- Meta Classe
Mapa = {}
-- Construtor da Clase
function Mapa:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
-- Metodo que irá receber os valores para executar o laço de repetição e devolverá o valor a cada rodagem
function Mapa:criarMapa (numeroDaFase)
	-- Calcula largura e altura da tela
	local largura = display.contentWidth
	local altura = display.contentHeight
	display.setDefault("minTextureFilter", "nearest")
	display.setDefault("magTextureFilter", "nearest")
	-- "hybrid" mostra os limites definidos, normal mostra a tela como sera mostrada no celular.
	--	physics.setDrawMode("hybrid")
	-- "normal" mostra a tela como ela sera exibida no celular
	physics.setDrawMode("normal")
	-- não esqueça de instanciar a Dusk ela que faz a mágica
	local dusk = require("Dusk.Dusk")
	dusk.setPreference("enableRotatedMapCulling", true)
	-- Nome do mapa que vai subir  
	local mapaAtual = "tela0"..numeroDaFase..".lua"
	-- Buscando o mapa informado na pasta "maps"
	map = dusk.buildMap("GameDesign/DesignGrafico/Fases/" .. mapaAtual)
	map.setTrackingLevel(0.5) -- "Fluideity" of the camera movement; numbers closer to 0 mean more fluidly and slowly (but 0 itself will disable the camera!)
	local mapX, mapY
	map:toBack()
	-- Define limites da imagem do mapa
	map.setCameraBounds( {xMin = display.contentWidth * 0.5, 
						xMax = map.data.width - display.contentWidth * 0.5, 
						yMin = display.contentHeight * 0.5, 
						yMax = map.data.height - display.contentHeight * 0.5 } )
	map.x=0
	map.y=0
	map.width=largura
	map.height=altura
	return map
end