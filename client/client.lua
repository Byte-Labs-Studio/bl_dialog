--- @class Button
--- @field label string
--- @field id string|number? (optional)
--- @field onSelect function? (optional)
--- @field close boolean? (optional)
--- @field nextDialog string? (optional)

--- @class dialog
--- @field job string
--- @field id string
--- @field ped number?
--- @field name string
--- @field text string
--- @field buttons Button[]

local dialogPromise = {}
--- @type dialog[]
local currentDialog = {}
--- @type number
local currentDialogId = 0

local function cleanFunction(filter)
    for _, v in ipairs(filter) do
        v.onSelect = nil
        v.nextDialog = nil
    end

    return filter
end

local function findDialogById(id)
    for k, v in ipairs(currentDialog) do
        if v.id == id then
            return Utils.table_deepclone(v), k
        end
    end
end

local function switchDialog(id)
    local dialog, index = findDialogById(id)
    assert(dialog, 'Dialog with id:' .. id .. ' doesnt exist')

    currentDialogId = index
    dialog.buttons = cleanFunction(dialog.buttons)
    Utils.sendNUIEvent('dialog:show', dialog)
end

exports('switchDialog', switchDialog)

local function showDialog(data)
    assert(data and data.dialog, 'dialog data is invalid!')

    LocalPlayer.state.isDialogOpen = true

    SetTimeout(Config.transitionTime, function()
        if LocalPlayer.state.isDialogOpen then
            SetEntityAlpha(PlayerPedId(), 0, true)
        end
    end)

    if data.ped then
        CreateCam(data.ped)
    end

    currentDialog = data.dialog
    currentDialogId = 1

    local initialDialog = Utils.table_deepclone(data.dialog[1])
    initialDialog.buttons = cleanFunction(initialDialog.buttons)

    dialogPromise = promise:new()
    Utils.sendNUIEvent('resource:visible', true)
    Utils.sendNUIEvent('dialog:show', initialDialog)
    SetNuiFocus(true, true)
    return Citizen.Await(dialogPromise)
end

exports('showDialog', showDialog)

local function hideDialog(resolveData)
    ResetEntityAlpha(PlayerPedId())
    LocalPlayer.state.isDialogOpen = false
    Utils.sendNUIEvent('resource:visible', false)
    SetNuiFocus(false, false)
    dialogPromise:resolve(resolveData)
    dialogPromise = nil
    DestroyCamera()
end

RegisterNUICallback('resource:close', function(_, cb)
    hideDialog(nil)
    cb(1)
end)

RegisterNUICallback('dialog:click', function(data, cb)
    if not dialogPromise then
        cb(1)
        return
    end

    local index = data.index
    local button = currentDialog[currentDialogId] and currentDialog[currentDialogId].buttons[index]

    if not button then
        cb(1)
        return
    end

    if button.close then
        hideDialog(data.id or index)
    end

    if button.onSelect then
        button.onSelect(switchDialog)
    end

    local nextId = button.nextDialog
    if nextId then
        switchDialog(nextId)
    end

    cb(1)
end)
