local socket = require("socket")
local tcp = socket.tcp()

function connect()

    tcp:connect("127.0.0.1", 8081)

    print("Conectado!")
end
