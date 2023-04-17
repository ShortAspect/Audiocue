local DefaultErrors = {}

DefaultErrors.MaidObjectNotVaild = function(target: string)
	if target then
		warn(`Prop 'Maid' is not a valid Maid Object. Target is {target}`)
	else
		warn(`Prop 'Maid' is not a valid Maid Object. Target was not given`)
	end
end

return DefaultErrors
