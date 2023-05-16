The plugin exports projects with two files

More info coming soon as the plugin is being made right now.

## Dialog

When exported the plugin exports a module script into ReplicatedStorage
The module script should look like this
:material-information-outline:{ title="This might changed in the future." }

```lua title="ProjectName.lua"
--!strict
export type MessageData = {
	type: string,
	data: () -> nil | string,
}

return {
	{
		["type"] = "dialog",
		["data"] = "I wonder what kind of reflection I'll see in that mirror.",
		["functionType"] = "none",
		["isFunction"] = false,
		["run"] = nil,
	},
	{
		["type"] = "dialog",
		["data"] = "This should be here after running that function.",
		["functionType"] = "none",
		["isFunction"] = false,
		["run"] = nil,
	},
}

```
