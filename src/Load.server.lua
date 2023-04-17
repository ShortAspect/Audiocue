local Packages = script.Parent.Packages
local UI = script.Parent.UI
local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))
local PluginComponents = Packages.PluginComponents

local Toolbar = require(PluginComponents.Toolbar)
local ToolbarButton = require(PluginComponents.ToolbarButton)
local Widget = require(PluginComponents.Widget)
local App = require(UI.App)
local Maid = require(Packages.Maid)
local MaidCore = Maid.new()
local New, Children, OnEvent, Value, Spring, Computed, Tween =
	Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween

local AppTitle = Value("Audiocue")

local PluginBar = Toolbar({
	Name = "Audiocue",
})

local Button = ToolbarButton({
	Toolbar = PluginBar,
	ToolTip = "Opens the UI",
	Name = "Toggle",
	Image = "rbxassetid://12294660975",
})

local WidgetGUI: DockWidgetPluginGui = Widget({
	Id = "Audiocue_Milk",
	InitialEnabled = false,
	InitialDockTo = Enum.InitialDockState.Float,
	ForceInitialEnabled = true,
	Name = AppTitle,
	FloatingSize = Vector2.new(800, 490),
	MinimumSize = Vector2.new(700, 490),
})
WidgetGUI.Name = "Audiocue"

local Frame = App:Init({
	Parent = WidgetGUI,
	Maid = MaidCore,
	Title = AppTitle,
})

local bool = false

local function click()
	WidgetGUI.Enabled = not WidgetGUI.Enabled
end

MaidCore:GiveTask(Button.Click:Connect(click))

MaidCore:GiveTask(plugin.Unloading:Connect(function()
	PluginBar:Destroy()
	Button:Destroy()
	WidgetGUI:Destroy()
	MaidCore:DoCleaning()
end))
