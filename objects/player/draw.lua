local Draw = Object:extend()

local bounce_damp = 0.2

function Draw:init_draw()
    self.flip = 1
    self.air_jump_radius = 0
end

function Draw:update_draw(dt)
    local flip = 0
    if Input.right.down then
        flip = flip+1
    end
    if Input.left.down then
        flip = flip-1
    end
    if flip ~= 0 then
        self.flip = flip
    end
    
    self.draw_bounce = self.draw_bounce-self.draw_bounce*bounce_damp*dt
end

function Draw:draw_draw()
    local sx = (1-self.draw_bounce)
    local sy = (1+self.draw_bounce)
    local ox = self.w*(1-self.flip*sx)/2
    local oy = -self.draw_bounce*self.h
    love.graphics.draw(Image.player, self.x+ox, self.y+oy, 0, self.flip*sx, sy)
end

return Draw