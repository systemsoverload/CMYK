local Background = Class{}

local colors = {
	cyan    = { red = 0, green = 255, blue = 255 },
	magenta = { red = 255, green = 0, blue = 255 },
	yellow  = { red = 255, green = 255, blue = 0 },
	black   = { red = 0, green = 0, blue = 0 }
}

local timeToResolve = 1/10 -- color switching time in seconds

local initialColor = "cyan"

function Background:init()
	local colorData = colors[initialColor]

	self.red = colorData.red
	self.green = colorData.green
	self.blue = colorData.blue
	self.target = colorData

	self.colorName = initialColor

    self.timer = 0
end

function Background:changeTo(color)
	self.colorName = color
	self.target = colors[color]
	self.timer = timeToResolve
end

function Background:update(dt)
	if (self.timer ~= 0) then 
		if (self.timer > 0) then
			-- Number of color values away from target for each of R, G, B
			local delRed = self.target.red - self.red
			local delGreen = self.target.green - self.green
			local delBlue = self.target.blue - self.blue

			-- Percentage of total time till background resolves that has passed since last update
			local pTime = dt/self.timer

			-- Move current color toward target color
			self.red = self.red + delRed*pTime
			self.blue = self.blue + delBlue*pTime
			self.green = self.green + delGreen*pTime

			-- Decrement timer by amount of time passed
			self.timer = self.timer - dt
		else
			-- Account for overshooting target
			self.timer = 0
			self.red = self.target.red
			self.green = self.target.green
			self.blue = self.target.blue
		end
	end
end

function Background:draw()
	love.graphics.setBackgroundColor(self.red, self.green, self.blue)
end

function Background:getColorName()
	if self.timer == 0 then
		return self.colorName
	end
end

return Background