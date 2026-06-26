local Player = Object:extend()

Player:implement(require("objects.player.movement"))
Player:implement(require("objects.player.draw"))
Player:implement(require("objects.player.collision"))

NewImage("player")

function Player:new(data)
    self.x = data.x
    self.y = data.y
    self.w = Image.player:getWidth()
    self.h = Image.player:getHeight()

    -- self:init_collision()
    self:init_draw()
    self:init_movement()
    
    self.trail_timer = Timer(3)
end

function Player:init()
    self.cam_x = self.x+self.w/2
    self.cam_y = self.y+self.h/2
    self:init_collision()
    Camera:offset(Res.w/2, Res.h/2)
    Camera:set(self.cam_x, self.cam_y)
    Camera:snap_back()
end

function Player:update(dt)
    -- follow player
    self.cam_x = self.x+self.w/2
    self.cam_y = self.y+self.h/2
    
    self:update_collision(dt)
    self:update_draw(dt)
    self:update_movement(dt)

    -- set camera after collision
    Camera:set(self.cam_x, self.cam_y)
end

function Player:draw()
    self:draw_draw()
end

return Player