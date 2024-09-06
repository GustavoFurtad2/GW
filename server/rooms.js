let rooms = []

function createRoom(roomName, roomHoster) {

    rooms[rooms.length] = {
        "roomName": roomName,
        "roomHoster": roomHoster
    }
}

function getRoomList() {
    return rooms
}

module.exports = {
    createRoom,
    getRoomList
}
