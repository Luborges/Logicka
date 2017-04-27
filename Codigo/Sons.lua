-- Controlador de sons
local Sons = {}
local Sons_mt = { __index = Sons }
-- Inicia um novo objeto Sons
function Sons: new (channels)
	local self = {}
	setmetatable( self, Sons_mt)
	self.sounds = {}
	self.volume = 1
	self.enabled = true
	self.channels = channels
	return self
end
-- Adiciona um arquivo de audio ao projeto
-- @parametro pathOrHandle e o diretorio do arquivo de audio ou o audio pre-carregado.
-- @parametro nome é o nome do audio.
-- @parametro baseDirectory  O diretorio base do audio. Opcional, padrão para system.ResourceDirectory
-- @parametro lazyLoading Se for setado como true, o audio só sera carregado quando for tocado pela primeira vez, seu default é o false.
function Sons:add( pathOrHandle, nome, baseDirectory, lazyLoading )
	self.sounds = self.sounds or {}
	self.sounds [nome] = {}
	if type (pathOrHandle) == "string" then
		if lazyLoading then
			self.sounds [nome].baseDirectory = baseDirectory or system.ResourceDirectory
		else
			pathOrHandle = audio.loadSound( pathOrHandle, baseDirectory or system.ResourceDirectory )
		end
	end
	self.sounds[ nome ].handle = pathOrHandle
end
-- Remove um audio do projeto e o destroi.
-- @parametro nome é o nome do audio.
function Sons:remover (nome)
	if not self.sounds or not self.sounds[ nome ] then
		return
	end

	if self.sounds[ nome ].channel then
		audio.stop( self.sounds[ nome ].channel )
	end

	if self.sounds[ nome ].handle then
		audio.dispose( self.sounds[ nome ].handle )
	end
	self.sounds[ nome ] = nil
end
-- Toca um som pre-carregado
-- @parametro nome é o nome do audio.
-- @parametro opcoes são as opcoes do audio, é opcional
function Sons:play (nome, opcoes)
	if not self.sounds or not self.sounds[ nome ] then
		return
	end
	
	if type( self.sounds[ nome ].handle ) == "string" then
		self.sounds[ nome ].handle = audio.loadSound( self.sounds[ nome ].handle, self.sounds[ nome ].baseDirectory )
	end
	
	if not self.enabled then
		return
	end
		
	local opcoes = opcoes or {}
	opcoes.channel = self:findFreeChannel()
	if opcoes.channel then
		audio.setVolume( self.volume, { channel = opcoes.channel } )
		self.sounds[nome].channel = audio.play( self.sounds[nome].handle, opcoes )
	end
end
-- Seta o volume dos audios.
-- @parametro volume é o novo volume.
function Sons:setVolume(volume)
	self.volume = volume
	if self.volume > 1 then
		self.volume = 1
	elseif self.volume < 0 then
		self.volume = 0
	end
	for i = 1, #self.channels, 1 do
		audio.setVolume( self.volume, { channel = self.channels[ i ] } )
	end
end
-- Acha um canal livre
-- @retorna o numero do canal. Vazio se não achar nenhum
function Sons:findFreeChannel()
	if self.channels then
		for i = 1, #self.channels, 1 do
			if not audio.isChannelActive( self.channels[ i ] ) then
				return self.channels[ i ]
			end
		end
	else
		return audio.findFreeChannel()
	end
end
-- Remove todos os sons e os destroi
function Sons:removeAll()
	self.stopAll()
	for k, v in pairs( self.sounds ) do
		if v then
			audio.dispose( v.handle )
		end
		v.handle = nil
	end
	self.sounds = {}
end
-- Para todos os atuais sons ativos.
function Sons:stopAll()
	if self.channels then
		for i = 1, #self.channels, 1 do
			audio.stop(self.channels[i])
		end
	end
end
-- Destroi o objeto sons
function Sons:destroy()
	self.stopAll()
	self.removeAll()
	self.sounds = nil
end

return Sons	