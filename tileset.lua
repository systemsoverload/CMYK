local function load(info)
	image = love.graphics.newImage(info.image)
	image:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles

	tiles = {}

	local rows = math.floor(info.imageheight / info.tileheight)
	local cols = math.floor(info.imagewidth / info.tilewidth)
	local numtiles = rows*cols

	for i=0,numtiles do
		local row = math.floor(i/cols)
		local col = i - row*cols
		tiles[i+info.firstgid] = love.graphics.newQuad(info.tilewidth*row, info.tileheight*col, info.tilewidth, info.tileheight, info.imagewidth, info.imageheight)
	end

	return { tiles = tiles, image = image }
end

return { load = load }