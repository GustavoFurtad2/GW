require "env"
require "network"
require "states/menu"
require "states/login"
require "states/rooms"
require "states/roomCreation"

gameStates = {
    ["menu"] = drawMenu,
    ["login"] = drawLogin,
    ["rooms"] = drawRooms,
    ["roomCreation"] = drawRoomCreation
}

currentGameState = "menu"

function setGameState(gameState)

    currentGameState = gameState
end

function love.mousepressed(x, y, button)

    if button == 1 and not connectionError then

        if currentGameState == "menu" then

            menu:button(x, y)
        elseif currentGameState == "login" then

            login:button(x, y)
        elseif currentGameState == "rooms" then

            roomsGui:button(x, y)
        elseif currentGameState == "roomCreation" then

            roomCreation:button(x, y)
        end

        networkGui:button(x, y)
    end
end

function drawGame()

    if not connectionError then
        currentGameState = gameStates[currentGameState]()
    end
end
