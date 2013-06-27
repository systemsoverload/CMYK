io.stdout:setvbuf("no")

loader = require("vendor.AdvTiledLoader.Loader")
anim8 = require("vendor.anim8.anim8")
Class = require("vendor.hump.Class")
Player = require("player")
Background = require("background")

loader.path = "maps/"

function love.load()
    map = loader.load("level1.tmx")
    player = Player()
    background = Background()

    -- Close game on escape key
    function love.keypressed(key)
        if key == "escape" then
            love.event.push("quit")
        elseif key == "a" then
            background:changeTo(BLACK)
        elseif key == "s" then
            background:changeTo(CYAN)
        elseif key == "d" then
            background:changeTo(MAGENTA)
        elseif key == "f" then
            background:changeTo(YELLOW)
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