function Gui(x, y)

    local gui = {
        x = x or 0,
        y = y or 0,

        buttons  = {},
        elements = {},
    }

    function gui:textLabel(text, textSize, x, y)

        table.insert(self.elements, {

            x = x,
            y = y,

            text = text,

            textSize = textSize
        })

        local textLabel = gui.elements[#gui.elements]

        function textLabel:draw()

            setFontSize(self.textSize)
            love.graphics.print(self.text, gui.x + self.x, gui.y + self.y)
        end

        return textLabel
    end

    function gui:textButton(text, textSize, x, y, w, h, action)

        table.insert(self.buttons, {

            x = x,
            y = y,

            w = w,
            h = h,
        
            text = text,

            action = action,

            textSize = textSize
        })

        local textButton = gui.buttons[#gui.buttons]

        function textButton:draw()

            local mouseX, mouseY = love.mouse.getPosition()

            setFontSize(self.textSize)

            if mouseX >= gui.x + self.x and mouseX <= gui.x + self.x + self.w and mouseY >= gui.y + self.y and mouseY <= gui.y + self.y + self.h then
                love.graphics.setColor(1, 1, 0)
            end

            love.graphics.print(self.text, gui.x + self.x, gui.y + self.y)
            love.graphics.setColor(1, 1, 1)
        end

        return textButton
    end

    function gui:draw()

        for k, v in next, self.elements do

            v:draw()
        end

        for k, v in next, self.buttons do

            v:draw()
        end
    end

    function gui:button(mouseX, mouseY)

        for k, v in next, self.buttons do

            if mouseX >= v.x and mouseX <= v.x + v.w and mouseY >= v.y and mouseY <= v.y + v.h then

                v.action()
            end
        end
    end

    return gui
end
