local fontSizes = {}
local lastSize

local function setFontSize(size)

    if size == lastSize then
        
        return
    end

    if fontSizes[size] then

        love.graphics.setFont(fontSizes[size])
        lastSize = size
        return
    end

    fontSizes[size] = love.graphics.newFont("arial.ttf", size)
    love.graphics.setFont(fontSizes[size])
    lastSize = size
end

function userInterface(x, y)

    local userInterface = {

        x = x or 0,
        y = y or 0,

        buttons  = {},
        elements = {},

        visible  = false
    }

    function userInterface:addText(text, posX, posY, size, color)

        table.insert(self.elements, {

            x = self.x + posX,
            y = self.y + posY,

            text  = text,
            size  = size,
            color = color or {1, 1, 1},
        })

        local text = self.elements[#self.elements]

        function text:setPos(posX, posY)

            self.x, self.y = x + posX, y + posY
        end

        function text:draw()

            setFontSize(self.size)
            love.graphics.print(self.text, self.x, self.y)
        end

        return text
    end

    function userInterface:addButton(text, posX, posY, length, height, size, color, action)

        table.insert(self.elements, {

            x = self.x + posX,
            y = self.y + posY,

            text   = text,
            size   = size,
            color  = color or {1, 1, 1},

        })

        table.insert(self.buttons, {

            x = self.x + posX,
            y = self.y + posY,

            length = length,
            height = height,

            action = action
        })

        local button = self.elements[#self.elements]

        function button:setPos(posX, posY)

            self.x, self.y = x + posX, y + posY
        end

        function button:draw()

            setFontSize(self.size)
            love.graphics.print(self.text, self.x, self.y)
        end

        return button
    end

    function userInterface:update(mouseX, mouseY)

        for k, button in next, self.buttons do

            if mouseX >= button.x and mouseX <= button.x + button.length and mouseY >= button.y and mouseY <= button.y + button.height then

                button.action()
            end
        end
    end


    function userInterface:draw()

        for k, element in next, self.elements do

            element:draw()
        end
    end

    return userInterface
end