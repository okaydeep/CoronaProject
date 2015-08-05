-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

system.activate("multitouch")

local function pointDist( pointA, pointB )
	
end

local beginPosX, beginPosY

local group = display.newGroup()

-- populate display group with objects
local rect = display.newRect( group, 200, 200, 200, 100 )
rect:setFillColor(0,0,255)

rect = display.newRect( group, 300, 300, 200, 100 )
rect:setFillColor(0,255,0)

rect = display.newRect( group, 100, 400, 200, 100 )
rect:setFillColor(255,0,0)

local controller
controller = display.newRect( 600, 1000, 200, 200)
controller:setFillColor(255,255,0)
controller.rotation = 45

function touch(self, e)
	-- get the object which received the touch event
	local target = e.target
	local phase = e.phase
	local distX
	local distY
	-- handle began phase of the touch event life cycle...
	if (phase == "began") then
		beginPosX = group.x
		beginPosY = group.y
		-- we handled the began phase
		return true
	elseif (phase == "moved") then		
		distX = e.x - e.xStart
		distY = e.y - e.yStart
		group.x = beginPosX + distX
		group.y = beginPosY + distY		
	else -- "ended" and "cancelled" phases			

	end
	
	-- if the target is not responsible for this touch event return false
	return false
end

-- attach pinch zoom touch listener
controller.touch = touch

-- listen for touches starting on the touch object
controller:addEventListener("touch")

local oriRefPointX, oriRefPointY

local function sceneScale()

	for i=1, #group do
		group[i]:scale(2, 2)
	end
end

Runtime:addEventListener( "enterFrame", sceneScale )
