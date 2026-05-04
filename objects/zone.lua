local Zone = {}
Zone.__index = Zone

function Zone:new(data)
    local o = setmetatable({}, self)
    o.x = data.x
    o.y = data.y
    o.w = data.w or TILE_SIZE
    o.h = data.h or TILE_SIZE
    o.value = data.value or "cam"
    o.locked = true
    return o
end

function Zone:draw()
    if Edit.editing then
        love.graphics.setColor(0, 1, 1, 0.1)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        Color.reset()
        love.graphics.setFont(Font)
        love.graphics.print(self.value, self.x, self.y)
    end
end

return Zone