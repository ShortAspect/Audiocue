local function e(props)
	local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
	local Packages = script.Parent.Parent.Packages
	local StudioComponents = Packages.StudioComponents
	local themeProvider = require(StudioComponents.Util.themeProvider)
	local Fusion = require(Plugin:FindFirstChild("Fusion", true))
	local New, Children, OnEvent, Value, Spring, Computed, Tween =
		Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween
	local OnChange = Fusion.OnChange
	local ForValues = Fusion.ForValues
	local themeProvider = require(StudioComponents.Util.themeProvider)
	local TopImage = Value(false)
	local Size = Value(UDim2.fromScale(1, 1))
	local ColorX = Value(Color3.fromRGB(53, 53, 53))
	local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local ColorBone = Value(1)

	local NormalColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.Titlebar)
	local HoldColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainBackground)

	warn(props.Dropdown)
	warn(#props.Dropdown)

	local bg = ((props.Count * 13) + 10) + 5

	local ject = Value(UDim2.fromOffset(57, bg))

	local Buttons = ForValues(props.Dropdown, function(v)
		return New("TextLabel")({
			Name = "TextLabel",
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 13,
			Text = v.Text,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(36, 13),
		})
	end, Fusion.cleanup)

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
					-- Visible = TopImage,
					BackgroundTransparency = Tween(ColorBone, info),
					ZIndex = 2,
				}),
				New("Frame")({
					Name = "Color",
					BackgroundColor3 = Tween(ColorX, info),
					Size = Tween(Size, info),
				}),
				New("Frame")({
					Name = "Objects",
					BackgroundColor3 = Color3.fromRGB(31, 31, 31),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.0701, 1.18),
					Size = ject,

					[Children] = {
						Buttons,
						New("UIListLayout")({
							Name = "UIListLayout",
							Padding = UDim.new(0, 5),
							SortOrder = Enum.SortOrder.LayoutOrder,
						}),

						New("UIPadding")({
							Name = "UIPadding",
							PaddingBottom = UDim.new(0, 5),
							PaddingLeft = UDim.new(0, 5),
							PaddingRight = UDim.new(0, 5),
							PaddingTop = UDim.new(0, 5),
						}),
					},
				}),
				New("TextButton")({
					Name = "ClickButton",
					Text = props.Title,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
					TextColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.ButtonText),
					TextSize = 17,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),

					-- [OnEvent("Activated")] = function()
					-- 	if props.Function then
					-- 		props.Function()
					-- 	end
					-- end,
					[OnEvent("MouseEnter")] = function()
						-- On function
						TopImage:set(true)
						ColorBone:set(0)
						Size:set(UDim2.fromScale(1, 1.03))
						ColorX:set(HoldColor:get())
					end,
					[OnEvent("MouseLeave")] = function()
						-- Off function
						TopImage:set(false)
						ColorBone:set(1)
						Size:set(UDim2.fromScale(1, 1))
						ColorX:set(NormalColor:get())
					end,
				}),
			},
		}),
	}
end

return e
