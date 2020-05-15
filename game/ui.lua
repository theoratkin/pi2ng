Object = require "classic"
local UI = Object:extend()


title = "PI2NG"
author = "by Theogen Ratkin"
press2Play = "Move to begin playing"


function UI:new()
	self:resize(love.graphics.getDimensions())
	self.font = love.graphics.newFont("res/PoiretOne-Regular.ttf", 16)
	self.fontLarge = love.graphics.newFont("res/PoiretOne-Regular.ttf", 64)
	love.graphics.setFont(self.font)
	self.state = "title"
	self.speedPerc = 0
end


function UI:update(dt)
	if  self.state == "title"
		and (input:down("left") or input:down("right"))
	then
		self.state = "game"
		ball:start()
	end
end


function UI:draw()
	love.graphics.setColor({1, 1, 1, 0.6})

	if self.state == "title" then
		love.graphics.setFont(self.fontLarge)
		self:_print(
			title,
			self:_alignCenter(title, 1),
			self._center.y - self.fontLarge:getHeight() / 2,
			1
		)
		love.graphics.setFont(self.font)
		self:_print(
			author,
			self:_alignCenter(author, 1),
			self._center.y + 40,
			1
		)
		self:_print(
			press2Play,
			self:_alignCenter(press2Play, 1),
			self._center.y + 60,
			1
		)
	else
		--[[ Score
		self:_print(
			self.score,
			self:_alignLeft(self.score, 1, 20),
			self._center.y - self.font:getHeight() / 2,
			1
		)
		--]]

		-- Speed
		love.graphics.setColor({1, 1, 1, 0.6})
		self:_print(
			self.speedPerc.."%",
			self:_alignCenter(self.speedPerc, 1, 20),
			self._center.y - self.font:getHeight() / 2,
			1
		)
	end

	if self.debug then
		love.graphics.print("Ball: "   ..ball.angle, 5, 5)
		love.graphics.print("Racket 1: "..racket1.angle, 5, 20)
		love.graphics.print("Racket 2: "..racket2.angle, 5, 35)
		love.graphics.print("Speed: "..ball.speed, 5, 50)

		local fps = love.timer.getFPS()
		love.graphics.print(
			fps,
			self._size.x - self.font:getWidth(fps) - 5,
			5
		)

		love.graphics.setColor(1, 1, 1, 0.2)
		love.graphics.setLineWidth(1)
		love.graphics.line(
			self._center.x - 10000, self._center.y,
			self._center.x + 10000, self._center.y
		)
		love.graphics.line(
			self._center.x, self._center.y - 10000,
			self._center.x, self._center.y + 10000
		)
	end
end

function UI:_alignCenter(text, scale)
	return self._center.x - love.graphics.getFont():getWidth(text) / 2 * scale
end


function UI:_alignLeft(text, scale, offset)
	return self._center.x - love.graphics.getFont():getWidth(text) * scale - offset
end


function UI:_alignRight(text, scale, offset)
	return self._center.x + offset
end


function UI:_print(text, x, y, scale)
	love.graphics.print(text, x, y, 0, scale, scale)
end


function UI:resize(x, y)
	self._size = {x = x, y = y}
	self._center = {x = x / 2, y = y / 2}
end


return UI
