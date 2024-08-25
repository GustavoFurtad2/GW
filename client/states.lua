require "states/menu"
require "states/login"

gameStates = {
    ["menu"] = drawMenu,
    ["login"] = drawLogin,
}

local currentGameState = "menu"

function setGameState(gameState)

    currentGameState = gameState
end

function drawGame()

    currentGameState = gameStates[currentGameState]()
end
