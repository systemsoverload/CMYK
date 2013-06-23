io.stdout:setvbuf("no")

loader = require("vendor.AdvTiledLoader.Loader")
Camera = require("vendor.hump.camera")
anim8 = require("vendor.anim8.anim8")
Class = require("vendor.hump.Class")
Player = require("player")

loader.path = "maps/"

local map = loader.load("level1.tmx")
local player = Player()

function love.load()


    -- Close game on escape key
    function love.keypressed(key)
        if key == "escape" then
            love.event.push("quit")
        end
    end

end

function love.draw()
    love.graphics.setBackgroundColor( 0, 174, 239 )

    map:autoDrawRange(player.x, player.y, 1)
    map:draw()

    player:draw()
end

function love.update(dt)
    player:update(dt)
end