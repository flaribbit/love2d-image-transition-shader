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
extern Image imgTransition;
extern float time;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 c=Texel(texture, texture_coords);
    if(time<Texel(imgTransition, texture_coords)[0]){
        c.a=0;
    }
    return c;
}
]]

local Frames=0

function love.load()
    shader:send("imgTransition",imgTransition)
    print(shader)
end

function love.update()
    Frames=Frames+1
    if Frames==360 then
        Frames=0
    end
end

function love.draw()
    if Frames<180 then
        draw(imgList[1],0,0,0,720/1080)
        setShader(shader);
        shader:send("time",Frames/180)
        draw(imgList[2],0,0,0,720/1080)
        setShader()
    elseif Frames<360 then
        draw(imgList[2],0,0,0,720/1080)
        setShader(shader);
        shader:send("time",Frames/180-1)
        draw(imgList[1],0,0,0,720/1080)
        setShader()
    end
end
