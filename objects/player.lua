local Player = Object:extend()

NewImage("player")

function Player:new(data)
    self.x = data.x
    self.y = data.y
    self.w = Image.player:getWidth()
    self.h = Image.player:getHeight()

    self.mx = 0
    self.cbs = {
        x = function (other)
            self:cb_x(other)
        end
    }

    if not Edit.editing then
        Camera:offset(Res.w/2, Res.h/2)
        Camera:set(self.x+self.w/2, self.y+self.h/2)
        Camera:snap_back()
    end
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
    Physics.move_and_col(self, self.mx, 0, self.cbs.x)
end

function Player:draw()
    love.graphics.draw(Image.player, self.x, self.y)
end

return Player