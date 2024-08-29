local cam

function CreateCam(ped)
    local coords = GetEntityCoords(ped, true)
    local x, y, z = coords.x + GetEntityForwardX(ped) * 1.2, coords.y + GetEntityForwardY(ped) * 1.2, coords.z + 0.52
    local camRot = GetEntityRotation(ped, 2)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, camRot.x, camRot.y, camRot.z + 181.0, GetGameplayCamFov(), false, 0)

    SetCamActive(cam, true)
    RenderScriptCams(true, true, Config.transitionTime, true, true)
    Wait(Config.transitionTime - 500)
end

function DestroyCamera()
    RenderScriptCams(false, true, Config.transitionTime, true, false)
    DestroyCam(cam, false)
end