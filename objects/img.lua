local Img = {}
Img.__index = Img

function Img:new(data)
    local o = setmetatable({}, self)
    o.type = data.type
    o.x = data.x
    o.y = data.y
    o.draw_x = 0
    o.draw_y = 0
    o.dir = data.dir or 0
    o.r = o.dir*math.pi/2
    o.w = Image[data.type]:getWidth()
    o.h = Image[data.type]:getHeight()
    return o
end

function Img:draw()
    love.graphics.draw(Image[self.type], self.x+self.draw_x, self.y+self.draw_y, self.r)
end

return Img