io.stdout:setvbuf("no")

loader = require("vendor.AdvTiledLoader.Loader")
anim8 = require("vendor.anim8.anim8")
Class = require("vendor.hump.Class")
Player = require("player")
Background = require("background")
HC = require("vendor.HardonCollider")
inspect = require("vendor.inspect.inspect") -- Useful for debugging

loader.path = "maps/"

-- Hardoncollider callbacks
function onCollide(dt, obj1, obj2)
    if (obj1 == player.rect) then
        player:collide(obj2)
    elseif (obj2 == player.rect) then
        player:collide(obj1)
    end
end

function stopCollide(dt, obj1, obj2)
    if (obj1 == player.rect) then
        player:stopCollide(obj2)
    elseif (obj2 == player.rect) then
        player:stopCollide(obj1)
    end
end

function love.load()
    -- Load the map
    map = loader.load("level1.tmx")

    -- Initialize the collider
    collider = HC(100, onCollide, stopCollide)
    collider.tiles = {} -- Maps a bounding box to the tile it represents
    
    -- Create bounding boxes for each tile
    for x, y, val in map("Level"):iterate() do
        val.collides = false -- The state of currently colliding with the player is false initially
        local rect = collider:addRectangle(x*map.tileWidth, y*map.tileHeight, map.tileWidth - 1, map.tileHeight - 1)
        collider.tiles[rect] = val
    end

    player = Player()
    background = Background()

    function love.keypressed(key)
        -- Close game on escape key
        if key == "escape" then
            love.event.push("quit")
        -- Background color switches
        elseif key == "a" then
            background:changeTo("black")
        elseif key == "s" then
            background:changeTo("cyan")
        elseif key == "d" then
            background:changeTo("magenta")
        elseif key == "f" then
            background:changeTo("yellow")
        -- Jump!
        elseif key == " " then
            player.velocity.y = 500
        end
    end

end

function love.draw()
    love.graphics.translate( -player.x, -20)

    background:draw()
    player:draw()

    map:autoDrawRange( -player.x, -20, 1)
    map:draw()

    player:draw()
end

function love.update(dt)
    background:update(dt)
    collider:update(dt)
    player:update(dt)
end