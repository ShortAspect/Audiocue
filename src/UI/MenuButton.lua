export type data = {
	Title: string,
}
local function e(props: data)
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
	local TopColor = Value(Color3.fromRGB(53, 53, 53))
	local info = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local ColorBone = Value(1)
	local NormalColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.Titlebar)
	local HoldColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainBackground)
	local ButtonCount = 0

	-- Checking the value of `Maid`

	if not Maid.isMaid(OurMaid) then
		DefaultErrors.MaidObjectNotVaild("Button.lua")
	end

	-- Data for Button

	for i, v in pairs(props.Dropdown) do
		ButtonCount = ButtonCount + 1
	end

	local frameSpacing = 5
	local framePadding = 5 -- Change this for padding
	local ContainerHeight = ButtonCount * 13 + framePadding + framePadding + (ButtonCount - 1) * frameSpacing -- ChatGPT
	--warn(`Debug line ButtonCount {ButtonCount} Height {ContainerWidth}`)
	local ContainerSize = Value(UDim2.fromOffset(57, ContainerHeight))
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

	local size = bounds.TextBounds

	bounds:Destroy()
	--------------------------------------------------

	local Buttons = ForValues(props.Dropdown, function(v) -- Makes button for a list.
		if not v.LayoutOrder then
			v.LayoutOrder = 1
		end

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
			LayoutOrder = v.LayoutOrder,
			Size = UDim2.fromOffset(36, 13),
			ZIndex = 2,
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
					ZIndex = 2,
					Size = ContainerSize,

					[Children] = {
						Buttons,
						New("UIListLayout")({
							Name = "UIListLayout",
							Padding = UDim.new(0, frameSpacing),
							SortOrder = Enum.SortOrder.LayoutOrder,
						}),

						New("UIPadding")({
							Name = "UIPadding",
							PaddingBottom = UDim.new(0, framePadding),
							PaddingLeft = UDim.new(0, framePadding),
							PaddingRight = UDim.new(0, framePadding),
							PaddingTop = UDim.new(0, framePadding),
						}),
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
