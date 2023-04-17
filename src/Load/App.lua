local Packages = script.Parent.Parent.Packages
local UI = Packages.Parent.UI
local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))
local New, Children, OnEvent, Value, Spring, Computed, Tween =
	Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween
local StudioComponents = Packages.StudioComponents
local list = {}

local Frame = require(StudioComponents.Background)
local Loading = require(StudioComponents.Loading)
local ClassIcon = require(StudioComponents.ClassIcon)
local Shadow = require(StudioComponents.Shadow)
local themeProvider = require(StudioComponents.Util.themeProvider)
local Maid = require(Packages.Maid)
local DefaultErrors = require(Packages.DefaultErrors)
local Project
local OurMaid

local CustomButton = require(UI.MenuButton)
local Ref = Fusion.Ref
local TopBar = Value()

local function closeMenu()
	for i, v: Frame in pairs(TopBar:get():GetDescendants()) do
		if v.Name == "Objects" then
			if v.Visible == true then
				v.Visible = false
			end
		end
	end
end

function list:Init(props)
	OurMaid = props.Maid

	if not Maid.isMaid(OurMaid) then
		DefaultErrors.MaidObjectNotVaild("App.lua")
	end

	return Frame({
		Parent = props.Parent,
		[Children] = {
			New("Frame")({ -- Top Bar?
				[Ref] = TopBar,
				Name = "TopBar",
				BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.Titlebar),
				BorderColor3 = Color3.fromRGB(34, 34, 34),
				Size = UDim2.fromScale(1, 0.0352),

				[Children] = {
					New("UIListLayout")({
						Name = "UIListLayout",
						Padding = UDim.new(0, 2),
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					-- Hello everyone this might be a memory leak right here --->
					CustomButton({ -- Edit this part for new Title Bars
						Title = "File",
						Maid = OurMaid,
						Dropdown = {
							Test = {
								Text = "New",
								Function = function()
									print("New function")
								end,
							},
							Test2 = {
								Text = "Open",
								Function = function()
									print("open Function")
								end,
							},
						},
					}),
					CustomButton({
						Title = "Preview",
						Maid = OurMaid,
						Dropdown = {
							Test = {
								Text = "Display",
								Function = function()
									print("Display")
								end,
							},
							Test2 = {
								Text = "Raw",
								Function = function()
									closeMenu()
								end,
							},
						},
					}),
					CustomButton({
						Title = "Debug",
						Maid = OurMaid,
						Dropdown = {
							-- ViewContent = {
							-- 	Text = "A",
							-- 	Function = function()
							-- 		warn(Plugin:GetChildren()[1]:GetChildren())
							-- 	end,
							-- },
							A = {
								Text = "1234567",
								LayoutOrder = 1,
								Function = function()
									warn(script.Parent)
								end,
							},
						},
					}),
				},
			}),
			New("Frame")({
				Name = "Holder",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0, 0.0352),
				Size = UDim2.fromScale(1, 0.965),
				BackgroundTransparency = 1,
				[Children] = {
					New("Frame")({
						Size = UDim2.fromOffset(200, 200),
						Position = UDim2.fromOffset(50, 10),
						BackgroundColor3 = Color3.fromRGB(85, 170, 127),
						[Children] = {
							Shadow({}),
						},
					}),
				},
			}),
			New("ImageButton")({
				Name = "OffClick",
				BackgroundTransparency = 0.5,
				ImageTransparency = 1,
				Position = UDim2.fromScale(0, 0.0352),
				Size = UDim2.fromScale(1, 0.965),
				ZIndex = 0,
				[OnEvent("MouseButton1Down")] = closeMenu,
			}),
		},
	})
end

return list
