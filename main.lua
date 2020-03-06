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
extern float border;
extern float size;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    if(texture_coords.x<border){
        float sx=size*9./16.;
        texture_coords.x=floor(texture_coords.x/sx)*sx;
        texture_coords.y=floor(texture_coords.y/size)*size;
    }
    return Texel(texture, texture_coords);
}
]]

local Frames=0
local border=640
local size=5

function love.load()
    shader:send("border",640/1280)
    shader:send("size",5/720)
    print(shader)
end

function love.update()
    Frames=Frames+1
    if love.keyboard.isDown("left") then
        border=border-2;
    elseif love.keyboard.isDown("right") then
        border=border+2;
    end
    if love.keyboard.isDown("up") then
        size=size+1;
    elseif love.keyboard.isDown("down") then
        size=size-1;
    end
    if border<1 then border=1 elseif border>1280 then border=1280 end
    if size<1 then size=1 elseif size>120 then size=120 end
    shader:send("border",border/1280)
    shader:send("size",size/720)
end

function love.draw()
    setShader(shader);
    draw(imgList[1],0,0,0,720/1080)
    setShader()
end
