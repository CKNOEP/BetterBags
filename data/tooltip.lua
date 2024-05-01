local addonName = ... ---@type string

---@class BetterBags: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class (exact) TooltipInfo
---@field guid string
---@field package raw TooltipData
local tooltipProto = {}

---@class (exact) Tooltip: AceModule
local tooltip = addon:NewModule('Tooltip')

---@param guid string
---@return TooltipInfo
function tooltip:New(guid)
  local tooltipInfo = setmetatable({}, { __index = tooltipProto }) --[[@as TooltipInfo]]
  tooltipInfo.guid = guid

  repeat
    tooltipInfo.raw = C_TooltipInfo.GetItemByGUID(guid)
  until tooltipInfo.raw ~= nil

  return tooltipInfo
end
