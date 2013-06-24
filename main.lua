io.stdout:setvbuf("no")

loader = require("vendor.AdvTiledLoader.Loader")
Camera = require("vendor.hump.camera")
anim8 = require("vendor.anim8.anim8")
Class = require("vendor.hump.Class")
Player = require("player")
Background = require("background")

loader.path = "maps/"

local map = loader.load("level1.tmx")
local player = Player()
local background = Background()

function love.load()


    -- Close game on escape key
    function love.keypressed(key)
        if key == "escape" then
            love.event.push("quit")
        elseif key == "s" then
            background:changeTo("cyan")
        elseif key == "d" then
            background:changeTo("magenta")
        elseif key == "f" then
            background:changeTo("yellow")
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
    player:update(dt)
end