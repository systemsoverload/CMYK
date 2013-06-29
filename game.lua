local Game = Class{}

function Game:init()
	self.width = 1280
	self.height = 720
	love.graphics.setMode( self.width, self.height, false, true, 8)
	love.mouse.setVisible(false)
end

return Game