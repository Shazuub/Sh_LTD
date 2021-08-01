ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

local open = false 
local LTD = RageUI.CreateMenu('LTD', 'Ouvert 24/7')

LTD.Closed = function()
  open = false
  FreezeEntityPosition(PlayerPedId(), false)
end

OpenMenuLTD = function()
     if open then 
         open = false
         RageUI.Visible(LTD, false)
         return
     else
         open = true 
         RageUI.Visible(LTD, true)
         CreateThread(function()
         while open do 
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(LTD,function() 

            for k,v in pairs(Config.LTD) do
                RageUI.Button(v.label, nil, {RightLabel = v.price.."$"}, true , {
                    onSelected = function()
                        TriggerServerEvent('ltd:payer', v.item, v.price)
                    end
                })
              end
            end)
          Wait(1)
         end
      end)
   end
end      

local blips = {
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 24.129, y = -1346.156, z = 28.497, h = 266.946},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 2557.458, y = 382.282, z = 107.622},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -3038.939, y = 585.954, z = 6.97},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -3241.927, y = 1001.462, z = 11.850},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 547.431, y = 2671.710, z = 41.176},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 1961.464, y = 3740.672, z = 31.363},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 2678.916, y = 3280.671, z = 54.261},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 1729.216, y = 6414.131, z = 34.057},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 1135.808, y = -982.281, z = 45.45},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -1222.93, y = -906.99, z = 11.35},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -1487.553, y = -379.107, z = 39.163},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -2968.243, y = 390.910, z = 14.054},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 1166.024, y = 2708.930, z = 37.167},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 1392.562, y = 3604.684, z = 33.995},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -1037.618, y = -2737.399, z = 19.169},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -48.519, y = -1757.514, z = 28.47},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 1163.373, y = -323.801, z = 68.27},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -707.67, y = -914.22, z = 18.26},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = -1820.523, y = 792.518, z = 137.20},
    {title="Magasins", colour=2, sprite=52, scale=0.7, id=642, x = 1698.388, y = 4924.404, z = 41.083}
}

Citizen.CreateThread(function()
    while true do
        local Waito = false
        for _, info in pairs(blips) do
            local dist = Vdist2(GetEntityCoords(GetPlayerPed(-1)), info.x, info.y, info.z)
            if dist < 3 then
                Waito = true 
                DrawMarker(21, info.x, info.y, info.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.2, 255, 188, 0, 255, 0, 0, 2, 1, nil, nil, 0)
                if dist < 2 then 
                    if IsControlJustPressed(0, 51) then
                        RageUI.CloseAll()
                        OpenMenuLTD()
                    end
                end
            end
        end
        if Waito then
            Wait(0)
        else 
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.sprite)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, info.scale)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)