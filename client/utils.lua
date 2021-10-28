QBCore = nil
PlayerData = {}
Citizen.CreateThread(function()
    while QBCore == nil do
        QBCore = exports['qb-core']:GetCoreObject()
        Citizen.Wait(1000)
    end
    while QBCore.Functions == nil do
        Citizen.Wait(0)
    end
    while QBCore.Functions.GetPlayerData() == nil do
        Citizen.Wait(0)
    end
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('ak47_qb_cookies:notify')
AddEventHandler('ak47_qb_cookies:notify', function(msg)
    QBCore.Functions.Notify(msg)
end)

RegisterNetEvent('ak47_qb_cookies:progress')
AddEventHandler('ak47_qb_cookies:progress', function(msg, time)
    QBCore.Functions.Progressbar(msg, msg, time, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done

    end, function()

    end)
end)

function playAnim(dir, anim, blendIn, blendOut, duration, flag, playbackRate)
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(dir)
    while not HasAnimDictLoaded(dir) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(playerPed, dir, anim, blendIn + 0.0, blendOut + 0.0, duration, flag, playbackRate, 0, 0, 0)
end

function GetHeadingFromPoints(a, b)
    if not a or not b then
        return 0.0
    end
    if a.x == b.x and a.y == b.y then
        return 0.0
    end
    if #(a - b) < 1 then
        return 0.0
    end
    local theta = math.atan(b.x - a.x,a.y - b.y)
    if theta < 0.0 then
        theta = theta + (math.pi * 2)
    end
    return math.deg(theta) + 180 % 360
end

function drawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, r, g, b, a, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureDict, textureDict)
	DrawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, r, g, b, a, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureDict, textureDict)
end

function tofloat(value)
    return tonumber(string.format("%.2f", value))
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function DrawText3D(coords, text, size, font)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local camCoords      = GetGameplayCamCoords()
    local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
    local size           = size

    if size == nil then
        size = 1
    end

    local scale = (size / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(font)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return result
    end
end

Locales = {}

function _(str, ...)  -- Translate string

    if Locales[Config.Locale] ~= nil then

        if Locales[Config.Locale][str] ~= nil then
            return string.format(Locales[Config.Locale][str], ...)
        else
            return 'Translation [' .. Config.Locale .. '][' .. str .. '] does not exist'
        end

    else
        return 'Locale [' .. Config.Locale .. '] does not exist'
    end

end

function _U(str, ...) -- Translate string first char uppercase
    return tostring(_(str, ...):gsub("^%l", string.upper))
end
