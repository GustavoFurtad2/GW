require "ui"
require "font"

rooms = {}
roomsGui = Interface:new()

function createRoom(roomName, roomID, owner, players, maxPlayers)

    rooms[roomID] = {

        owner = owner,
        players = players,
        maxPlayers = maxPlayers,

        roomName = roomName,
    }
end

function updateRoomStatus(roomID, players, maxPlayers)

    rooms[roomID].players = players
    rooms[roomID].maxPlayers = maxPlayers
end

function closeRoom(roomID)

    table.remove(rooms, roomID)
end

roomCreate = roomsGui:textButton("Create Room", 50, 80, 620, 310, 65, function()

    currentGameState = "roomCreation"
end)

local back = roomsGui:textButton("Back", 50, 1050, 620, 145, 65, function()

    currentGameState = "login"
end)

roomCreate.showBorder = true
back.showBorder = true

local currentGameState = "rooms"

local function abbreviate(string, maxChars)

    return string:len() >= maxChars and string:sub(1, maxChars) .. "..." or string
end

function updateRooms(data)

    for k, v in next, data[2] do

        createRoom(v[1], k, v[2], v[3], v[4])
    end

    for k, v in next, rooms do

        local factorY = 80 + (k - 1) * 80

        local roomButton = roomsGui:textButton(abbreviate(v.owner, 26) .. string.format("(%s / %s)", v.players, v.maxPlayers), 35, 50, factorY, 1000, 65, play)

        roomButton.showBorder = true
    end
end

function drawRooms()

    roomsGui:draw()


    return currentGameState
end
