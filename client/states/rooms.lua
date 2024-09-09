require "ui"
require "font"

rooms = {}
roomsGui = Gui()

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

tableText  = roomsGui:textLabel("Owner          Room Name         Players           MaxPlayers", 40, 50, 90)
roomCreate = roomsGui:textButton("Create Room", 50, 80, 620, 300, 70, function()

    currentGameState = "roomCreation"
end)

roomCreate.showBox = true

local currentGameState = "rooms"

function updateRooms(data)

    for k, v in next, data[2] do

        createRoom(v[1], k, v[2], v[3], v[4])
    end

    for k, v in next, rooms do
        local roomButton = roomsGui:textButton(v.owner .. "  " .. v.roomName .. "  " .. v.players .. "  " .. v.maxPlayers, 80, 50, 180 + (k - 1) * 90, 1000, 80, play)
        roomButton.showBox = true
    end
end

function drawRooms()

    roomsGui:draw()


    return currentGameState
end
