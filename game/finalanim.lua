Object = require "classic"
local FinalAnim = Object:extend()


local SUNSPEED = 100
local SUNSIZE = 150
local CIRCLES_SPEED = 50
local CIRCLES_COUNT = 15


function FinalAnim:new()
	self.active = false
	self.sunColor = {.8, .7, 0}

	self.sun = 3
	self.circles = {}
	for i = 1, CIRCLES_COUNT do
		self.circles[i] = 1
	end
end


function FinalAnim:play()
	self.active = true
end


function FinalAnim:update(dt)
	if not self.active then
		return
	end

	local diag = math.sqrt(size.x * size.x - size.y * size.y) / 2
	if self.circles[3] and self.circles[3] > diag * 2 then
		for i in pairs(self.circles) do
			self.circles[i] = nil
		end
	elseif self.circles[3] then
		for i = 3, CIRCLES_COUNT do
			self.circles[i] = self.circles[i] + i * dt * CIRCLES_SPEED
		end
	end

	if self.sun < SUNSIZE then
		self.sun = self.sun + SUNSPEED * dt
	end
end


function FinalAnim:draw()
	if not self.active then
		return
	end

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setLineWidth(1)
	for i, circle in pairs(self.circles) do
		love.graphics.circle(
			"line",
			center.x, center.y,
			circle
		)
	end
	love.graphics.setColor(.8, .7, 0, 1)
	love.graphics.circle(
		"fill",
		center.x, center.y,
		self.sun
	)
end


return FinalAnim
