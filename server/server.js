const net = require("net")
const rooms = require("./rooms")

let users = require("./users")

const dataEnums = {
    "login": 1,
    "sendRoomList": 2,
    "logout": 3,
    "createRoom": 4
}

function sendLoginStatus(socket, data) {

    const username = data[1]
    let clientIP = socket.remoteAddress

    let loginAllowed = users.users[username] == undefined ? 1 : 0

    if (users.users[username] && !users.users[username].onlline && clientIP == users.users[username].ip) {

        loginAllowed = 1
    }

    socket.write(`
        {
           ${dataEnums.login},
           ${loginAllowed}
        }
    `)

    if (!users.users[username]) {
        
        users.users[username] = new users.User(username, socket.remoteAddress, socket)
    }
}

function sendLogout(socket, data) {

    const username = data[1]
    const clientIP = socket.remoteAddress

    if (users.users[username] && clientIP == users.users[username].ip) {

        if (users.users[username].onlline) {
            delete users.users[username]
        }
    }
}

function sendRoomList(socket) {

    let roomList = ""

    rooms.getRoomList().forEach(room => {

        if (room.open) {
            roomList += `
            {
                "${room.roomName}",
                "${room.roomHoster}",
                ${room.players},
                ${room.maxPlayers}
            },
            `
        }
    })

    socket.write(`
        {
            ${dataEnums.sendRoomList},
            {
                ${roomList}
            }
        }
    `)
}

const server = net.createServer(
    (socket) => {

        console.log("Client connected")

        socket.on("data", (dataString) => {

            console.log("Data received" + dataString)

            try {

                const data = dataString.startsWith("{") ? JSON.parse(dataString) : null
                const eventName = data[0]

                if (eventName == dataEnums.login) {

                    sendLoginStatus(socket, data)
                }
                else if (eventName == dataEnums.logout) {

                    sendLogout(socket, data)
                }
                else if (eventName == dataEnums.sendRoomList) {

                    sendRoomList(socket)
                }
            }
            catch(e) {

                console.log("fail send data or parse received data")
            }
        })

        socket.on("end", () => {

            console.log("Client disconnected")
            for (let user in users.users) {

                if (socket.remoteAddress == user.ip) {
                    user.onlline = false
                    break
                }
            }
        })

        socket.on("error", (error) => {

            console.log(`Error: ${error.message}`)
        })
    }
)

server.listen(1024, () => {
    console.log("Server listening")
})
