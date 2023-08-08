export type data = {
	Title: string,
}
local function e(props: data)
	local TextService = game:GetService("TextService")
	local ServerStorage = game:GetService("ServerStorage")
	local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
	local Packages = script.Parent.Parent.Packages
	local StudioComponents = Packages.StudioComponents
	local Shadow = require(StudioComponents.Shadow)
	local themeProvider = require(StudioComponents.Util.themeProvider)
	local Maid = require(Packages.Maid)
	local DefaultErrors = require(Packages.DefaultErrors)
	local OurMaid = props.Maid
	-- Import Fusion
	local Fusion = require(Plugin:FindFirstChild("Fusion", true))
	local New, Children, OnEvent, Value, Spring, Computed, Tween =
		Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween
	local OnChange = Fusion.OnChange
	local ForValues = Fusion.ForValues
	local Ref = Fusion.Ref
	-- Import important data
	local Size = Value(UDim2.fromScale(1, 1))

	local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local ColorBone = Value(1)
	local NormalColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.Titlebar)
	local HoldColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainBackground)
	local TopColor = Value(Color3.fromRGB(53, 53, 53))
	local ButtonCount = 0

	-- Checking the value of `Maid`

	if not Maid.isMaid(OurMaid) then
		DefaultErrors.MaidObjectNotVaild("Button.lua")
	end

	-- Data for Button

	for i, v in pairs(props.Dropdown) do
		ButtonCount = ButtonCount + 1
	end

	local LayoutOrderCount = 0
	local frameSpacing = 5
	local framePadding = 5 -- Change this for padding
	local ContainerHeight = ButtonCount * 13 + framePadding + framePadding + (ButtonCount - 1) * frameSpacing -- ChatGPT
	--warn(`Debug line ButtonCount {ButtonCount} Height {ContainerWidth}`)

	local mouseInFrame = false
	local MainToggle = Value(false)
	local containerVisble = Value(false)
	local Button = Value()

	-- Finding the bounds of Topbar Button Text Length
	local bounds = Instance.new("TextLabel")
	bounds.Parent = game.ServerStorage
	bounds.Text = tostring(props.Title)
	bounds.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	bounds.TextSize = 17
	bounds.Size = UDim2.fromScale(0.0521, 1)
	bounds.BackgroundTransparency = 1

	local dataTopLabel = Instance.new("GetTextBoundsParams")
	dataTopLabel.Text = props.Title
	dataTopLabel.Font = Font.new("rbxasset://fonts/families/SourceSansPro.json")

	local size = bounds.TextBounds
	bounds:Destroy()

	-- Initialize a variable to hold the highest LayoutOrder value
	local textBondsList = {}

	local Buttons = ForValues(props.Dropdown, function(v) -- Makes button for a list.
		LayoutOrderCount = LayoutOrderCount + 1
		local TextScaled = false

		local m = Instance.new("TextButton")
		m.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
		m.TextColor3 = Color3.fromRGB(255, 255, 255)
		m.TextSize = 13
		m.TextScaled = false
		m.Text = v.Text
		m.TextWrapped = false
		m.TextXAlignment = Enum.TextXAlignment.Left
		m.TextYAlignment = Enum.TextYAlignment.Top
		m.AutoButtonColor = false
		m.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		m.BackgroundTransparency = 1
		m.BorderColor3 = Color3.fromRGB(0, 0, 0)
		m.BorderSizePixel = 0
		m.Size = UDim2.new(1, 0, 0, 15)
		m.Parent = ServerStorage

		table.insert(textBondsList, m.TextBounds.X)

		m:Destroy()

		local buttonObject = New("TextButton")({
			Name = LayoutOrderCount,
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			TextColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.ButtonText),
			TextSize = 13,
			TextScaled = TextScaled,
			Text = v.Text,
			TextWrapped = false,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			LayoutOrder = v.LayoutOrder,
			Size = UDim2.new(1, 0, 0, 15),
			ZIndex = 2,
			[OnEvent("MouseButton1Down")] = function()
				v.Function()
			end,
		})
		return buttonObject
	end, Fusion.cleanup)

	-- Find the mean of all the buttons X text bounds

	local meanBounds = 0
	for i, v in pairs(textBondsList) do
		meanBounds = meanBounds + v
	end

	local ContainerSize = Value(UDim2.fromOffset(((meanBounds / #textBondsList) + 25) * 1.3, ContainerHeight))

	return {
		New("Frame")({
			[Ref] = Button,
			Name = props.Title,
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
					BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.FilterButtonHover),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.0701, 1.18),
					ZIndex = 2,
					Size = ContainerSize,

					[Children] = {
						New("Frame")({
							Size = UDim2.new(1, 0, 1, 0),
							BackgroundTransparency = 1,
							[Children] = {
								Buttons,
								New("UIListLayout")({
									Name = "UIListLayout",
									Padding = UDim.new(0, 3),
									SortOrder = Enum.SortOrder.LayoutOrder,
								}),

								New("UIPadding")({
									Name = "UIPadding",
									PaddingLeft = UDim.new(0, 5),
									PaddingTop = UDim.new(0, 5),
								}),
							},
						}),
						Shadow({}),
					},
				}),
				New("TextButton")({ -- Topbar Button
					Name = "ClickButton",
					Text = props.Title,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
					TextColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.ButtonText),
					TextSize = 17,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					[OnEvent("MouseEnter")] = function() -- On function
						for _, v: Frame in pairs(Button:get().Parent:GetDescendants()) do
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
					[OnEvent("MouseLeave")] = function() -- Off function
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
