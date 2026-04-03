Class = require("modules.hump.class")

Physics = require("objects.physics")
Particle = require("objects.particle")
require("stuff.camera")
require("stuff.input")
require("stuff.res")
require("stuff.sm")
require("stuff.utils")
require("stuff.log")
require("stuff.audio")

function love.load()
    LogFont = love.graphics.newFont(20)
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")

    Font = love.graphics.newFont("assets/fonts/Galmuri9.ttf", 10)
    TILE_SIZE = 16

    -- NewAudio("jump")

    Res:init()
    
    SM:load("game.game")
    
    UpdateTargetFPS()
end

function love.update(dt)
    local target_dt = 1/TargetFPS/2
    if dt < target_dt then
        love.timer.sleep(target_dt-dt)
    end
    dt = math.min(dt*60, 1.5)
    UpdateInputs()
    Camera:update(dt)
    SM:update(dt)
    ResetWheelInput()
    UpdateLog(dt)
end

function love.draw()
    Res:before()
    SM:draw()
    Res:after()
    DrawLog()
    if CONSOLE then
        love.graphics.print(tostring(love.timer.getFPS()))
    end
end