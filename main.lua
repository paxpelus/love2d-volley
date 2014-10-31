Gamestate = require "libs.hump.gamestate"

menu = require "states.menu"
game = require "states.game"


function love.load()
	
	--Set fullscreen
	modes = love.window.getFullscreenModes()
	table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end)   -- sort from smallest to largest
	
	success = love.window.setMode( 1024, 728, {fullscreen = false} )
	
	--Set custom cursor
	--cursor = love.mouse.newCursor("img/cursor.png", 0, 0)
	--love.mouse.setCursor(cursor)
	--Grab Mouse
	--love.mouse.setGrabbed(true)
	love.mouse.setVisible(false)
	
	
	Gamestate.registerEvents()
	Gamestate.switch(menu)
end

function love.update(dt)
	
	
	
end

function love.draw()
   
   
   
end

function love.mousepressed(x, y, button)
 
    
 
end

function love.mousereleased(x, y, button)
 
  
 
end
 
function love.keypressed(key, unicode)
 
   if key == "escape" then
      love.event.quit()
   end
 
end
 
function love.keyreleased(key)
 
   
end

