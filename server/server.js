const net = require("net")

function jsonToTable(jsonObj) {

    let luaTable = "{\n"
    let indentLevel = 1

    for (let key in jsonObj) {

        if (jsonObj.hasOwnProperty(key)) {

            let value = jsonObj[key]
            luaTable += "\t".repeat(indentLevel) + `[${JSON.stringify(key)}] = `

            if (typeof value === "object") {
                luaTable += jsonToTable(JSON.stringify(value, null, "\t")).trim()
            } 
            else if (typeof value === "string") {
                luaTable += `"${value}"`
            }
            else {
                luaTable += value
            }

            luaTable += ",\n"
        }
    }

    luaTable += "\t".repeat(indentLevel - 1) + "}"
    return luaTable
}

let users = {}

const getEnum = {
    "login": 1
}

const requestEnum = {
    "duplicatedNames": 1
}

const server = net.createServer((socket) => {
    console.log("Client connected")

    socket.on("data", (data) => {

        console.log("received from client: " + data)

        data = JSON.parse(data)

        if (data[0] == getEnum.login) {
            
            socket.write(jsonToTable({
                0: requestEnum.duplicatedNames,
                1: users[data[2]] == undefined ? 0 : 1,
                2: data[2]
            }))

            if (users[data[2]] == undefined) {
                users[data[2]] = {}
            }
        }
    })

    socket.on("end", () => {
        console.log("Client disconnected")
    })

    socket.on("error", (err) => {
        console.log(`Error: ${err.message}`)
    })
})

server.listen(8081, () => {
    console.log("Server listening on port 8081")
})
