local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))
local New, Children, OnEvent, Value, Spring, Computed, Tween =
	Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween

local Root = script.Parent.Parent.Parent
local MetaData = require(Root.Metadata)
local StudioComponents = Root.Packages.StudioComponents
local themeProvider = require(StudioComponents.Util.themeProvider)
local PluginName = MetaData.Name
local image = MetaData.Icons.HiRes
local License = MetaData.Liecense
local CurrentYear = os.date("%Y", os.time())
local Version = MetaData.Version

local TextColor = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainText)

local function e(props)
	return New("Frame")({
		Name = "Frame",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainBackground),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(239, 306),
		Parent = props.Parent,
		[Children] = {
			New("ImageLabel")({
				Name = "ImageLabel",
				Image = image,
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, 0, 0.0148, 5),
				Size = UDim2.fromOffset(86, 86),

				[Children] = {
					New("UIAspectRatioConstraint")({
						Name = "UIAspectRatioConstraint",
					}),
				},
			}),
			New("Folder")({
				Name = "Titles",
				[Children] = {
					New("TextLabel")({
						Name = "PluginName",
						FontFace = Font.new(
							"rbxasset://fonts/families/SourceSansPro.json",
							Enum.FontWeight.Bold,
							Enum.FontStyle.Normal
						),
						Text = PluginName,
						TextColor3 = TextColor,
						TextSize = 20,
						TextWrapped = true,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(0.5, 0.311),
						Size = UDim2.fromOffset(103, 25),
					}),
					New("TextLabel")({
						Name = "Libraries",
						FontFace = Font.new(
							"rbxasset://fonts/families/SourceSansPro.json",
							Enum.FontWeight.Bold,
							Enum.FontStyle.Normal
						),
						Text = "Libraries",
						TextColor3 = TextColor,
						TextSize = 20,
						TextWrapped = true,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(0.5, 0.541),
						Size = UDim2.fromOffset(103, 25),
					}),
				},
			}),
			New("TextLabel")({
				Name = "LicenseTelling",
				FontFace = Font.new(
					"rbxasset://fonts/families/SourceSansPro.json",
					Enum.FontWeight.Regular,
					Enum.FontStyle.Italic
				),
				Text = `This software is under the {License}`,
				TextColor3 = TextColor,
				TextSize = 15,
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.39),
				Size = UDim2.fromOffset(202, 15),
			}),

			New("TextLabel")({
				Name = "Copyright",
				FontFace = Font.new(
					"rbxasset://fonts/families/SourceSansPro.json",
					Enum.FontWeight.Regular,
					Enum.FontStyle.Italic
				),
				Text = `©{CurrentYear} Milk's Studio`,
				TextColor3 = TextColor,
				TextSize = 15,
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.438),
				Size = UDim2.fromOffset(202, 15),
			}),
			New("TextLabel")({
				Name = "Version",
				FontFace = Font.new(
					"rbxasset://fonts/families/SourceSansPro.json",
					Enum.FontWeight.Regular,
					Enum.FontStyle.Italic
				),
				Text = `Version {Version}v`,
				TextColor3 = TextColor,
				TextSize = 15,
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.49),
				Size = UDim2.fromOffset(202, 15),
			}),
			New("Frame")({ -- Libraries
				Name = "ListOfLibraries",
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.658),
				Size = UDim2.fromOffset(202, 60),

				[Children] = {
					New("UIListLayout")({
						Name = "UIListLayout",
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),

					New("TextLabel")({
						Name = "TextLabel",
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
						Text = "Fusion - Studio Elttob",
						TextColor3 = TextColor,
						TextSize = 15,
						TextXAlignment = Enum.TextXAlignment.Left,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(0.5, 0.4),
						Size = UDim2.fromOffset(202, 15),
					}),

					New("TextLabel")({
						Name = "TextLabel",
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
						Text = "PluginEssentials - boatbomber & mvyasu",
						TextColor3 = TextColor,
						TextSize = 14,
						TextXAlignment = Enum.TextXAlignment.Left,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.fromScale(0.5, 0.4),
						Size = UDim2.fromOffset(202, 15),
					}),
				},
			}),
			New("TextLabel")({
				Name = "IconsFromIcon8",
				FontFace = Font.new(
					"rbxasset://fonts/families/SourceSansPro.json",
					Enum.FontWeight.Bold,
					Enum.FontStyle.Normal
				),
				Text = "Icons from Icon8",
				TextColor3 = TextColor,
				TextSize = 15,
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.899),
				Size = UDim2.fromOffset(202, 15),
			}),
		},
	})
end

return e
