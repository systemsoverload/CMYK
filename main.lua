io.stdout:setvbuf("no")

function love.load()
	Map = require "map"
	tilesetImage = love.graphics.newImage( "tileset1.png" )
	tilesetImage:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
	local tileSize = 50
	local setWidth = 2
	tiles = {}
	for i=0,3 do
		local row = math.floor(i/setWidth)
		local col = i - row*setWidth
		tiles[i+1] = love.graphics.newQuad(tileSize*row, tileSize*col, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())
	end
end

function love.draw()
	love.graphics.print(Map, 100, 100)
	love.graphics.drawq(tilesetImage, tiles[2], 0, 0)
end

function love.update(dt)
end