local Player = Class{}

function Player:init()
    self.x = 0
    self.y = 370
    self.image = love.graphics.newImage("/images/gorilla.png")
end

function Player:update(dt)
	self.x = self.x + 500 * dt
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Player