Utils = {}

--- Used to send NUI events to the UI
--- @param action string
--- @param data any
function Utils.sendNUIEvent(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

local function table_deepclone(tbl) -- https://github.com/overextended/ox_lib/blob/5ac07d8b887aa2f1e68e5e3bec6497345aff7bbe/imports/table/shared.lua#L59
	tbl = table.clone(tbl)

	for k, v in pairs(tbl) do
		if type(v) == 'table' then
			tbl[k] = table_deepclone(v)
		end
	end

	return tbl
end

Utils.table_deepclone = table_deepclone

return Utils