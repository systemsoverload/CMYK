local _tileset = require "tileset"

local function load(mapfile)
	local map = require(mapfile)
	local tileset = _tileset.load(map.tilesets[1])
	return { tileset = tileset.image, tiles = tileset.tiles, tilewidth = map.tilewidth, tileheight = map.tileheight, width = map.width, height = map.height }
end

return load("demo")
