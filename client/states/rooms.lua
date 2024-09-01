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

local currentGameState = "rooms"

for k, v in next, rooms do
    roomsGui:textButton(v.roomName, 80, 50, 90 + (k - 1) * 90, 200, 80, play)
end

function drawRooms()

    roomsGui:draw()


    return currentGameState
end
