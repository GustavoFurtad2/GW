require "states"
require "network"

love.graphics.setBackgroundColor(0.62, 0, 0)

setGameState("menu")

function love.load()

    connect()
end

function love.draw()

    drawGame()
end

function love.update()

    update()
end
