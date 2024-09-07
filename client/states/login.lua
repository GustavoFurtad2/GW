require "ui"
require "font"
require "network"

local currentGameState = "login"

login = Gui()

local isTyping = false

local username = login:textLabel("Username", 80, 420, 255)

function isAlphanumeric(c)

    return c:upper() ~= c:lower() or tonumber(c) ~= nil
end

function typemode()

    isTyping = not isTyping
end

function resetTextBox()

    errorLabel.visible = false
    enter.visible = true
    textBox.text = ""
    textBox.visible = true
    isTyping = true
end

textBox = login:textButton("", 80, 320, 335, 600, 80, typemode)
textBox.showBox = true

function changeState()

    loginUser(textBox.text)
end


errorLabel = login:textButton("Nome sendo utilizado", 60, 320, 335, 600, 80, resetTextBox)
errorLabel.showBox = true
errorLabel.visible = false

enter = login:textButton("Next", 60, 780, 420, 140, 60, changeState)
enter.showBox = true
enter.visible = false

function type(key)

    if isAlphanumeric(key) and key:len() == 1 then

        textBox.text = textBox.text .. key
    elseif key == "backspace" then
        textBox.text = textBox.text:sub(1, textBox.text:len() - 1)
    end

    enter.visible = textBox.text:len() > 0
end

function love.keypressed(key, scancode)

    if isTyping then
        type(scancode)
    end
end

function drawLogin()

    login:draw()

    return currentGameState
end
