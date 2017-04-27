require "sqlite3"
local path = system.pathForFile("Logicka.db", system.DocumentsDirectory)
local db = sqlite3.open(path)
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local transition = require("transition")
local timer = require("timer")
local textoDeCredito = {}
local Sons = require("Sons")
local sound = Sons:new{1,2,3}
for row in db:nrows("SELECT ds_idioma FROM t_Jogador") do
    ds_idioma = row.ds_idioma
end

TelaDeCredito = {}
function TelaDeCredito:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
-- Método que cria o texto
function TelaDeCredito:criaTexto(oTexto)
	-- deseha texto
	texto = display.newText(
		oTexto, 
		display.contentWidth/2,
		display.contentHeight*2.7,
		"arial", display.contentWidth/30)
	texto:setFillColor(255,255,255)
end
-- Método que move o texto
function TelaDeCredito:moveTexto(oIndice)
	sound:stopAll(sound)
	sound:add("GameDesign/Audio/Credito.mp3", "GameDesign/Audio/Credito")
	sound:setVolume(0.8)
	sound:play("GameDesign/Audio/Credito", {loops=-1})
	TelaDeCredito:criaTexto(textoDeCredito[oIndice])
	transition.to(texto, {time = 60000, y = display.contentHeight*-1.5,
	onComplete = function ()
			-- Retorna a splashScreen
			local storyboard = require ("storyboard")
			atualizarMovimento(false)
			objeto(objetosDeDesafio,false)
			storyboard.removeScene("Desafio")
			Runtime:removeEventListener("enterFrame", update)
			storyboard.removeAll()
			storyboard.gotoScene("SplashScreen")
			passosX=0
			passosY=0
			end})
end
-- Método que cria os creditos
function TelaDeCredito:creditos()
	local indice
	local text
	if ds_idioma=='pt-br' then
		text = "E assim, como o bom aventureiro \n"..
	 					"que precisará ser, \n"..
						"nosso heroi avançou nessa nova rota. \n"..
						"Certo de que encontraria respostas, \n"..
						"e um caminho que o levasse para casa. \n\n\n\n".. 	
						"A aventura continua... \n\n\n\n"..
						"            -- LOGICKA -- \n\n"..	
						"Equipe: \n\n"..
						"- Alessandra Mitie Kikuchi \n"..
						"- Daniel Coelho da Silva \n"..
						"- Eliel dos Santos Silva \n"..
						"- Lucas de Souza Mendes Borges \n"..
						"- Wesley Antonioli Rueda\n\n"..
						
						"Todos os áudios aqui apresentados\n"..
						"foram obtidos em: http://opengameart.org\n\n"..

						"Logicka é software Livre, participe e apoie em:\n"..
						"https://logickapgp.wordpress.com\n\n"..

						" Obrigado por jogar.\n"..
						" \n"
	elseif ds_idioma=='eng' then
		text =  "And so, as the good adventurer \n"..
	 					"who our hero needs to be, \n"..
						"Our hero has advanced on this new route. \n"..
						"Looking for answers, \n"..
						"And a path to home. \n\n\n\n".. 	
						"The adventure continues... \n\n\n\n"..
						"            -- LOGICKA -- \n\n"..	
						"Team: \n\n"..
						"- Alessandra Mitie Kikuchi \n"..
						"- Daniel Coelho da Silva \n"..
						"- Eliel dos Santos Silva \n"..
						"- Lucas de Souza Mendes Borges \n"..
						"- Wesley Antonioli Rueda\n\n"..
						
						"All audios presented here\n"..
						"were obtained in: http://opengameart.org\n\n"..

						"Logicka is open source, support in:\n"..
						"https://logickapgp.wordpress.com\n\n"..

						" Thanks for playing.\n"..
						" \n"
	end
	display.setDefault( "background", 0, 0, 0 )
	textoDeCredito[1] = text
	for indice = 1,table.getn(textoDeCredito),1 do
		timer.performWithDelay(500,TelaDeCredito:moveTexto(indice))
	end
end