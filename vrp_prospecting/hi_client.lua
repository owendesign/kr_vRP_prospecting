local blip_location = vector3(1580.9, 6592.204, 13.84828)
local blip = nil
local area_blip = nil
local area_size = 100.0

CreateThread(function()
    AddTextEntry("PROSP_BLIP", Config.ProspectingBlipText) -- 건들지 마세요.
    blip = AddBlipForCoord(blip_location)
    SetBlipSprite(blip, Config.ProspectingBlipSprite)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("PROSP_BLIP") -- 건들지 마세요.
    EndTextCommandSetBlipName(blip)
    area_blip = AddBlipForRadius(blip_location, area_size)
    SetBlipSprite(area_blip, 10)
end)

RegisterNetEvent("vRP_hi_prospecting:startProspecting")
AddEventHandler("vRP_hi_prospecting:startProspecting", function()
    local pos = GetEntityCoords(PlayerPedId())

    -- 플레이어가 금속 탐지를 시작하기 전에 금속 탐지 지역 안에 있는지 확인하십시오
    local dist = #(pos - blip_location)
    if dist < area_size then
        TriggerServerEvent("vRP_hi_prospecting:activateProspecting")
    else
		hi_ShowNotification("~r~금속탐지 지역이 아닙니다!")
	end
end, false)

RegisterNetEvent("vRP_hi_prospecting:useDetector")
AddEventHandler("vRP_hi_prospecting:useDetector", function()
	if IsPedInAnyVehicle(PlayerPedId()) then
		hi_ShowNotification("~r~차량에 탄 상태에서 금속탐지를 시작할수 없습니다!")
	else
		TriggerEvent("vRP_hi_prospecting:startProspecting")
	end
end)

function hi_ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end

RegisterNetEvent('vRP_hi_prospecting:showNotification')
AddEventHandler('vRP_hi_prospecting:showNotification', function(ret)
    hi_ShowNotification(ret)
end)