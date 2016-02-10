local storyboard = require("storyboard")
local scene  = storyboard.newScene()
local splashScreen
local w = display.contentWidth
local h = display.contentHeight
local fundo
local splashScreen

-- Criando Cena com Primeira imagem
function scene:createScene(event)
	desenhaFundo()
	grp = self.view
	splashScreen = display.newImageRect("GameDesign/SplashScreen/ifsp.png",w/2,h/2.9)
	splashScreen.x = w/2
	splashScreen.y = h/2
	grp:insert(splashScreen)	
	timer.performWithDelay(4000,desenhaPGP)
end

-- Altera Imagem
function desenhaPGP()
	splashScreen:removeSelf()
	splashScreen = nil		
	splashScreen = display.newImageRect("GameDesign/SplashScreen/pgp.png",w/2,h/4)
	splashScreen.x = w/2
	splashScreen.y = h/2
	grp:insert(splashScreen)
end

function desenhaFundo()
	fundo = display.newRect( w/2, h/2, w, h)
	fundo:setFillColor(1.1)
	fundo:toBack()
end

-- Troca cena para enu inicial
function scene:enterScene(event)
	local function toMenu()
		splashScreen:removeSelf()
		splashScreen = nil
		fundo:removeSelf()
		fundo = nil

		require ("Banco")
		b = Banco:new()
		b:criarBanco()

		local options = {
			
			effect = "crossFade",
			time = 2000,
		}
		storyboard.gotoScene("MenuInicial",options)
	end
	timer.performWithDelay(6000,toMenu)
end

-- Adicionando eventos
scene:addEventListener("createScene",scene)
scene:addEventListener("exitScene",scene)
scene:addEventListener("enterScene",scene)

return scene