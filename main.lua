-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

system.activate("multitouch")

local function pointDist( pointA, pointB )
	
end

local beginTouchPosX, beginTouchPosY

local group = display.newGroup()

-- populate display group with objects
local rect = display.newRect( group, 200, 200, 200, 100 )
rect:setFillColor(0,0,255)

rect = display.newRect( group, 300, 300, 200, 100 )
rect:setFillColor(0,255,0)

rect = display.newRect( group, 100, 400, 200, 100 )
rect:setFillColor(255,0,0)

function touch(self, e)
	-- get the object which received the touch event
	local target = e.target	
	
	-- get reference to self object
	local rect = self
	
	-- handle began phase of the touch event life cycle...
	if (e.phase == "began") then
		beginTouchPosX = e.xStart
		beginTouchPosY = e.yStart

		-- we handled the began phase
		return true

	elseif (e.phase == "moved") then
		local movX = e.x - beginTouchPosX
		local movY = e.y - beginTouchPosY		
		group.x = group.x + movX
		group.y = group.y + movY
		-- beginTouchPosX = target.x
		-- beginTouchPosY = target.y			
	else -- "ended" and "cancelled" phases			

	end
	
	-- if the target is not responsible for this touch event return false
	return false
end

-- attach pinch zoom touch listener
group.touch = touch

-- listen for touches starting on the touch object
group:addEventListener("touch")

local oriRefPointX, oriRefPointY

local function sceneScale()

	for i=1, #group do
		group[i]:scale(2, 2)
	end
end

Runtime:addEventListener( "enterFrame", sceneScale )
