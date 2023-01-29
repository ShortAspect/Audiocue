local function e(props)
	local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
	local Packages = script.Parent.Parent.Packages
	local StudioComponents = Packages.StudioComponents
	local themeProvider = require(StudioComponents.Util.themeProvider)
	-- Import important data
	local Fusion = require(Plugin:FindFirstChild("Fusion", true))
	local New, Children, OnEvent, Value, Spring, Computed, Tween =
		Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween
	local OnChange = Fusion.OnChange
	local ForValues = Fusion.ForValues
	local Ref = Fusion.Ref
	-- Import Fusion
	local Size = Value(UDim2.fromScale(1, 1))
	local TopColor = Value(Color3.fromRGB(53, 53, 53))
	local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local ColorBone = Value(1)

	local NormalColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.Titlebar)
	local HoldColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainBackground)

	local count = 0

	-- Data for Button

	for i, v in pairs(props.Dropdown) do
		count = count + 1
	end

	local ContainerWidth = ((count * 13) + 10) + 5

	local ContainerSize = Value(UDim2.fromOffset(57, ContainerWidth))

	local mouseInFrame = false

	local MainToggle = Value(false)
	local containerVisble = Value(false)
	local framePadding = 5
	local Button = Value()

	local bounds = Instance.new("TextLabel")
	bounds.Parent = game.ServerStorage
	bounds.Text = tostring(props.Title)
	bounds.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	bounds.TextSize = 17
	bounds.Size = UDim2.fromScale(0.0521, 1)
	bounds.BackgroundTransparency = 1

	local size = bounds.TextBounds

	bounds:Destroy()

	-- Functions to prepare

	local Buttons = ForValues(props.Dropdown, function(v) -- Make a list for Container
		return New("TextButton")({
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
			[OnEvent("MouseButton1Down")] = function()
				v.Function()
			end,
		})
	end, Fusion.cleanup)

	return {
		New("Frame")({
			[Ref] = Button,
			Name = "Frame",
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0, size.X + framePadding, 1, 0),
			[Children] = {
				New("Frame")({
					Name = "Frame",
					BackgroundColor3 = Color3.fromRGB(53, 181, 255),
					Size = UDim2.fromScale(1, 0.0513),
					BackgroundTransparency = Tween(ColorBone, info),
					ZIndex = 2,
				}),
				New("Frame")({
					Name = "Color",
					BackgroundColor3 = Tween(TopColor, info),
					Size = Tween(Size, info),
				}),
				New("Frame")({
					Name = "Objects",
					Visible = false,
					BackgroundColor3 = Color3.fromRGB(31, 31, 31),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.0701, 1.18),
					Size = ContainerSize,

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
						-- TopImage:set(true)
						for i, v: Frame in pairs(Button:get().Parent:GetDescendants()) do
							if v.Name == "Objects" then
								if v.Visible == true then
									v.Visible = false
								end
							end
						end
						MainToggle:set(true)
						ColorBone:set(0)
						Size:set(UDim2.fromScale(1, 1.03))
						TopColor:set(HoldColor:get())

						local ButtonTemp = Button:get()

						ButtonTemp.Objects.Visible = true
					end,
					[OnEvent("MouseLeave")] = function()
						-- Off function
						-- TopImage:set(false)

						MainToggle:set(false)
						ColorBone:set(1)
						Size:set(UDim2.fromScale(1, 1))
						TopColor:set(NormalColor:get())
					end,
				}),
			},
		}),
	}
end

return e
