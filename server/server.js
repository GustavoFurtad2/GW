const net = require("net")
const rooms = require("./rooms")

let users = require("./users")

const dataEnums = {
    "login": 1,
    "haveDuplicatedUsernames": 2,
    "sendRoomList": 3,
}

function sendLoginStatus(socket, data) {

    let username = data[1]

    if (!users.users[username]) {
        
        users.users[username] = new users.User(username)
    }
    
    socket.write(`
        {
           ${dataEnums.haveDuplicatedUsernames},
           ${users.users[username] == undefined ? 0 : 1},
        }
    `)
}

function sendRoomList(socket) {

    socket.write(`
        {
            ${dataEnums.sendRoomList},
            ${roomList.getRoomList()}
        }
    `)
}

const server = net.createServer(
    (socket) => {

        console.log("Client connected")

        socket.on("data", (dataString) => {

            console.log("Data received" + dataString)

            const data = JSON.parse(dataString)

            if (data[0] == dataEnums.login) {

                sendLoginStatus(socket, data)
            }
            else if (data[0] == dataEnums.sendRoomList) {

                sendRoomList(socket)
            }
        })

        socket.on("end", () => {

            console.log("Client disconnected")
        })

        socket.on("error", (error) => {

            console.log(`Error: ${error.message}`)
        })
    }
)

server.listen(8081, () => {
    console.log("Server listening")
})
