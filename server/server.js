const net = require("net")
const rooms = require("./rooms")

let users = require("./users")

const dataEnums = {
    "login": 1,
    "sendRoomList": 2,
}

function sendLoginStatus(socket, data) {

    let username = data[1]

    socket.write(`
        {
           ${dataEnums.login},
           ${users.users[username] == undefined ? 0 : 1}
        }
    `)

    if (!users.users[username]) {
        
        users.users[username] = new users.User(username)
    }
}

function sendRoomList(socket) {

    socket.write(`
        {
            ${dataEnums.sendRoomList},
            ${rooms.getRoomList()}
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
