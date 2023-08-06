local Self = script
local RunService = game:GetService("RunService")
local StudioService = game:GetService("StudioService")
local Packages = Self.Parent.Packages
local Plugin = Self:FindFirstAncestorWhichIsA("Plugin")
local Utils = Self.Parent.Utils
local PluginComponents = Packages.PluginComponents
local Toolbar = require(PluginComponents.Toolbar)
local ToolbarButton = require(PluginComponents.ToolbarButton)
local Widget = require(PluginComponents.Widget)
local App = require(Self.App)
local Maid = require(Packages.Maid)
local MaidCore = Maid.new()

if RunService:IsStudio() and RunService:IsRunMode() then
end

local AppTitle = "Audiocue"

local PluginBar = Toolbar({
	Name = AppTitle,
})

local Button = ToolbarButton({
	Toolbar = PluginBar,
	ToolTip = "Toggle Menu",
	Name = "Open",
	Image = "rbxassetid://13548900880",
})

local WidgetGUI: DockWidgetPluginGui = Widget({
	Id = "Audiocue_MainWindow",
	InitialEnabled = false,
	InitialDockTo = Enum.InitialDockState.Float,
	ForceInitialEnabled = true,
	Name = AppTitle,
	FloatingSize = Vector2.new(800, 490),
	MinimumSize = Vector2.new(700, 490),
})
-- WidgetGUI.Name = AppTitle

App:Init({
	Parent = WidgetGUI,
	Maid = MaidCore,
	Title = AppTitle,
	PluginEvent = plugin.Unloading,
})

MaidCore:GiveTask(Button.Click:Connect(function()
	WidgetGUI.Enabled = not WidgetGUI.Enabled
end))
MaidCore:GiveTask(plugin.Unloading:Connect(function()
	PluginBar:Destroy()
	Button:Destroy()
	WidgetGUI:Destroy()
	MaidCore:DoCleaning()
end))
