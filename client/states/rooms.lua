require "ui"
require "font"

rooms = Gui()

local currentGameState = "rooms"

function drawRooms()

    rooms:draw()

    return currentGameState
end
