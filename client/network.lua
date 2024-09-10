require "ui"
require "client"
require "states/rooms"

local socket = require("socket")
local tcp = socket.tcp()

local receivedData = ""

local dataEnums = {

    ["login"] = 1,
    ["roomList"] = 2
}

networkGui = Gui(0, 0)

local function warn(errorMessage)
    networkGui:textButton(errorMessage, 30, 5, 5, 1280, 720, function()
        love.window.close()
        tcp:close()
    end)
end

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

    local sucess = pcall(function()
        data = load("return " .. data)()
    end)

    if not sucess then
        warn("Lua Table inválida, por favor contatar Furto sobre erro")
    end

    local eventName = data[1]

    if eventName == dataEnums["login"] then

        if data[2] == 0 then

            updateLogin(data)
            requestRoomList()
        else
            enter.visible = false
            textBox.visible = false
            errorLabel.visible = true
        end

    elseif eventName == dataEnums["roomList"] then

        updateRooms(data)
    end
    
    receivedData = ""
end

function loginUser(username)

    playerName = username
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
