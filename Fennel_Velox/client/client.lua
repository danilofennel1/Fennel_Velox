Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)
local aperto = false
local prova = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, cb in pairs(Config.Coords) do
            local blipset = AddBlipForCoord(cb)
            SetBlipSprite(blipset, Config.Blip.Id)
            SetBlipScale(blipset, Config.Blip.Scale)
            SetBlipColour(blipset, Config.Blip.Color)
            SetBlipAsShortRange(blipset, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(Config.Blip.Name..' '..Config.Kmh..'Hm/H')
            EndTextCommandSetBlipName(blipset)
        end
        local giocatore = GetPlayerPed(-1)
        local cordinategio = GetEntityCoords(giocatore)
        local veicolo = GetVehiclePedIsIn(giocatore, false)
        local velocitaveh = GetEntitySpeed(giocatore)
        local driver = GetPedInVehicleSeat(veicolo, -1)
        local plate = GetVehicleNumberPlateText(veicolo)
        local maxspeed = GetVehicleEstimatedMaxSpeed(veicolo)
        local hashveicolo = GetEntityModel(veicolo)
        local nomeveicolo = GetDisplayNameFromVehicleModel(hashveicolo)
        local mphspeed = math.ceil(velocitaveh*2.236936)
        local velocitamph = mphspeed
        for _, k in pairs(Config.Coords) do
            if Vdist2(k, cordinategio) < Config.DistanceVelox and velocitamph > Config.Kmh then
                for _, j in pairs(Config.Whitelist.Job) do
                    if PlayerData.job.name == j then
                        prova = true
                    else
                        prova = false
                    end
                end
                for _, m in pairs(Config.Whitelist.Vehicle) do
                    if nomeveicolo == m then
                        prova = true
                    else
                        prova = false
                    end
                end
            end
        end
    end 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if prova == false then
            Multa()
            FaiFoto()
        end
    end
end)

function FaiFoto()
    prova = nil
    SendNUIMessage({open = true})
    Wait(100)
    SendNUIMessage({open = false})  
end