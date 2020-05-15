Object = require "classic"
local UI = Object:extend()


local title = "PI2NG"
local author = "by Theogen Ratkin"
local press2Play = "Rotate by 180 degrees to begin playing"

local madeWithLove = "Made with LÖVE"
local font = "Font Major Mono Display by Emre Parlak"
local musicAuthor = 'Music "sad Waltz" by frankum'
local sounds = "Sound effects by caiogracco, unfa and V-ktor"


function UI:new()
	self:resize(love.graphics.getDimensions())
	self.fontPath = "res/MajorMonoDisplay-Regular.ttf"
	self.fontSmall = love.graphics.newFont(self.fontPath, 14, "light")
	self.font = love.graphics.newFont(self.fontPath, 20, "light")
	self.fontLarge = love.graphics.newFont(self.fontPath, 48, "light")
	love.graphics.setFont(self.font)
	self.state = "title"
	self.speedPerc = 0
	self.restartAngle = math.pi
end


function UI:update(dt)
	local tol = 20
	if  (self.state == "credits" or self.state == "win") and
		math.abs(racket1.angle - self.restartAngle) < math.rad(tol)
	then
		self.state = "game"
		finalanim:reset()
		ball:start()
	end

	if  racket1.angle < math.rad(tol) or
		racket1.angle > math.pi * 2 - math.rad(tol)
	then
		if self.state == "credits" then
			self.state = "title"
		end
	else
		if self.state == "title" then
			self.state = "credits"
		end
	end
end


function UI:radialEntry(angle, length, width, text)
	love.graphics.setColor({.2, .2, .2, 1})
	love.graphics.setLineWidth(width)
	local distance = RADIUS + 5 + width / 2
	love.graphics.arc(
		"line", "open",
		center.x, center.y,
		distance,
		angle - math.rad(length / 2),
		angle + math.rad(length / 2)
	)

	distance = distance + 10
	local left = 10
	if angle > math.pi / 2 and angle < math.pi * 1.5 then
		left = -(love.graphics.getFont():getWidth(text) + left)
	end
	local up = -self.font:getHeight() / 2
	if angle > math.pi then
	end
	love.graphics.setColor({1, 1, 1, 0.6})
	self:_print(
		text,
		center.x + math.cos(angle) * distance + left,
		center.y + math.sin(angle) * distance + up,
		1
	)
end


function UI:draw()
	love.graphics.setColor({1, 1, 1, 0.6})

	if self.state == "title" or self.state == "credits" then
		love.graphics.setFont(self.fontLarge)
		self:_print(
			title,
			self:_alignCenter(title, 1),
			self._center.y - self.fontLarge:getHeight() / 2,
			1
		)
		love.graphics.setFont(self.fontSmall)
		self:_print(
			author,
			self:_alignCenter(author, 1),
			self._center.y + self.fontLarge:getHeight() / 2,
			1
		)
		love.graphics.setFont(self.font)

		self:radialEntry(0, 20, 5, "Title")
		self:radialEntry(math.rad(340), 20, 2, "Credits")
		self:radialEntry(math.pi, 20, 2, "Play")
	end

	if self.state == "win" then
		self:radialEntry(self.restartAngle, racket2.length, 2, "Restart")
	end

	if self.state == "title" then
		local offset = 60
		self:_print(
			press2Play,
			self:_alignCenter(press2Play, 1),
			self._center.y + offset + self.font:getHeight() * 2,
			1
		)
	end

	if self.state == "credits" then
		local offset = 90
		self:_print(
			madeWithLove,
			self:_alignCenter(madeWithLove, 1),
			self._center.y + offset + self.font:getHeight() * 1,
			1
		)
		self:_print(
			font,
			self:_alignCenter(font, 1),
			self._center.y + offset + self.font:getHeight() * 2,
			1
		)
		self:_print(
			musicAuthor,
			self:_alignCenter(musicAuthor, 1),
			self._center.y + offset + self.font:getHeight() * 3,
			1
		)
		self:_print(
			sounds,
			self:_alignCenter(sounds, 1),
			self._center.y + offset + self.font:getHeight() * 4,
			1
		)
	end

	if self.state == "game" then
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
	love.graphics.print(text, x, y)
end


function UI:resize(x, y)
	self._size = {x = x, y = y}
	self._center = {x = x / 2, y = y / 2}
end


return UI
