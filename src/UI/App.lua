local Packages = script.Parent.Parent.Packages
local Fusion = require(Packages.Fusion)
local New, Children = Fusion.New, Fusion.Children
local StudioComponents = Packages.StudioComponents
local list = {}

local Frame = require(StudioComponents.Background)
local Button = require(StudioComponents.Button)
local Label = require(StudioComponents.Label)

local ButtonFix = function(props)
	return New("Frame")({
		Size = UDim2.fromOffset(80, 30),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		[Children] = {
			New("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 5),
			}),
		},
	})
end

function list:Init(props)
	return Frame({
		Parent = props.Parent,
		[Children] = {
			New("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 3),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
				PaddingTop = UDim.new(0, 3),
			}),
			New("Frame")({
				Size = UDim2.new(1, 0, 0, 30),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromOffset(0, 570),
				Name = "Holder",
				BackgroundTransparency = 1,
				[Children] = {
					New("UIListLayout")({
						Name = "UIListLayout",
						Padding = UDim.new(0, 2),
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					ButtonFix({
						Label = "First",
					}),
					ButtonFix({
						Label = "Second",
					}),
				},
			}),
		},
	})
end

return list
