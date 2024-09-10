require "ui"
require "env"
require "font"

local currentGameState = "roomCreation"

roomCreation = Gui()

function play()

    currentGameState = "login"
end

roomName = roomCreation:textLabel("", 80, 20, 155)
local roomMaxPlayers = roomCreation:textLabel("Room Max Players", 80, 20, 225)
local fivePlayers = roomCreation:textButton("5", 80, 780, 225, 100, 90, function()
end)

fivePlayers.showBox = true
local tenPlayers = roomCreation:textButton("10", 80, 900, 225, 100, 90, function()
end)
tenPlayers.showBox = true


function drawRoomCreation()

    roomCreation:draw()

    return currentGameState
end
