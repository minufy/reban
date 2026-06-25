local Collision = Object:extend()

function Collision:init_collision()
end

function Collision:update_collision(dt)
    
end

function Collision:die()
    for _ = 0, 4 do
        Game:add(Particle, self.x+self.w/2, self.y+self.h/2, math.random(-10, 10), math.random(-10, 10), math.random(6, 12))
    end
    self.remove = true
    Camera:shake(3)
    -- Audio.die:play(1)
end

return Collision