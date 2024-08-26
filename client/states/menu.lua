require "ui"
require "font"

local currentGameState = "menu"

menu = Gui()
local text = menu:textLabel("Geografic Wars", 80, 25, 25)

function play()

    currentGameState = "login"
end

local play = menu:textButton("Play", 80, 25, 250, 200, 80, play)
local exit = menu:textButton("Exit", 80, 25, 335, 200, 80, love.window.close)

function drawMenu()

    menu:draw()

    return currentGameState
end
