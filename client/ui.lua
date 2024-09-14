require "font"

Interface = {}
Interface.__index = Interface

function Interface:new(x, y)

    local interface = setmetatable(
        {
            x = x or 0,
            y = y or 0,

            comboBoxs = {},
            textLabels = {},
            textButtons = {}
        }, 
    Interface)

    return interface
end

function Interface:textLabel(text, fontSize, x, y)

    table.insert(self.textLabels, {

        visible = true,

        x = x or 0,
        y = y or 0,

        text = text,
        fontSize = fontSize
    })

    local textLabel = self.textLabels[#self.textLabels]

    function textLabel:draw()

        if not self.visible then
            return
        end

        setFontSize(self.fontSize)
        love.graphics.print(self.text, self.x, self.y)

    end

    return textLabel
end

function Interface:textButton(text, fontSize, x, y, width, height, trigger)

    table.insert(self.textButtons, {

        x = x,
        y = y,

        width = width,
        height = height,
    
        text = text,
        fontSize = fontSize,

        trigger = trigger,

        visible = true,
        showBorder = false
    })

    local textButton = self.textButtons[#self.textButtons]

    function textButton:draw()

        if not self.visible then
            return
        end

        setFontSize(self.fontSize)

        if self.showBorder then

            love.graphics.setColor(0.22, 0.22, 0.22)
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 10, 10)
            love.graphics.setColor(1, 1, 1)
        end

        local mouseX, mouseY = love.mouse.getPosition()

        if mouseX >= self.x and mouseX <= self.x + self.width and mouseY >= self.y and mouseY <= self.y + self.height then
            love.graphics.setColor(1, 1, 0)
        end

        love.graphics.print(self.text, self.x + 5, self.y)
        love.graphics.setColor(1, 1, 1)

    end

    return textButton
end

function Interface:comboBox(options, fontSize, x, y, height)

    table.insert(self.comboBoxs, {

        x = x,
        y = y,

        width = 1,
        height = height,

        selectedOption = 1,

        options = options,

        active = false,

        visible = true,
        fontSize = fontSize
    })
  
    local comboBox = self.comboBoxs[#self.comboBoxs]

    for _, option in next, options do

        local width = option.text:len() * fontSize / 2

        if width > comboBox.width then
        
            comboBox.width = width
        end
    end

    function comboBox:draw()

        if not self.visible then
            return
        end
    
        setFontSize(self.fontSize)
    
        love.graphics.setColor(0.22, 0.22, 0.22)
        love.graphics.rectangle("fill", self.x, self.y, self.width + fontSize * 3, self.height, 10, 10)
        love.graphics.setColor(1, 1, 1)

        if self.active then
    
            local index = 0
            
            for k, option in next, options do
    
                if k ~= self.selectedOption then
                    index = index + 1
                    local factorY = self.y + index * height
    
                    love.graphics.setColor(0.22, 0.22, 0.22)
                    love.graphics.rectangle("fill", self.x, factorY, self.width + fontSize * 3, self.height, 10, 10)
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.print(self.options[k].text, self.x + 5, factorY)
                end
            end
        end
    
        love.graphics.print(self.options[self.selectedOption].text, self.x + 5, self.y)
        love.graphics.setColor(0.7, 0, 0)
        love.graphics.print("v", ((self.x + fontSize * 3) + self.width) - 30, self.y)
        love.graphics.setColor(1, 1, 1)
    end

    return comboBox
end

function Interface:draw()

    for _, comboBox in next, self.comboBoxs do

        comboBox:draw()
    end

    for _, textLabel in next, self.textLabels do

        textLabel:draw()
    end

    for _, textButton in next, self.textButtons do

        textButton:draw()
    end

end

function Interface:button(mouseX, mouseY)

    for _, button in next, self.textButtons do
        if mouseX >= button.x and mouseX <= button.x + button.width and mouseY >= button.y and mouseY <= button.y + button.height then
            button.trigger()
            break
        end
    end

    for _, comboBox in next, self.comboBoxs do

        if mouseX >= comboBox.x - comboBox.fontSize and mouseX <= (comboBox.x + comboBox.width * comboBox.fontSize * 2) + comboBox.fontSize and mouseY >= comboBox.y and mouseY <= comboBox.y + comboBox.height then
            comboBox.active = not comboBox.active
            return
        end

        if comboBox.active then

            for index, option in next, comboBox.options do

                local x, y = comboBox.x, comboBox.y + ((index - 1) * comboBox.height)
                if mouseX >= x and mouseX <= x + comboBox.width + (comboBox.fontSize * 2) and mouseY >= y and mouseY <= y + comboBox.height then

                    comboBox.selectedOption = index
                    return
                end
            end
        end
    end
end
