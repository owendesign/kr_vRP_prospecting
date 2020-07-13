local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_hi_prospecting")

Citizen.CreateThread(function()
  for k,v in pairs(hi_prospecting) do
    vRP.defInventoryItem({k,v.hi_name,v.hi_info,v.hi_menuname,v.hi_weight})
  end
end)

hi_prospecting = {
	["detector"] = { -- 금속 탐지기 아이템 이름(코드) 설정
		hi_name = "금속 탐지기", -- detector 이름
		hi_info = "금속 탐기지로 다양한 아이템을 휘득해보세요!", -- 금속 탐지기 아이템 설명 설정
		hi_menuname = function(args)
			local hi_menu = {}
			hi_menu["사용하기"] = {function(player,choice) -- 금속 탐지기 아이템에 사용하기 메뉴를 추가 한다.
			TriggerClientEvent("vRP_hi_prospecting:useDetector", player) -- 사용하기를 누를시에 클라이언트 이벤트를 호출한다.
			vRP.closeMenu({player}) -- 메뉴를 닫습니다.
		end}
	return hi_menu -- 사용하기 메뉴를 리턴 한다.
end,
hi_weight = 2500 -- 금속 탐지기 아이템 무게 설정 예시) 2,500KG
	},
	
	["bones"] = { -- 뼈 아이템 이름(코드) 설정
		hi_name = "뼈", -- bones 이름
		hi_info = "금속탐지기로 인해 얻은 뼈이다.", -- 뼈 아이템 설명 설정
		hi_menuname = function(args)
end,
hi_weight = 100 -- 뼈 아이템 무게 설정 예시) 100KG
	},
	
	["dragon_scales"] = { -- 용 비늘 아이템 이름(코드) 설정
		hi_name = "용 비늘", -- dragon_scales 이름 설정
		hi_info = "금속 탐기지로 인해 얻은 용 비늘이다.", -- 용 비늘 아이템 설명 설정
		hi_menuname = function(args)
end,
hi_weight = 1000 -- 용 비늘 아이템 무게 설정 예시) 1,000KG
	},
	
	["gold_ring"] = { -- 금 반지 아이템 이름(코드) 설정
		hi_name = "금 반지", -- gold_ring 이름 설정
		hi_info = "금속 탐기지로 인해 얻은 금반지이다.", -- 금 반지 아이템 설명 설정
		hi_menuname = function(args)
end,
hi_weight = 100 -- 금반지 아이템 무게 설정 예시) 100KG
	},
	
	["metalscrap"] = { -- 금속 조각 아이템 이름(코드) 설정
		hi_name = "금속 조각", -- metalscrap 이름 설정
		hi_info = "금속 탐기지로 인해 얻은 금속 조각이다.", -- 금속 조각 아이템 설명 설정
		hi_menuname = function(args)
end,
hi_weight = 100 -- 금속 조각 아이템 무게 설정 예시) 100KG
	},
	
	["nuts_and_bolts"] = { -- 너트 와 볼트 아이템 이름(코드) 설정
		hi_name = "너트 와 볼트", -- nuts_and_bolts 이름 설정
		hi_info = "금속 탐기지로 인해 얻은 볼트와 너트이다.", -- 너트 와 볼트 아이템 설명 설정
		hi_menuname = function(args)
end,
hi_weight = 100 -- 볼트와 너트 아이템 무게 설정 예시) 100KG
	}
}

local locations = {
    {x = 1600.185, y = 6622.714, z = 15.85106, data = { -- 좌표 설정
        item = "bones", -- 아이템 코드명 설정
		label = "뼈", -- 아이템 이름 설정
    }},
    {x = 1548.082, y = 6633.096, z = 2.377085, data = { -- 좌표 설정
        item = "nuts_and_bolts", -- 아이템 코드명 설정
		label = "너트 와 볼트" -- 아이템 이름 설정
    }},
    {x = 1504.235, y = 6579.784, z = 4.365892, data = { -- 좌표 설정
        item = "gold_ring", -- 아이템 코드명 설정
        label = "금 반지", -- 아이템 이름 설정
    }},
    {x = 1580.016, y = 6547.394, z = 15.96557, data = { -- 좌표 설정
        item = "dragon_scales", -- 아이템 코드명 설정
        label = "용 비늘", -- 아이템 이름 설정
    }},
    {x = 1634.586, y = 6596.688, z = 22.55633, data = { --좌표설정
        item = "metalscrap", -- 아이템 코드명 설정
		label = "금속 조각", -- 아이템 이름 설정
    }},
}

local item_pool = {
    {item = "bones", label = "뼈"}, -- 아이템 코드명 , 아이템 이름 설정
    {item = "nuts_and_bolts", label = "너트 와 볼트"}, -- 아이템 코드명 , 아이템 이름 설정
    {item = "gold_ring", label = "금 밙지"}, -- 아이템 코드명 , 아이템 이름 설정 
    {item = "dragon_scales", label = "용 비늘"}, -- 아이템 코드명 , 아이템 이름 설정
    {item = "metalscrap", label = "금속 조각"}, -- 아이템 코드명 , 아이템 이름 설정
}

local base_location = vector3(1580.9, 6592.204, 13.84828)
local area_size = 100.0

function hi_GetNewRandomItem()
    local item = item_pool[math.random(#item_pool)]
    return {item = item.item, label = item.label}
end

function hi_GetNewRandomLocation()
    local offsetX = math.random(-area_size, area_size)
    local offsetY = math.random(-area_size, area_size)
    local pos = vector3(offsetX, offsetY, 0.0)
    if #(pos) > area_size then
        return hi_GetNewRandomLocation()
    end
    return base_location + pos
end

function hi_GenerateNewTarget()
    local newPos = hi_GetNewRandomLocation()
    local newData = hi_GetNewRandomItem()
    Prospecting.AddTarget(newPos.x, newPos.y, newPos.z, newData)
end

RegisterServerEvent("vRP_hi_prospecting:activateProspecting")
AddEventHandler("vRP_hi_prospecting:activateProspecting", function()
    local player = source
    Prospecting.StartProspecting(player)
end)

CreateThread(function()
    Prospecting.SetDifficulty(1.0)

    Prospecting.AddTargets(locations)

    for n = 0, 10 do
        hi_GenerateNewTarget()
    end

    Prospecting.SetHandler(function(player, data, x, y, z)
		hi_FoundItem(player, data)
        hi_GenerateNewTarget()
    end)

    Prospecting.OnStart(function(player)
		TriggerClientEvent('vRP_hi_prospecting:showNotification', player, "~g~금속탐지를 시작했습니다")
    end)

    Prospecting.OnStop(function(player, time)
		TriggerClientEvent('vRP_hi_prospecting:showNotification', player, "~r~금속탐지를 금속탐지를 중지하였습니다")
    end)
end)

function comma_Hi(amount) -- 소숫점 함수 건들지 마세요
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function hi_FoundItem(player, data)
	local user_id = vRP.getUserId({player})
	local Getitem_hi_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({data.item})
	local hi_amount = 1 -- 금속 탐지를 하여 data.item의 갯수 설정
	if Getitem_hi_weight <= vRP.getInventoryMaxWeight({user_id}) then
		vRP.giveInventoryItem({user_id, data.item, hi_amount,false})
		TriggerClientEvent('vRP_hi_prospecting:showNotification', player, "~g~당신은 "..vRP.getItemName({data.item}).." "..comma_Hi(hi_amount).."개를 발견 하였습니다!")
	else
		TriggerClientEvent('vRP_hi_prospecting:showNotification', player, "~r~당신은 "..vRP.getItemName({data.item}).." "..comma_Hi(hi_amount).."개를 발견 하였지만 가방이 꽉차 있어 획득이 불가능 합니다.")
	end
end