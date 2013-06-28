local Player = Class{}

function Player:init()
    self.x = 0
    self.y = 200
    self.image = love.graphics.newImage("/images/gorilla.png")
    self.grid = anim8.newGrid( 28, 30, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(self.grid('1-4',1), 0.1)

    self.rect = collider:addRectangle(self.x, self.y, self.image:getWidth(), self.image:getHeight()*4)
    self.velocity = { x = 500, y = 0 }
    self.acceleration = { x = 0, y = -1000 }
end

function Player:collide(box)
    local tile = collider.tiles[box]
    -- If not already colliding with player
	if not tile.collides then
        tile.collides = true
        -- If the tile color matches the background, pretend they're not colliding
        if tile.properties.color ~= background:getColorName() then
            -- If it's the floor (black tile) stop the player accelerating through it
            if tile.properties.color == 'black' and self.velocity.y < 0 then
                self.velocity.y = 0
                self.acceleration.y = 0
            else
                print("Collided with " .. tile.properties.color .. " tile!")
            end
        end
    end
end

function Player:stopCollide(box)
    local tile = collider.tiles[box]
    tile.collides = false
    if tile.properties.color == 'black' then
        self.acceleration.y = -1000
    end
end

function Player:update(dt)
	-- self.x = self.x + 500 * dt
	self.velocity.x = self.velocity.x + dt*self.acceleration.x
	self.velocity.y = self.velocity.y + dt*self.acceleration.y

	self.x = self.x + self.velocity.x * dt
	self.y = self.y - self.velocity.y * dt
	self.rect:move(self.velocity.x*dt, -self.velocity.y*dt)

	self.animation:update(dt)
end

function Player:draw()
    self.animation:draw(self.image, self.x, self.y, 0, 4, 4)
    self.rect:draw('line')
end

return Player