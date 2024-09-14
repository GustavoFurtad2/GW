require "ui"
require "env"
require "font"

local currentGameState = "roomCreation"

roomCreation = Interface:new()

function play()

    currentGameState = "login"
end

roomName = roomCreation:textLabel("", 40, 20, 155)
local roomMaxPlayers = roomCreation:textLabel("Room Max Players", 40, 20, 225)
local players = roomCreation:comboBox({
    {text = "2"},
    {text = "3"},
    {text = "4"},
    {text = "5"},
    {text = "6"},
    {text = "7"},
    {text = "8"},
}, 40, 380, 230, 45)

local create = roomCreation:textButton("Create", 50, 1045, 620, 165, 65, function()

end)

create.showBorder = true



function drawRoomCreation()

    roomCreation:draw()

    return currentGameState
end
