local Background = Class{}

CYAN, MAGENTA, YELLOW, BLACK = -- color values for background colors
	{ red = 0, green = 255, blue = 255 },
	{ red = 255, green = 0, blue = 255 },
	{ red = 255, green = 255, blue = 0 },
	{ red = 0, green = 0, blue = 0 }

local timeToResolve = 1/10 -- color switching time in seconds

function Background:init()
	self.red = BLACK.red
	self.green = BLACK.green
	self.blue = BLACK.blue
	self.target = BLACK
    self.timer = 0
end

function Background:changeTo(color)
	self.target = color
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

return Background