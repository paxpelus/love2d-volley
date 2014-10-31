local menu = {} 

local option = "start"

function menu:init()
    --self.background = love.graphics.newImage('img/menu_bg.jpg')
    
end

function menu:enter()
    
end
    
function menu:draw()
    --love.graphics.setBackgroundColor( 0, 0, 0 )
    --love.graphics.draw(self.background, 0, 0)
    
    love.graphics.setColor(255, 0, 0, 100)
    
    if option == "start" then
        love.graphics.rectangle("fill", (love.graphics.getWidth()/2) - 100, 290, 200, 50 )
    end
    
    if option == "options" then
        love.graphics.rectangle("fill", (love.graphics.getWidth()/2) - 100, 350, 200, 50 )
    end
    
    if option == "credits" then
        love.graphics.rectangle("fill", (love.graphics.getWidth()/2) - 100, 410, 200, 50 )
    end
    
    love.graphics.setColor(255, 255, 255, 100)
    
    love.graphics.setFont(love.graphics.newFont(26))
    love.graphics.printf("New Game",0, 300, love.graphics.getWidth(),"center")
    love.graphics.printf("Options",0, 360, love.graphics.getWidth(),"center")
    love.graphics.printf("Credits",0, 420, love.graphics.getWidth(),"center")
    
    love.graphics.setFont(love.graphics.newFont(10))
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
        
    local delta = love.timer.getAverageDelta()
    -- Display the frame time in milliseconds for convenience.
    -- A lower frame time means more frames per second.
    love.graphics.print(string.format("Average frame time: %.3f ms", 1000 * delta), 10, 20)
end

function menu:keypressed(key, unicode)
 
   if key == "return" then
       if option=="start" then Gamestate.switch(game) end
       if option=="options" then Gamestate.switch(game) end
       if option=="credits" then Gamestate.switch(game) end
   end
   
   if key == "down" then
       if option == "start" then 
           option = "options" 
       elseif option == "options" then 
           option = "credits" 
       elseif option == "credits" then 
           option = "start" 
       end
   end
   
   if key == "up" then
       if option == "start" then 
           option = "credits" 
       elseif option == "options" then 
           option = "start" 
       elseif option == "credits" then 
           option = "options"
       end
   end
 
end

return menu