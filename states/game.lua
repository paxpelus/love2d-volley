local game = {}

local playerRadius = 45
local ballRadius = 38
local speed = 400
local gravity = 2000
local jump_height = 1500

local background = love.graphics.newImage("img/bg.jpg")
local net = love.graphics.newImage("img/net.png")

function game:init()
    
end

function game:enter()
    
    gameReset()
    
end

function game:update(dt)
    
    --Player 1
    if player1.moveLeft == 1 then
        if player1.x <= 0 then
            player1.x = 0
        else
            player1.x = player1.x - (speed * dt)
            player1.vx = - (speed * dt)
        end
    end
    
    if player1.moveRight == 1 then
        if player1.x >= (love.graphics.getWidth()/2)-(net:getWidth()/2) - playerRadius then
            player1.x = (love.graphics.getWidth()/2)-(net:getWidth()/2) - playerRadius
        else
            player1.x = player1.x + (speed * dt)
            player1.vx = (speed * dt)
        end
    end
    
    if player1.vy ~= 0 then -- we're probably jumping
        player1.y = player1.y - player1.vy * dt -- dt means we wont move at
        -- different speeds if the game lags
        player1.vy = player1.vy - gravity * dt * 1.2
        if player1.y > love.graphics.getHeight() - playerRadius then -- we hit the ground again
            player1.vy = 0
            player1.y = love.graphics.getHeight() - playerRadius
        end
    end

    if player1.moveUp == 1 and player1.vy == 0 then
        player1.vy = jump_height
    end
    
    --Player 2
    if player2.moveLeft == 1 then
        if player2.x <= (love.graphics.getWidth()/2)+(net:getWidth()/2) + playerRadius then
            player2.x = (love.graphics.getWidth()/2)+(net:getWidth()/2) + playerRadius
        else
            player2.x = player2.x - (speed * dt)
            player2.vx = - (speed * dt)
        end
    end
    
    if player2.moveRight == 1 then
        if player2.x >= love.graphics.getWidth() then
            player2.x = love.graphics.getWidth()
        else
            player2.x = player2.x + (speed * dt)
            player2.vx = (speed * dt)
        end
    end
    
    if player2.vy ~= 0 then -- we're probably jumping
        player2.y = player2.y - player2.vy * dt -- dt means we wont move at
        -- different speeds if the game lags
        player2.vy = player2.vy - gravity * dt * 1.2
        if player2.y > love.graphics.getHeight() - playerRadius then -- we hit the ground again
            player2.vy = 0
            player2.y = love.graphics.getHeight() - playerRadius
        end
    end

    if player2.moveUp == 1 and player2.vy == 0 then
        player2.vy = jump_height
    end
    
    circleResolution(player1,ball)
    circleResolution(player2,ball)
    
    
    --Ball
    
    if ball.vy ~= 0 then -- we're probably jumping
        ball.y = ball.y - ball.vy * dt -- dt means we wont move at
        -- different speeds if the game lags
        ball.vy = ball.vy - gravity * dt
        if ball.y > love.graphics.getHeight() - ballRadius then -- we hit the ground again
            ball.vy = 1200
            ball.y = love.graphics.getHeight() - ballRadius
        end
    end

    --Moving right
    if ball.vx > 0 then -- ball is moving x
        ball.x = ball.x + ball.vx * dt -- dt means we wont move at
        -- different speeds if the game lags
        ball.vx = ball.vx - 200 * dt
    end
    
    --Moving left
    if ball.vx < 0 then -- ball is moving x
        ball.x = ball.x + ball.vx * dt -- dt means we wont move at
        -- different speeds if the game lags
        ball.vx = ball.vx + 200 * dt
        
    end
    
    
    --If hit right wall
    if ball.x >= love.graphics.getWidth() - ballRadius then -- we hit the right wall
        ball.x = love.graphics.getWidth() - ballRadius
        ball.vx = -ball.vx
    end
    
    --If hit left wall
    if ball.x <= ballRadius then -- we hit the left wall
        ball.x = ballRadius
        ball.vx = -ball.vx
    end
    
    --If hit net
    if ball.vx > 0 and ball.x >= (love.graphics.getWidth()/2)-(net:getWidth()/2) - ballRadius and ball.x <= (love.graphics.getWidth()/2)+(net:getWidth()/2) + ballRadius  and ball.y >= love.graphics.getHeight()-net:getHeight()-ballRadius then
        --left side
        
        local middle = (love.graphics.getWidth()/2)-(net:getWidth()/2)
        
        if ball.x<middle then
            ball.vx = -ball.vx
        end
        
        if ball.y <= love.graphics.getHeight()-net:getHeight()-ballRadius + 30 and ball.vy<0 then
            ball.vy = -ball.vy
            if ball.vx < 3 or ball.vx > -3 then
               ball.vx = ball.vx * 1.5 
            end
        else
            ball.x = (love.graphics.getWidth()/2)-(net:getWidth()/2) - ballRadius
        end
    elseif ball.vx < 0 and ball.x >= (love.graphics.getWidth()/2)-(net:getWidth()/2) - ballRadius and ball.x <= (love.graphics.getWidth()/2)+(net:getWidth()/2) + ballRadius  and ball.y >= love.graphics.getHeight()-net:getHeight()-ballRadius then
        --right side
        local middle = (love.graphics.getWidth()/2)-(net:getWidth()/2)
        
        if ball.x>middle then
            ball.vx = -ball.vx
        end
        
        if ball.y <= love.graphics.getHeight()-net:getHeight()-ballRadius + 30 and ball.vy<0  then
            ball.vy = -ball.vy
            if ball.vx < 3 or ball.vx > -3 then
               ball.vx = ball.vx * 1.5 
            end
        else
            ball.x = (love.graphics.getWidth()/2)+(net:getWidth()/2) + ballRadius
        end
    end
    
    
    --square position
    square.x = ball.x
    
    
    --moufa AI
    player1.moveUp = 0
    
    if ball.x < (love.graphics.getWidth()/2)-(net:getWidth()/2) then
        player1.x = ball.x - 30
        if math.sqrt((player1.x - ball.x)^2 + (player1.y - ball.y)^2) < 180 then
            player1.moveUp = 1
        end 
    end
    
end

function game:draw()
    
    --Draw the background & net
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(net, (love.graphics.getWidth()/2)-(net:getWidth()/2), love.graphics.getHeight()-net:getHeight())
    
    --Player 1
    love.graphics.setColor(255, 0, 0);
    love.graphics.circle("fill", player1.x, player1.y, player1.radius, 100); -- Draw white circle with 100 segments.
    
    --Player 2
    love.graphics.setColor(0, 255, 0);
    love.graphics.circle("fill", player2.x, player2.y, player2.radius, 100); -- Draw white circle with 100 segments.

    --Ball
    love.graphics.setColor(0, 0, 255);
    love.graphics.circle("fill", ball.x, ball.y, ball.radius, 100); -- Draw white circle with 100 segments.
    
    --Square - Ball Position
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", square.x, square.y, 10, 10 )

    --FPS    
    love.graphics.setColor(0,0,0)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
        
    local delta = love.timer.getAverageDelta()
    -- Display the frame time in milliseconds for convenience.
    -- A lower frame time means more frames per second.
    love.graphics.print(string.format("Average frame time: %.3f ms", 1000 * delta), 10, 20)
    
    love.graphics.print("Player 1: x = " .. player1.x .. " y = " .. player1.y .. " xvel = " .. player1.vx .. " yvel = " .. player1.vy, 10, 30)
    love.graphics.print("Player 2: x = " .. player2.x .. " y = " .. player2.y .. " xvel = " .. player2.vx .. " yvel = " .. player2.vy, 10, 40)
    love.graphics.print("Ball: x = " .. ball.x .. " y = " .. ball.y .. " yvel = " .. ball.vy .. " xvel = " .. ball.vx, 10, 50)
    
    love.graphics.setColor(255,255,255)
end

function game:keypressed(key, unicode)
 
    --Player 1
   if key == "a" then
      player1.moveLeft = 1
   end
   
   if key == "d" then
      player1.moveRight = 1
   end
   
   if key == "w" then
        player1.moveUp = 1
   end
   
   --Player 2
   if key == "left" then
      player2.moveLeft = 1
   end
   
   if key == "right" then
      player2.moveRight = 1
   end
   
   if key == "up" then
       player2.moveUp = 1
   end
   
   
   --Reset
   if key == "r" then
       gameReset()
   end
 
end

function game:keyreleased(key, unicode)
 
    --Player 1
   if key == "a" then
      player1.moveLeft = 0
      player1.vx = 0
   end
   
   if key == "d" then
      player1.moveRight = 0
      player1.vx = 0
   end
   
   if key == "w" then
      player1.moveUp = 0
   end
   
   --Player 2
   if key == "left" then
      player2.moveLeft = 0
      player2.vx = 0
   end
   
   if key == "right" then
      player2.moveRight = 0
      player2.vx = 0
   end
   
   if key == "up" then
      player2.moveUp = 0
   end
 
end

--Check if player & ball collide
function checkCircleColl(circleA, circleB)
    local dist = math.sqrt((circleA.x - circleB.x)^2 + (circleA.y - circleB.y)^2)
    return dist <= circleA.radius + circleB.radius
end

--Resolve what happens when player & ball collide
function circleResolution(circleA, circleB)
    
    if checkCircleColl(circleA, circleB) then
        
        --Avoid stuck ball
        while checkCircleColl(circleA, circleB) do
            if circleB.y < circleA.y then
                circleB.y = circleB.y - 1
            else
                circleB.y = circleB.y + 1
            end
        end
        
        --ball Velocity X        
        circleB.vx = (circleB.x-circleA.x)*15
        
        if circleB.vx > 0 then
            circleB.vx = circleB.vx  + (circleA.vx*12)
        elseif circleB.vx < 0 then
            circleB.vx = circleB.vx  - (circleA.vx*12)
        end
        
        
        --ball Velocity Y
        if circleA.vy > 0 then
            circleB.vy = circleA.vy*1.1
        elseif circleA.vy < 0 then
            if circleA.y == love.graphics.getHeight() - playerRadius then
                circleB.vy = 1200
            else
                circleB.vy = circleA.vy*1.05    
            end
        elseif circleA.vy == 0 then
            circleB.vy = 1200
        end
        
        
        --Koftis
        if circleB.vx > 900 then
            circleB.vx =900
        end
        
        if circleB.vx < -900 then
            circleB.vx = -900
        end
        
        if circleB.vy < 750 and circleB.vy > 0 then
            circleB.vy = 750
        end
        
       
    end
end

function gameReset()
    
    square = {
        x = ((love.graphics.getWidth()/2)-(net:getWidth()/2))/2 + (love.graphics.getWidth()/2),
        y = 10,
    }
    
    ball = {
        radius = ballRadius,
        x = ((love.graphics.getWidth()/2)-(net:getWidth()/2))/2 + (love.graphics.getWidth()/2),
        y = love.graphics.getHeight() - 350,
        vx = 0,
        vy = 0,
        mass = 1
    }

    player1 = {
        radius = playerRadius,
        x = ((love.graphics.getWidth()/2)-(net:getWidth()/2))/2,
        y = love.graphics.getHeight() - playerRadius,
        vx = 0,
        vy = 0,
        moveLeft = 0,
        moveRight = 0,
        moveUp = 0,
        mass = 10
    }
    
    player2 = {
        radius = playerRadius,
        x = ((love.graphics.getWidth()/2)-(net:getWidth()/2))/2 + (love.graphics.getWidth()/2),
        y = love.graphics.getHeight() - playerRadius,
        vx = 0,
        vy = 0,
        moveLeft = 0,
        moveRight = 0,
        moveUp = 0,
        mass = 10
    }
    
end

return game