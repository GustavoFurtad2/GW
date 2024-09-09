require "env"
require "network"
require "states/menu"
require "states/login"
require "states/rooms"

gameStates = {
    ["menu"] = drawMenu,
    ["login"] = drawLogin,
    ["rooms"] = drawRooms,
}

currentGameState = "menu"

function setGameState(gameState)

    currentGameState = gameState
end

function love.mousepressed(x, y, button)

    if button == 1 then

        menu:button(x, y)
        login:button(x, y)
        networkGui:button(x, y)
    end
end

function drawGame()

    currentGameState = gameStates[currentGameState]()
end
