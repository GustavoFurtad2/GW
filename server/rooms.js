let rooms = []

class Room {

    open = true

    constructor(roomName, roomHoster, players, maxPlayers) {

        this.roomName = roomName
        this.roomHoster = roomHoster
        this.players = players
        this.maxPlayers = maxPlayers
    }
}

function createRoom(roomName, roomHoster, maxPlayers) {

    rooms[rooms.length] = new Room(roomName, roomHoster, 1, maxPlayers)
}

createRoom("tobas", "flavin do pneu", 8)
createRoom("sala dos crias", "joazinhogameplays1337", 5)
createRoom("Enigmas", "CellBit", 90)
createRoom("L", "Kira", 11)

function getRoomList() {
    return rooms
}

module.exports = {
    Room,
    getRoomList
}
