io.stdout:setvbuf("no")

loader = require("vendor.AdvTiledLoader.Loader")
anim8 = require("vendor.anim8.anim8")
Class = require("vendor.hump.Class")
HC = require("vendor.HardonCollider")
inspect = require("vendor.inspect.inspect") -- Useful for debugging
Game = require("game")
Player = require("player")
Background = require("background")

loader.path = "maps/"
game = Game()

-- Hardoncollider callbacks
function onCollide(dt, obj1, obj2, dx, dy)
    if (obj1 == player.rect) then
        player:collide(obj2, dx, dy)
    elseif (obj2 == player.rect) then
        player:collide(obj1, dx, dy)
    end
end

function stopCollide(dt, obj1, obj2)
    if (obj1 == player.rect) then
        player:stopCollide(obj2)
    elseif (obj2 == player.rect) then
        player:stopCollide(obj1)
    else
        print("Non-player collision!")
    end
end

function love.load()
    -- Load the map
    map = loader.load("level2.tmx")

    -- Initialize the collider
    collider = HC(100, onCollide, stopCollide)
    collider.tiles = {} -- Maps a bounding box to the tile it represents

    for i, obj in pairs( map("Entities").objects ) do
        if obj.type == 'Spawn' then
            map.spawn = obj
        elseif obj.type == 'Death' then
            -- val.collides = false -- The state of currently colliding with the player is false initially
            local rect = collider:addRectangle(obj.x, obj.y, obj.width, obj.height)
            collider:addToGroup("level_geometry", rect) -- Level objects will not collide with each other if grouped
            collider:setPassive(rect) -- Level objects will not search for collisions
            collider.tiles[rect] = val
        end
    end

    -- Create bounding boxes for each tile
    for x, y, val in map("Level"):iterate() do
        val.collides = false -- The state of currently colliding with the player is false initially
        local rect = collider:addRectangle(x*map.tileWidth, y*map.tileHeight, map.tileWidth, map.tileHeight)
        collider:addToGroup("level_geometry", rect) -- Level objects will not collide with each other if grouped
        collider:setPassive(rect) -- Level objects will not search for collisions
        collider.tiles[rect] = val
    end

    player = Player( map.spawn.x, map.spawn.y )
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
            player:jump()
        end
    end

end

function love.draw()
    -- print(inspect(tile))local yTrans = math.max(-player.y + 250, 0)
    local yTrans

    if player.dead then
        yTrans = -player.diedAt.y + game.height / 2 + player.height
    else
        yTrans = (-player.y + game.height / 2 ) + player.height
    end


    love.graphics.translate(
        (-player.x + game.width / 2) - player.width,
        yTrans
    )

    background:draw()
    player:draw()

    map:autoDrawRange(
        (-player.x + game.width / 2) - player.width,
        (-player.y + game.height / 2) + player.height,
        1
     )
    map:draw()

    player:draw()
end

local delta = 0
local FPS_LIMIT = 100
function love.update(dt)
    delta = delta + dt
    if (delta < 1/FPS_LIMIT) then
        return
    end
    -- print(dt)
    background:update(delta)
    collider:update(delta)
    player:update(delta)
    -- factor = factor + zoomAccel
    delta = 0
end