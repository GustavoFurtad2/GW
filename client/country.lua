local function country(x, y, imagePath, sx, sy)

    local instance = {

        owner,

        x = x,
        y = y,

        sx = sx,
        sy = sy,

        color = {1, 1, 1},
        image = love.graphics.newImage(imagePath),
    }

    function instance:draw()

        love.graphics.setColor(self.color[1], self.color[2], self.color[3])
        love.graphics.draw(self.image, self.x, self.y, 0, self.sx, self.sy)
    end

    return instance
end

countries = {

    [1] = country(300, 200, "countries/brazil.png", 0.5, 0.5),
    [2] = country(375, 415, "countries/uruguay.png", 0.15, 0.15),
    [3] = country(230, 375, "countries/argentina.png", 0.5, 0.5),

}

function drawCountries()

    for index, v in next, countries do
        
        v:draw()
    end
end