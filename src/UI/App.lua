local Packages = script.Parent.Parent.Packages
local UI = script.Parent
local Fusion = require(Packages.Fusion)
local New, Children, OnEvent, Value, Spring, Computed, Tween =
	Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween
local StudioComponents = Packages.StudioComponents
local list = {}

local Frame = require(StudioComponents.Background)
local Loading = require(StudioComponents.Loading)
local ClassIcon = require(StudioComponents.ClassIcon)
local themeProvider = require(StudioComponents.Util.themeProvider)

local CustomButton = require(UI:FindFirstChild("Button"))

function list:Init(props)
	return Frame({
		Parent = props.Parent,
		[Children] = {
			New("Frame")({
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
									print("Raw")
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
		},
	})
end

return list
