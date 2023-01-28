local function e(props)
	local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
	local Fusion = require(Plugin:FindFirstChild("Fusion", true))
	local New, Children, OnEvent, Value, Spring, Computed, Tween =
		Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween

	local TopImage = Value(false)
	local Size = Value(UDim2.fromScale(0.0521, 1))
	local ColorX = Value(Color3.fromRGB(53, 53, 53))

	return {
		New("Frame")({
			Name = "Frame",
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.0521, 1),
			[Children] = {
				New("Frame")({
					Name = "Frame",
					BackgroundColor3 = Color3.fromRGB(53, 181, 255),
					Size = UDim2.fromScale(1, 0.0513),
					Visible = TopImage,
					ZIndex = 2,
				}),
				New("Frame")({
					Name = "Color",
					BackgroundColor3 = ColorX,
					Size = UDim2.fromScale(1, 1),
				}),
				New("TextButton")({
					Name = "TextLabel",
					Text = props.Title,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
					TextColor3 = Color3.fromRGB(178, 178, 178),
					TextSize = 17,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					[OnEvent("MouseEnter")] = function()
						-- On function
						TopImage:set(true)
						Size:set(UDim2.fromScale(0.0521, 1.03))
						ColorX:set(Color3.fromRGB(46, 46, 46))
					end,
					[OnEvent("MouseLeave")] = function()
						-- Off function
						TopImage:set(false)
						Size:set(UDim2.fromScale(0.0521, 1))
						ColorX:set(Color3.fromRGB(53, 53, 53))
					end,
				}),
			},
		}),
	}
end

return e
