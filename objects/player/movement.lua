local Movement = Object:extend()

local speed = 2.4
local air_speed = 2.6
local gravity = 0.45
local jump_force = 5
local max_vy = 6
local speed_damp = 0.1
local acc_damp = 0.4
local dec_damp = 0.25
local vx_damp = 0.4
local vx_dec = 0.3
local falling = 5
local jump_buffer = 10
local draw_bounce = 0.2

function Movement:init_movement()
    self.mx = 0
    self.vx = 0
    self.vy = 0
    self.falling = 999
    self.jump_buffer = 999
    self.wall_side = 0
    self.col_x = false
    self.gravity = gravity
    self.speed = speed

    self.draw_bounce = 0
    self.walk_timer = Timer(8)

    self.movement_cbs = {
        x = function (other)
            self:cb_x(other)
        end,
        y = function (other)
            self:cb_y(other)
        end,
    }
end

function Movement:cb_x(other)
    Physics.solve_x(self, self.vx+self.mx*self.speed, other)
    self.col_x = true
end

function Movement:cb_y(other)
    Physics.solve_y(self, self.vy, other)
    if self.vy > 0 then
        if self.falling > falling then
            self.draw_bounce = -draw_bounce
            for _ = 0, 4 do
                Game:add(Particle, self.x+self.w/2, self.y+self.h, math.random(-12, 12), math.random(-5, 0), math.random(2, 4), Color.tiles)
            end
            -- Audio.land:play(1)
        end
        self.wall_side = 0
        self.falling = 0
        self.air_jump = false
    end
    self.vy = 0
end

function Movement:update_movement(dt)
    local ix = 0
    if Input.right.down then
        ix = ix+1
    end
    if Input.left.down then
        ix = ix-1
    end

    if self.falling < falling and Input.down.down and self.wall_side == 0 then
        self.draw_bounce = -draw_bounce
        ix = 0
        self.vx = 0
        self.mx = 0
    end

    local target_speed = speed
    if self.falling > falling then
        target_speed = air_speed
    end
    self.speed = self.speed+(target_speed-self.speed)*speed_damp*dt

    if ix == 0 then
        self.mx = self.mx+(ix-self.mx)*dec_damp*dt
    else
        self.mx = self.mx+(ix-self.mx)*acc_damp*dt
    end

    if math.sign(self.vx) == math.sign(self.mx) then
        self.vx = self.vx-self.vx*vx_damp*dt
    else
        self.vx = self.vx-math.sign(self.vx)*vx_dec*dt
    end

    self.x = self.x+(self.vx+self.mx*self.speed)*dt
    self.col_x = false
    Physics.col_tiles(self, self.movement_cbs.x)
    
    self.vy = self.vy+self.gravity*dt
    if self.vy >= max_vy then
        self.vy = max_vy
    end
    self.y = self.y+self.vy*dt
    Physics.col_tiles(self, self.movement_cbs.y)
    self.falling = self.falling+dt
    self.jump_buffer = self.jump_buffer+dt

    if Input.jump.pressed then
        self.jump_buffer = 0
    end
    if self.jump_buffer <= jump_buffer then
        self:jump()
    end
    if Input.jump.down then
        self.gravity = gravity/2
    else
        self.gravity = gravity
    end

    if ix ~= 0 and self.falling <= falling and self.col_x == false then
        if self.walk_timer:run(dt) then
            Game:add(Particle, self.x+self.w/2, self.y+self.h, ix*math.random(0, 10), math.random(-5, 0), math.random(2, 4), Color.tiles)
            -- Audio.walk:play(0.8)
        end
    end
end

function Movement:jump()
    if self.falling <= falling  then
        self.vy = -jump_force
        -- Audio.jump:play(0.9)
        self.draw_bounce = draw_bounce
        self.falling = 999
        self.jump_buffer = 999
        for _ = 0, 4 do
            Game:add(Particle, self.x+self.w/2, self.y+self.h, math.random(-15, 15), math.random(-10, 0), math.random(2, 6), Color.tiles)
        end
    end
end

return Movement