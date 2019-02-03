local LoveBox = {}
local LoveBox_mt = { __index = LoveBox }

setmetatable(LoveBox, {
   --[[
   Allows us to instantiate like:
      local var = LoveBox()
   ]]
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
   local instance = {}
   --[[
   Allows our instances to call the functions of this class
   ]]
   setmetatable (instance, LoveBox_mt)

   --Instance variables
   instance.bg_r = 1
   instance.bg_g = 1
   instance.bg_b = 1
   instance.height = 0
   instance.width = 0
   instance.origin_x = 0
   instance.origin_y = 0
   instance.padding_left = 0
   instance.padding_right = 0
   instance.padding_top = 0
   instance.padding_bottom = 0
   instance.scale_to_window = false

   return instance
end

function LoveBox:update(dt)
   if self.scale_to_window then
      self:setPositionY(love.graphics.getHeight() - self:getHeight())
      self:setWidth(love.graphics.getWidth() - self.padding_right)
   end
end

function LoveBox:draw()
   love.graphics.setColor(self.bg_r, self.bg_g, self.bg_b, 1)
   love.graphics.rectangle("fill", self:getPositionX() + self.padding_left,
                                   self:getPositionY() + self.padding_top,
                                   self:getWidth() - self.padding_right,
                                   self:getHeight() - (self.padding_bottom * 2))
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

function LoveBox:setPaddingLeft(padding_left)
   self.padding_left = padding_left
end

function LoveBox:setPaddingRight(padding_right)
   self.padding_right = padding_right
end

function LoveBox:setPaddingTop(padding_top)
   self.padding_top = padding_top
end

function LoveBox:setPaddingBottom(padding_bottom)
   self.padding_bottom = padding_bottom
end

function LoveBox:setPadding(padding_all)
   self:setPaddingLeft(padding_all)
   self:setPaddingRight(padding_all)
   self:setPaddingTop(padding_all)
   self:setPaddingBottom(padding_all)
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
   self:setPositionX(x)
   self:setPositionY(y)
end

function LoveBox:setRGB(r, g, b)
   self.bg_r = r
   self.bg_g = g
   self.bg_b = b
end

function LoveBox:enableScaleToWindow()
   self.scale_to_window = true

   --Set box to left side of screen
   self:setPositionX(0)
   self:setPositionY(love.graphics.getHeight() - self:getHeight())

   --Extend to rest of window
   self:setWidth(love.graphics.getWidth())
end

function LoveBox:disableScaleToWindow()
   self.scale_to_window = false
end

function LoveBox:toggleScaleToWindow()
   if self.scale_to_window then
      self:disableScaleToWindow()
      return
   end
   self:enableScaleToWindow()
end

return LoveBox
