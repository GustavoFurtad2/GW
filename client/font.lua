local fontSizes = {}
local lastSize

function setFontSize(size)

    if lastSize == size then
        return
    end

    if not fontSizes[size] then

        fontSizes[size] = love.graphics.newFont("arial.ttf", size)
        love.graphics.setFont(fontSizes[size])
    else
        love.graphics.setFont(fontSizes[size])
    end
end
