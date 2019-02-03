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

   --[[
   Allows the vars that contain instances of this class
   to make the calls in other files. For example, the following
   would fail without returning self:
      local var = LoveBox()
      var:functionInLoveBoxClass()
   ]]
   return self
end

function LoveBox:update()
end

function LoveBox:draw()
end

return LoveBox
