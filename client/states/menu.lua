require "ui"
require "font"

local currentGameState = "menu"

menu = Interface:new()
local text = menu:textLabel("Geografic Wars", 80, 25, 25)

function play()

    currentGameState = "login"
end

local play = menu:textButton("Play", 70, 25, 250, 200, 75, play)
local exit = menu:textButton("Exit", 70, 25, 335, 200, 75, love.window.close)

play.showBorder = true
exit.showBorder = true

function drawMenu()

    menu:draw()

    return currentGameState
end
