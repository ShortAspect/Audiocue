local Packages = script.Parent.Parent.Packages
local UI = script.Parent
local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))
local New, Children, OnEvent, Value, Spring, Computed, Tween =
	Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween
local StudioComponents = Packages.StudioComponents
local list = {}

local Frame = require(StudioComponents.Background)
local Loading = require(StudioComponents.Loading)
local ClassIcon = require(StudioComponents.ClassIcon)
local themeProvider = require(StudioComponents.Util.themeProvider)
local Project

local CustomButton = require(UI:FindFirstChild("Button"))
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

					CustomButton({
						Title = "File",
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
				},
			}),
			New("Frame")({

				Name = "Holder",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0, 0.0352),
				Size = UDim2.fromScale(1, 0.965),
				BackgroundTransparency = 1,
				[Children] = {
					New("UIListLayout")({
						Name = "UIListLayout",
						Padding = UDim.new(0, 2),
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder,
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
