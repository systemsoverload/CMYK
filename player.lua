local Player = Class{}

local GRAVITY = 1000
local JUMP_VELOCITY = -500
local SCROLL_VELOCITY = 500

function Player:init( x, y )
    self.x = x
    self.y = y

    --Tile size is 32x32 but we are drawing at 2x scale
    self.height = 64
    self.width = 64

    self.image = love.graphics.newImage("/images/mario_.png")
    self.grid = anim8.newGrid( 32, 32, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(self.grid(3,1, 2,1, 1,1), 0.1)

    self.bb = collider:addRectangle(self.x, self.y, 64, 64)
    self.velocity = { x = SCROLL_VELOCITY, y = 0 }
    self.acceleration = { x = 0, y = GRAVITY }
end

function Player:collide(box, dx, dy)
    local tile = collider.tiles[box]
    -- If not already colliding with player
    if tile then
        if not tile.collides then
            tile.collides = true
            -- If the tile color matches the background, pretend they're not colliding
            if tile.properties.color ~= background:getColorName() then
                -- If it's the floor (black tile) stop the player accelerating through it
                if tile.properties.color == 'black' and self.velocity.y > 0 then
                    self.velocity.y = 0
                    self.acceleration.y = 0
                    self.bb:move(0, dy)
                    self.y = self.y + dy
                else
                    print("Collided with " .. tile.properties.color .. " tile!")
                end
            end
        end
    else
        self.dead = true
        self.diedAt = {
            x = self.x
            ,y = self.y
        }

    end
end

function Player:stopCollide(box)
    local tile = collider.tiles[box]
    if tile then
        tile.collides = false
        if tile.properties.color == 'black' then
            self.acceleration.y = GRAVITY
        end
    end
end

function Player:jump()
    if self.velocity.y == 0 then
        self.velocity.y = JUMP_VELOCITY
    end
end

function Player:update(dt)
    -- self.x = self.x + 500 * dt
    self.velocity.y = self.velocity.y + dt*self.acceleration.y
    self.velocity.x = self.velocity.x + dt*self.acceleration.x

    if not self.dead then
       self.animation:update(dt)
       self.x = self.x + self.velocity.x * dt
    else
        local foo = self.grid(4,1)
        self.animation = anim8.newAnimation(self.grid(4,1), 60)
    end

    self.y = self.y + self.velocity.y * dt
    self.bb:move(self.velocity.x*dt, self.velocity.y*dt)

end

function Player:draw()
    self.animation:draw(self.image, self.x, self.y, 0, 2, 2)
    self.bb:draw('line')
end

return Player