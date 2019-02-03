local LoveBox = {}

--[[
Allows us to instantiate like:
   local var = LoveBox()
]]--
setmetatable(LoveBox, {
   __call =
   function (cls, ...)
      return cls:new(...)
   end,
   __tostring =
   function ()
      return "I'm a LoveBox!"
   end
})


function LoveBox:new()
   --[[
   Allows constructed objects to call the
   other functions in this class.
   ]]
   self.__index = self

   --Instance variables
   self.bg_r = 1
   self.bg_g = 1
   self.bg_b = 1
   self.box_state = {}
   self.height = 0
   self.width = 0
   self.origin_x = 0
   self.origin_y = 0

   --[[
   Allows the vars that contain instances of this class
   to make the calls in other files. For example, the following
   would fail without returning self:
      local var = LoveBox()
      var:functionInLoveBoxClass()
   ]]
   return self
end

function LoveBox:destroy()
end

function LoveBox:update(dt)
end

function LoveBox:draw()
   love.graphics.setColor(self.bg_r, self.bg_g, self.bg_b, 1)
   love.graphics.rectangle("fill", self.origin_x, self.origin_y,
                                   self.width, self.height)
end

function LoveBox:getHeight()
   return self.height
end

function LoveBox:setHeight(height)
   self.height = height
end

function LoveBox:getWidth()
   return self.width
end

function LoveBox:setWidth(width)
   self.width = width
end

function LoveBox:getPositionX()
   return self.origin_x
end

function LoveBox:getPositionY()
   return self.origin_y
end

function LoveBox:setPositionX(x)
   self.origin_x = x
end

function LoveBox:setPositionY(y)
   self.origin_y = y
end

function LoveBox:setPosition(x, y)
   self.origin_x = x
   self.origin_y = y
end

function LoveBox:setRGB(r, g, b)
   self.bg_r = r
   self.bg_g = g
   self.bg_b = b
end

function LoveBox:setScaleToWindow(value)
   if value == true then
      --Push current box state

      --Set box to left side of screen
      self.origin_x = 0
      self.origin_y = 0

      --Extend to rest of window
      self.width = love.graphics.getWidth()
   end
end

return LoveBox
