require "client"
require "states/rooms"

local socket = require("socket")
local tcp = socket.tcp()

local receivedData = ""

local dataEnums = {

    ["login"] = 1,
    ["roomList"] = 2
}

username = ""

tcp:settimeout(0)
function connect()

    tcp:connect("127.0.0.1", 8081)

    print("Conectado!")
end

function requestRoomList()

    tcp:send(string.format([[
        [
            %s
        ]
    ]], dataEnums.roomList))
end

function update()

    local data, err, partial = tcp:receive("*a")
    if data or (partial and partial ~= "") then

        if data then
            processReceivedData(data)
        elseif partial then
            receivedData = receivedData .. partial
            processReceivedData(receivedData)
        end

    elseif err ~= "timeout" then
        print("Connection closed or error:", err)
    end
end

function processReceivedData(data)

    print("Received data: " .. data)

    data = load("return " .. data)()
    if data[1] == dataEnums["login"] then

        if data[2] == 0 then
            updateLogin(data)
            requestRoomList()
        else
            enter.visible = false
            textBox.visible = false
            errorLabel.visible = true
        end

    elseif data[1] == dataEnums["roomList"] then

        updateRooms(data)
    end
    
    receivedData = ""
end

function loginUser(username)

    tcp:send(string.format([[
        [
            %s,
            "%s"
        ]
    ]], dataEnums.login, username))
end

function love.quit()
    tcp:close()
end
