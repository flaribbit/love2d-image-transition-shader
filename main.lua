local newImage=love.graphics.newImage
local setShader=love.graphics.setShader
local rect=love.graphics.rectangle
local draw=love.graphics.draw

local imgTransition=newImage("transition.png")
local imgList={
    newImage("1.jpg"),
    newImage("2.jpg"),
}

local shader=love.graphics.newShader[[
extern float time;
const float dw=1./64;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    texture_coords.x+=.05*sin(floor(texture_coords.y/dw)*dw*10+time);
    if(texture_coords.x<0 || texture_coords.x>1){
        return vec4(0.);
    }
    return Texel(texture, texture_coords);
}
]]

local Frames=0

function love.load()
    -- shader:send("imgTransition",imgTransition)
    print(shader)
end

function love.update()
    Frames=Frames+1
end

function love.draw()
    setShader(shader);
    shader:send("time",Frames/30)
    draw(imgList[2],0,0,0,720/1080)
    setShader()
end
