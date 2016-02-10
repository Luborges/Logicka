require "sqlite3"
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local transition = require("transition")
local timer = require("timer")
local textoDeCredito = {}
local Sons = require("Sons")
local sound = Sons:new{1,2,3}
sound:stopAll(sound)
sound:add("GameDesign/Audio/Credito.mp3", "GameDesign/Audio/Credito")
sound:setVolume(0.8)
sound:play("GameDesign/Audio/Credito", {loops=-1})

TelaDeCredito = {}

function TelaDeCredito:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
-- metodo que cria o texto
function TelaDeCredito:criaTexto(oTexto)
	-- deseha texto
	texto = display.newText(
		oTexto, 
		display.contentWidth/2,
		display.contentHeight*2.7,
		"arial", display.contentWidth/30)
	texto:setFillColor(255,255,255)
end

-- metodo que move o texto
function TelaDeCredito:moveTexto(oIndice)

	TelaDeCredito:criaTexto(textoDeCredito[oIndice])
	transition.to(texto, {time = 50000, y = display.contentHeight*-1.5,
	onComplete = function ()

					-- Retorna a splashScreen
						local storyboard = require "storyboard"
						storyboard.gotoScene("SplashScreen")
						display.setDefault:removeSelf()
				 end})
end

-- metodo que cria os creditos
function TelaDeCredito:creditos()
	local indice

	display.setDefault( "background", 0, 0, 0 )
	textoDeCredito[1] = "E assim, como o bom aventureiro \n"..
	 					"que precisará ser, \n"..
						"nosso heroi avançou nessa nova rota. \n"..
						"Certo de que encontraria respostas, \n"..
						"e um caminho que o levasse para casa. \n\n\n\n".. 	
						"A aventura continua... \n\n\n\n"..
						"            -- LOGICKA -- \n\n"..	
						"Este projeto é parte integrante  \n"..
						"do Projeto Logicka. \n"..
						"Apresentado como requisito para \n"..
						"aprovação na disciplinade PGP \n"..
						"(Prática de Gerenciamento de Projetos), \n"..
						"do Instituto Federal de Ciências e \n"..
						"Tecnologia de São Paulo.  \n\n\n"..
						
						"Equipe: \n\n"..
						"- Alessandra Mitie Kikuchi \n"..
						"- Daniel Coelho da Silva \n"..
						"- Eliel dos Santos Silva \n"..
						"- Lucas de Souza Mendes Borges \n"..
						"- Wesley Antonioli Rueda\n\n"..
						
						"Orientadores: \n\n"..
						"- Profº Dr. José Braz de Araújo \n"..
						"- Profº Ivan Francolin Martinez \n\n\n\n\n\n\n\n\n"..
						" Obrigado por Jogar.\n"..
						" \n"

	for indice = 1,table.getn(textoDeCredito),1 do
		
		timer.performWithDelay(3000,TelaDeCredito:moveTexto(indice))
	end
end