local Player = {}
Player.__index = Player

NewImage("player")

function Player:new(data)
    local o = setmetatable({}, self)
    o.x = data.x
    o.y = data.y
    o.w = Image.player:getWidth()
    o.h = Image.player:getHeight()

    o.mx = 0
    o.cbs = {
        x = function (other)
            o:cb_x(other)
        end
    }

    if not Edit.editing then
        Camera:offset(Res.w/2, Res.h/2)
        Camera:set(o.x+o.w/2, o.y+o.h/2)
        Camera:snap_back()
    end

    return o
end

function Player:cb_x(other)
    Physics.solve_x(self, self.mx, other)
end

function Player:update(dt)
    Camera:set(self.x+self.w/2, self.y+self.h/2)
    local ix = 0
    if Input.right.down then
        ix = ix+1
    end
    if Input.left.down then
        ix = ix-1
    end
    self.mx = ix*2*dt
    self.x = self.x+self.mx
    Physics.col_tiles(self, self.cbs.x)
end

function Player:draw()
    love.graphics.draw(Image.player, self.x, self.y)
end

return Player