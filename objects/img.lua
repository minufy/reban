local Img = Object:extend()

function Img:new(data)
    self.type = data.type
    self.x = data.x
    self.y = data.y
    self.draw_x = 0
    self.draw_y = 0
    self.dir = data.dir or 0
    self.r = self.dir*math.pi/2
    self.w = Image["img."..data.type]:getWidth()
    self.h = Image["img."..data.type]:getHeight()
end

function Img:draw()
    love.graphics.draw(Image["img."..self.type], self.x+self.draw_x, self.y+self.draw_y, self.r)
end

return Img