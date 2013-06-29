local Player = Class{}

local GRAVITY = 1000
local JUMP_VELOCITY = -500
local SCROLL_VELOCITY = 500

function Player:init()
    self.x = 0
    self.y = 200
    self.image = love.graphics.newImage("/images/gorilla.png")
    self.grid = anim8.newGrid( 28, 30, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(self.grid('1-4',1), 0.1)

    self.rect = collider:addRectangle(self.x, self.y, self.image:getWidth(), self.image:getHeight()*4)
    self.velocity = { x = SCROLL_VELOCITY, y = 0 }
    self.acceleration = { x = 0, y = GRAVITY }
end

function Player:collide(box, dx, dy)
    local tile = collider.tiles[box]
    -- If not already colliding with player
	if not tile.collides then
        tile.collides = true
        -- If the tile color matches the background, pretend they're not colliding
        if tile.properties.color ~= background:getColorName() then
            -- If it's the floor (black tile) stop the player accelerating through it
            if tile.properties.color == 'black' and self.velocity.y > 0 then
                self.velocity.y = 0
                self.acceleration.y = 0
                self.rect:move(0, dy)
                self.y = self.y + dy
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
        self.acceleration.y = GRAVITY
    end
end

function Player:jump()
    if self.velocity.y == 0 then
        self.velocity.y = JUMP_VELOCITY
    end
end

function Player:update(dt)
	-- self.x = self.x + 500 * dt
	self.velocity.x = self.velocity.x + dt*self.acceleration.x
	self.velocity.y = self.velocity.y + dt*self.acceleration.y

	self.x = self.x + self.velocity.x * dt
	self.y = self.y + self.velocity.y * dt
	self.rect:move(self.velocity.x*dt, self.velocity.y*dt)

	self.animation:update(dt)
end

function Player:draw()
    self.animation:draw(self.image, self.x, self.y, 0, 4, 4)
    self.rect:draw('line')
end

return Player