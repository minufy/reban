local Img = Class()

function Img:init(x, y)
    self.group_name = "img"
    self.x = x
    self.y = y
    self.w = TILE_SIZE
    self.h = TILE_SIZE
    self.data = "test"
end

function Img:set_data(data)
    self.data = data
    self.w = IMG_TABLE[self.data]:getWidth()
    self.h = IMG_TABLE[self.data]:getHeight()
end

function Img:draw()
    love.graphics.draw(IMG_TABLE[self.data], self.x, self.y)
end

return Img