local function require(module)
	local file = debug.getinfo(1).source
	local directory = file:sub(2,#file-12)
	-- TODO: _FILEDIRECTORY
	return getfenv().require(directory .. module)
end
local tweenObj = require("tween")
local tweens = {}

function tween(obj,properties,time,style)
    table.insert(tweens,tweenObj.new(time,obj,properties,style))
end
function numLerp(a,b,c)
    return a+(b-a)*c
end

local modchartPhases = {
	{step=32,phase=1};
	{step=384,phase=0};
	{step=416,phase=1};
	{step=1184,phase=0};
	{step=1472,phase=1.5};
	{step=2240,phase=1};
	{step=2496,phase=2};
	{step=2784,phase=2.5};
	{step=3640,phase=2};
	{step=3840,phase=3};
	{step=4608,phase=2.5};
	{step=4736,phase=4};
	{step=4880,phase=4.5};
}

table.sort(modchartPhases,function(a,b)
	return a.step<b.step;
end)

function update (elapsed)
    local currentBeat = (songPos/1000)*(bpm/90)
	
    hudX = getHudX()
    hudY = getHudY()
		
		if(curStep>=128 and curStep<=256) then
            for i=0, 13 do
                setActorY(defaultStrum0Y + 15 * math.cos((currentBeat+ i*0.25) * math.pi), i)
				cambeat = true
            end
		elseif(curStep>=256 and curStep<258) or (curStep>=641 and curStep<643) or (curStep>=1281 and curStep<1283) then
		    for i=0,13 do
		    	setActorX(_G['defaultStrum'..i..'X'] + 1 * math.sin(currentBeat) * (math.pi - 0.65), i)
		    	setActorY(_G['defaultStrum'..i..'Y'] - 1 * math.cos(currentBeat) * (math.pi - 0.65), i)
				cambeat = false
				campog = false
		    end		
		elseif(curStep>=384 and curStep<=512) then
		    for i=0,13 do
		    	setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin(currentBeat) + 15, i)
		    	setActorY(_G['defaultStrum'..i..'Y'] + 28 * math.cos(currentBeat) + 25, i)
				campog = true
		    end
		elseif(curStep>512 and curStep<=640) then
		    for i=0,13 do
		    	setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat) * (math.pi * 0.65)) + 5, i)
		    	setActorY(_G['defaultStrum'..i..'Y'] + 28 * math.cos((currentBeat) * (math.pi * 0.65)) + 10, i)
				cambeat = true
		    end
		elseif(curStep>768 and curStep<=896) then
		    for i=0,13 do
		    	setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.1) * math.pi), i)
		    	setActorY(_G['defaultStrum'..i..'Y'] + 28 * math.cos((currentBeat + i*0.1) * math.pi) + 10, i)
				cambeat = true
		    end
		elseif(curStep>897 and curStep<=1024) then
		    for i=0,13 do
		    	setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.1) * math.pi), i)
		    	setActorY(_G['defaultStrum'..i..'Y'] + 28 * math.cos((currentBeat + i*0.1) * math.pi) + 10, i)
				cambeat = true
		    end
		elseif(curStep>1025 and curStep<=1280) then
		    for i=0,13 do
                setActorX(_G['defaultStrum'..i..'X'] + 9 * math.sin((currentBeat + i*0.1) * 9), i)
	            setActorY(_G['defaultStrum'..i..'Y'] + 9 * math.cos((currentBeat + i*0.1) * 9), i)
				cambeat = true
		    end
		end
end


function beatHit (beat)
    if cambeat then
	setCamZoom(1)
	elseif campog then
	setCamZoom(1.25)
	end
end

function stepHit (step)
    
	if curStep == 248 or curStep == 375 or curStep == 696 or curStep == 824 or curStep == 952 or curStep == 1208 then
        for i = 0, 13 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 0.6, 'setDefault')
        end
    end

    if curStep == 16 then
        showOnlyStrums = false
    end
end

function keyPressed (key)
    
end


