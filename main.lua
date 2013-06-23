io.stdout:setvbuf("no")
-- Gets the loader
loader = require("/vendor/AdvTiledLoader/Loader")
Camera = require("/vendor/hump/camera")

player = {}
player.x = 0
player.y = 0

function love.load()
    loader.path = "maps/"
    map = loader.load("level1.tmx")

    -- Close game on escape key
    function love.keypressed(key)
        if key == "escape" then
            love.event.push("quit")
        end
    end

end

function love.draw()
    love.graphics.setBackgroundColor( 0, 174, 239 )
    love.graphics.translate(player.x, player.y)

    map:autoDrawRange(player.x, player.y, 1)
    map:draw()
end

function love.update(dt)
    player.x = player.x - 8
end