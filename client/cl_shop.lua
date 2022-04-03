-- Create by Z2SK

TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    for k, v in pairs(Shops.Pos) do
        local blips = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blips, 59)
        SetBlipDisplay(blips, 4)
        SetBlipScale(blips, 0.7)
        SetBlipAsShortRange(blips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("LTD 24/7 Shop, Welcome !")
        EndTextCommandSetBlipName(blips)
    end
end)

Citizen.CreateThread(function()
  while true do
    local wait = 750
    for k in pairs(Shops.Pos) do
      local plyCoords = GetEntityCoords(PlayerPedId())
      local pos = Shops.Pos
      local distance = GetDistanceBetweenCoords(plyCoords, pos[k], true)
      local interval = 1

      if distance > 10 then
        interval = 200
      else
        interval = 1
        DrawMarker(23, pos[k].x, pos[k].y, pos[k].z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 170, 0, 1, 2, 0, nil, nil, 0)

        if distance < 1 then
          RageUI.Text({ message="Appuyez sur ~y~[E]~w~ pour parler au vendeur", time_display = 1 })

          if IsControlJustPressed(1, 38) then
            Z2LTD()
          end
        end
      end
    end
    Wait(interval)
  end
end)

Citizen.CreateThread(function()
    Citizen.Wait(750)
    for _, v in pairs(Config.npc) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do Wait(10) end
        npc = CreatePed(4, v.model, v.coords, v.heading, false, true)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
    end
end)

function Z2LTD()
    RMenu.Add("shop", "main", RageUI.CreateMenu("LTD 24/7", "Un LTD ouvert 24/7"))
    RMenu.Add("nourriture", "main", RageUI.CreateSubMenu(RMenu:Get("shop", "main"), "LTD 24/7", "La catégorie nourriture"))
    RMenu.Add("boisson", "main", RageUI.CreateSubMenu(RMenu:Get("shop", "main"), "LTD 24/7", "La catégorie boisson"))
    if open then
        open = false
        RageUI.Visible(RMenu:Get("shop", "main"), false)
    else
        open = true
        RageUI.Visible(RMenu:Get("shop", "main"), true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(RMenu:Get("shop", "main"), true, true, true, function()

                    RageUI.Separator("~r~Nourriture")
                    RageUI.ButtonWithStyle("Nourriture", nil, {RightLabel = "->"}, true, function()
                    end, RMenu:Get("nourriture", "main"))

                    RageUI.Separator("~b~Boisson")
                    RageUI.ButtonWithStyle("Boisson", nil, {RightLabel = "->"}, true, function()
                    end, RMenu:Get("boisson", "main"))
                end, function() end, 1)

                RageUI.IsVisible(RMenu:Get("nourriture", "main"), true, true, true, function()
                    RageUI.ButtonWithStyle("Baguette tradition", nil, {RightLabel = "->"}, true, function(h, a, s)
                        if s then
                            local price = 2
                            local item = "bread"
                            TriggerServerEvent("Z2LTD:buy", item, price)
                        end
                    end)
                    RageUI.ButtonWithStyle("Burger", nil, {RightLabel = "->"}, true, function(h, a, s)
                        if s then
                            local price = 6
                            local item = "burger"
                            TriggerServerEvent("Z2LTD:buy", item, price)
                        end
                    end)
                end, function() end, 1)
                RageUI.IsVisible(RMenu:Get("boisson", "main"), true, true, true, function()
                    RageUI.ButtonWithStyle("Bouteille d'eau", nil, {RightLabel = "->"}, true, function(h, a, s)
                        if s then
                            local price = 1
                            local item = "water"
                            TriggerServerEvent('Z2LTD:buy', item, price)
                        end
                    end)
                end, function() end, 1)
                Citizen.Wait(0)
                if not RageUI.Visible(RMenu:Get("shop", "main")) and not RageUI.Visible(RMenu:Get("nourriture", "main")) and not RageUI.Visible(RMenu:Get("boisson", "main")) then
                    open = false
                end
            end
        end)
    end
end