require "ui"
require "client"
require "country"

love.graphics.setBackgroundColor(0.28, 0.28, 0.28)

local currentState = 1
local uis = {

    [1] = userInterface(),
}

local gameStates = {

    mainMenu = 1,
}

uis[gameStates.mainMenu]:addButton("Play", 50, 350, 200, 80, 80, nil, function()

end)

uis[gameStates.mainMenu]:addButton("Exit", 50, 500, 200, 80, 80, nil, function()

    love.window.close()
end)

function love.mousepressed(x, y, button, istouch)

    if button == 1 then

        uis[currentState]:update(x, y)
    end
end

function love.draw()

    uis[currentState]:draw()
end

function love.update()

    update()
end
