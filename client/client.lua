local socket, json = require("socket"), require("json")

local tcp = socket.tcp()

tcp:settimeout(0)
tcp:connect("127.0.0.1", 8081)

local receivedData = ""

tcp:send("teste love")
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
end


function love.quit()
    tcp:close()
end
