local Player = Class{}

function Player:init()
    self.x = 0
    self.y = 280
    self.image = love.graphics.newImage("/images/gorilla.png")
    self.grid = anim8.newGrid( 28, 30, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(self.grid('1-4',1), 0.1)
end

function Player:update(dt)
	self.x = self.x + 500 * dt
	self.animation:update(dt)
end

function Player:draw()
    self.animation:draw(self.image, self.x, self.y, 0, 4, 4)
end

return Player