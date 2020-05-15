Racket    = require "racket"
Ball      = require "ball"
UI        = require "ui"
Input     = require "input"
FinalAnim = require "finalanim"

RADIUS = 100 

function love.load()
	input = Input()
	ui = UI()
	racket1 = Racket()
	racket2 = Racket(true)
	racket2.width = 3
	racket2.startLength = 30
	racket1.opposite = racket2
	racket2.opposite = racket1
	ball = Ball(ui)
	debug = false

	music = love.audio.newSource("res/music.ogg", "stream")
	music:setLooping(true)
	music:setVolume(0.5)
	music:play()

	size = {
		x = love.graphics.getWidth(),
		y = love.graphics.getHeight(),
	}
	center = {
		x = size.x / 2,
		y = size.y / 2,
	}

	genstars()

	finalanim = FinalAnim()
end


function genstars()
   local max_stars = 100
 
   stars = {}
 
   for i=1, max_stars do
      local x = love.math.random(5, size.x-5)
      local y = love.math.random(5, size.y-5)
      stars[i] = {x, y}
   end
end


function love.keypressed(key, scancode, isrepeat)
	if scancode == "escape" or scancode == "q" then
		love.event.quit()
	end
	if scancode == "m" then
		if music:isPlaying() then
			music:pause()
		else
			music:play()
		end
	end
	if scancode == "f1" then
		ui.debug = not ui.debug
	end
end


function love.update(dt)
	input:update(dt)
	ball:update(dt)
	racket1:update(dt)
	racket2:update(dt)
	ui:update(dt)
	finalanim:update(dt)
end


function love.draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.points(stars)
	ui:draw()
	ball:draw()
	racket1:draw()
	racket2:draw()
	finalanim:draw()
end


function love.resize(x, y)
	size = {x = x, y = y}
	center = {x = x / 2, y = y / 2}

	ball:resize(x, y)
	racket1:resize(x, y)
	racket2:resize(x, y)
	ui:resize(x, y)
	finalanim:resize(x, y)
	genstars()
end
