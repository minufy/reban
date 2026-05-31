Game = {}
local GameBase = require("stuff.game_base")
GameBase(Game)

function Game:init()
    Edit:init()
    Level:init("1")
end

function Game:before_reload()
    self:base_reload()
    self.objects = {}
end

function Game:update(dt)
    Edit:update(dt)
    Camera:update(dt)

    if not Edit.editing then
        self.group_names = {}
        for group_name, _ in pairs(self.objects) do
            table.insert(self.group_names, group_name)
        end
        for _, group_name in ipairs(self.group_names) do
            local i = #self.objects[group_name]
            while i > 0 do
                local object = self.objects[group_name][i]
                if object.update then
                    object:update(dt)
                end
                if object.remove then
                    self.lookup[object.key] = nil
                    self.objects[group_name][i] = self.objects[group_name][#self.objects[group_name]]
                    self.objects[group_name][#self.objects[group_name]] = nil
                end
                i = i-1
            end
        end
    end
end

function Game:draw()
    love.graphics.setColor(rgb(49, 77, 121))
    love.graphics.rectangle("fill", 0, 0, Res.w, Res.h)
    Color.reset()
    
    Camera:start()
    Shadow:start()
    
    for group_name, group in pairs(self.objects) do
        for _, object in ipairs(group) do
            if object.draw then
                object:draw()
            end
        end
    end
    
    if Edit.editing then
        Edit:draw()
    end
    
    Camera:stop()

    if Edit.editing then
        Edit:draw_hud()
    end

    Shadow:stop()
end

return Game