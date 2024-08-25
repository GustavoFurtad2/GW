require "ui"
require "font"

local currentGameState = "login"

local login = Gui()

local exit = login:textButton("Exit", 80, 25, 335, 200, 80, love.window.close)

function love.mousepressed(x, y, button)

    if button == 1 then

        login:button(x, y)
    end
end

function drawLogin()

    login:draw()

    return currentGameState
end
