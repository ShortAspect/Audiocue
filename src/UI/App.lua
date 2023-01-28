local Packages = script.Parent.Parent.Packages
local UI = script.Parent
local Fusion = require(Packages.Fusion)
local New, Children = Fusion.New, Fusion.Children
local StudioComponents = Packages.StudioComponents
local list = {}

local Frame = require(StudioComponents.Background)
local Button = require(StudioComponents.Button)
local Label = require(StudioComponents.Label)

local CustomButton = require(UI:FindFirstChild("Button"))

function list:Init(props)
	return Frame({
		Parent = props.Parent,
		[Children] = {
			New("Frame")({
				Name = "TopBar",
				BackgroundColor3 = Color3.fromRGB(53, 53, 53),
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
					}),
					CustomButton({
						Title = "Track",
					}),
				},
			}),
		},
	})
end

return list
