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
   instance.border_padding_left = 0
   instance.border_padding_right = 0
   instance.border_padding_top = 0
   instance.border_border_padding_bottom = 0
   instance.scale_to_window = false
   instance.text_queue = {}

   return instance
end

function LoveBox:update(dt)
   if self.scale_to_window then
      self:setPositionY(love.graphics.getHeight() - self:getHeight())
      self:setWidth(love.graphics.getWidth() - self.border_padding_right)
   end
end

function LoveBox:draw()
   love.graphics.setColor(self.bg_r, self.bg_g, self.bg_b, 1)
   love.graphics.rectangle("fill", self:getPositionX() + self.border_padding_left,
                                   self:getPositionY() + self.border_padding_top,
                                   self:getWidth() - self.border_padding_right,
                                   self:getHeight() - (self.border_padding_bottom * 2))
   if self:queueLength() > 0 then
      --Fix this to use text border_padding and not border border_padding
      love.graphics.setColor(255/255, 255/255, 255/255, 1)
      love.graphics.print(self.text_queue[1], self:getPositionX() + self.border_padding_left,
                                         self:getPositionY() + self.border_padding_top)
   end
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

function LoveBox:setBorderPaddingLeft(border_padding_left)
   self.border_padding_left = border_padding_left
end

function LoveBox:setBorderPaddingRight(border_padding_right)
   self.border_padding_right = border_padding_right
end

function LoveBox:setBorderPaddingTop(border_padding_top)
   self.border_padding_top = border_padding_top
end

function LoveBox:setBorderPaddingBottom(border_padding_bottom)
   self.border_padding_bottom = border_padding_bottom
end

function LoveBox:setBorderPadding(border_padding_all)
   self:setBorderPaddingLeft(border_padding_all)
   self:setBorderPaddingRight(border_padding_all)
   self:setBorderPaddingTop(border_padding_all)
   self:setBorderPaddingBottom(border_padding_all)
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

function LoveBox:printSimple(text)
   self:queueTextLine(text)
end

function LoveBox:queueLength()
   local length = 0
   for _ in pairs (self.text_queue) do
      length = length + 1
   end
   return length
end

--Stages a line of text to be rendered in the textbox
function LoveBox:queueTextLine(text)
   table.insert(self.text_queue, text)
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
