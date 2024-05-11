local addonName = ... ---@type string

---@class BetterBags: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class (exact) SectionSort: AceModule
---@field _pool ObjectPool
---@field sectionSortProto SectionSortFrame
local sectionSort = addon:NewModule('SectionSort')

---@class (exact) SectionSortFrame
---@field package frame Frame
---@field package title FontString
sectionSort.sectionSortProto = {}

function sectionSort.sectionSortProto:Show()
  self.frame:Show()
end

function sectionSort.sectionSortProto:Hide()
  self.frame:Hide()
end

function sectionSort.sectionSortProto:Release()
  sectionSort._pool:Release(self)
end

---@return Frame
function sectionSort.sectionSortProto:GetFrame()
  return self.frame
end

function sectionSort.sectionSortProto:SetTitle(title)
  self.title:SetText(title)
end

function sectionSort:OnInitialize()
  self._pool = CreateObjectPool(self._OnCreate, self._OnReset)
  self._pool:SetResetDisallowedIfNew(true)
end

---@private
---@return SectionSortFrame
function sectionSort:_OnCreate()
  local sectionSortFrame = setmetatable({}, {__index = sectionSort.sectionSortProto})

  local frame = CreateFrame('Frame', nil, UIParent, "TooltipBorderedFrameTemplate") --[[@as Frame]]
  frame:SetSize(200, 140)
  frame:Hide()
  sectionSortFrame.frame = frame

  local title = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
  title:SetPoint('TOP', 0, -5)
  sectionSortFrame.title = title
  return sectionSortFrame
end

---@private
---@param s SectionSortFrame
function sectionSort:_OnReset(s)
  s.frame:SetParent(nil)
  s:Hide()
end

---@return SectionSortFrame
function sectionSort:Create()
  return self._pool:Acquire()
end
