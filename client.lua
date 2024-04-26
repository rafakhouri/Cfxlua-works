Tunnel = module('vrp','lib/Tunnel')
Proxy = module('vrp','lib/Proxy')

extern = Tunnel.getInterface('extern')

creating = false

RegisterNUICallback('fechar2', function()
    SetNuiFocus(false,false)
end)

RegisterNUICallback('DenunciaBug', function(data)
    openInterface('tablet', false)
    extern.sendD(data)
end)

function openRC(togg)
    SendNUIMessage({tablet = false})
    Wait(1000)
    SendNUIMessage({racecreator = togg})
end

RegisterNUICallback('DeleteRace', function(data)
    SetNuiFocus(false, false)
    extern.deleteRace(data)
end)

function markBlip(vec)
    Fblip = AddBlipForCoord(vec)
    SetBlipSprite(Fblip,315)
    SetBlipColour(Fblip,64)
    SetBlipScale(Fblip,1.5)
    SetBlipAsShortRange(Fblip,false)
    SetBlipRoute(Fblip,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('CORRIDA ILEGAL')
    EndTextCommandSetBlipName(Fblip)
end

function markBlip2(vec3)
    Fblip2 = AddBlipForCoord(vec3)
    SetBlipSprite(Fblip2,315)
    SetBlipColour(Fblip2,64)
    SetBlipScale(Fblip2,1.5)
    SetBlipAsShortRange(Fblip2,false)
    SetBlipRoute(Fblip2,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('CORRIDA ILEGAL 02')
    EndTextCommandSetBlipName(Fblip2)
end

function markRoute(vec3)
    route = AddBlipForCoord(vec3)
    SetBlipSprite(route,162)
    SetBlipColour(route,64)
    SetBlipScale(route,1.5)
    SetBlipAsShortRange(route,false)
    SetBlipRoute(route,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('ROTA - CORRIDA ILEGAL')
    EndTextCommandSetBlipName(route)
end

RegisterNUICallback('Create', function(data)
    SetNuiFocus(false,false)
    extern.saveRace(data)
end)

function rafaC(n)
    n = math.ceil(n * 100) / 100
    return n
end

CreateThread(function()
    while true do 
        sleep = 1000
        local ped = PlayerPedId() 
        if creating then 
            sleep = 0 
            if IsControlJustPressed(0, 168) then 
                openRC(false)
                SendNUIMessage({helprace = false})
                RemoveBlip(Fblip)
                extern.quitCreating()
                creating = false
            end
            if IsControlJustPressed(0, 289) then 
                if IsPedInAnyVehicle(ped, true) then 
                    local pc = GetEntityCoords(ped)
                    extern.saveCheckPoint(rafaC(pc.x),rafaC(pc.y),rafaC(pc.z))
                    RemoveBlip(Fblip)
                    markBlip(vec3(pc.x,pc.y,pc.z))
                end
            end
            if IsControlJustPressed(0, 170) then 
                if IsPedInAnyVehicle(ped, false) then 
                    openRC(false)
                    Wait(500)
                    SetNuiFocus(true,true)
                    SendNUIMessage({saverace = true})
                    RemoveBlip(Fblip)
                end
            end
        end
        Wait(sleep)
    end
end)

local blipMarkers = {}

function DrawBlipMarkers()
    for _, markerData in ipairs(blipMarkers) do
        DrawMarker(4, markerData.position, 0, 0, 0, 0, 0, 0, markerData.scale.x, markerData.scale.y, markerData.scale.z, markerData.color.r, markerData.color.g, markerData.color.b, markerData.color.a, true, false, 2, true, nil, true)
    end
end

CreateThread(function()
    while true do 
        local b = extern.returnBlips()
        blipMarkers = {} 
        
        for _, v in pairs(b) do 
            local position = vec3(tonumber(v.x), tonumber(v.y), tonumber(v.z+0.5))
            table.insert(blipMarkers, { position = position, scale = vec3(3.0, 3.0, 3.0), color = { r = 255, g = 0, b = 0, a = 150 } })
        end
        
        Wait(500)
    end
end)

RegisterNetEvent('racing:policeWarning')
AddEventHandler('racing:policeWarning', function(toggle)
    SetNuiFocus(false, false)
    SendNUIMessage({pwarning = toggle})
end)

function isNext(number1, number2, errorMarge)
    return math.abs(number1 - number2) <= errorMarge
end

local racing = false

RegisterNetEvent('racing:ras')
AddEventHandler('racing:ras', function()
    local vec = GetEntityCoords(PlayerPedId())
    rasBlip = AddBlipForCoord(vec)
    SetBlipSprite(rasBlip,227)
    SetBlipColour(rasBlip,64)
    SetBlipScale(rasBlip,1.5)
    SetBlipAsShortRange(rasBlip,false)
    SetBlipRoute(rasBlip,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('RASTREADOR CORRIDA ILEGAL')
    EndTextCommandSetBlipName(rasBlip)
end)

RegisterNetEvent('racing:rasDebug')
AddEventHandler('racing:rasDebug', function()
    RemoveBlip(rasBlip)
end)


local dict = "core"
local particleName = "exp_grd_flare"

function createFlare(x, y, z)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        Citizen.Wait(100)
    end
    UseParticleFxAssetNextCall(dict)
    newPftx = StartParticleFxLoopedAtCoord(particleName, x, y, z, 0.0, 0.0, 0.0, 1.5, false, false, false)
end

CreateThread(function()
    while true do 
        loop = 1500 
        if racing then 
            loop = 500
            if not IsPedInAnyVehicle(PlayerPedId(), true) then 
                openRacingInterface(false)
                RemoveBlip(Fblip)
                RemoveBlip(Fblip2)
                RemoveParticleFx(newPftx, false)
                racing = false
                actualBlipNumber = 2
            end
        end
        Wait(loop)
    end
end)

function doCelebration()
    if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
        RequestNamedPtfxAsset("scr_indep_fireworks")
        while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
            Wait(10)
        end
    end
    
    local CurrentPlayerCoords = GetEntityCoords(GetPlayerPed(-1))
    
    UseParticleFxAssetNextCall("scr_indep_fireworks") 
    SetParticleFxNonLoopedColour(1.0, 0.0, 0.0) 
    StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_burst_spawn", CurrentPlayerCoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    
    RemoveNamedPtfxAsset("scr_indep_fireworks") 
end

function countage(toggle)
    SendNUIMessage({countage = toggle})
end

CreateThread(function()
    actualBlipNumber = 2
    while true do 
        local number = 1
        local ped = PlayerPedId()
        local cds = GetEntityCoords(ped)
        local pedVehicle = GetVehiclePedIsIn(ped, false)
        if racing then 
            if IsControlJustPressed(0, 168) then 
                openRacingInterface(false)
                RemoveBlip(Fblip)
                RemoveBlip(Fblip2)
                RemoveParticleFx(newPftx, false)
                racing = false
                actualBlipNumber = 2
            end
        end
        for _, value in ipairs(blipMarkers) do 
            if isNext(cds.x, value.position[1], 15) and isNext(cds.y, value.position[2], 15) and isNext(cds.z, value.position[3], 15) and not racing and IsPedInAnyVehicle(ped, false) then   
                DrawBlipMarkers()
                if isNext(cds.x, value.position[1], 5) and isNext(cds.y, value.position[2], 5) and isNext(cds.z, value.position[3], 5) and not racing and IsPedInAnyVehicle(ped, false) then
                    if IsControlJustPressed(0, 38) and IsPedInAnyVehicle(ped, false) then
                        if extern.condition() then
                            if not extern.isBanned() and not extern.isPolice() then
                                extern.callPolice()
                                racing = true
                                FreezeEntityPosition(pedVehicle, true)
                                countage(true)
                                Wait(3000)
                                doCelebration()
                                markBlip(extern.vec(actualBlipNumber, extern.getRaceName(cds.x)))
                                ShowNumberOnBlip(Fblip, actualBlipNumber)
                                markBlip2(extern.vec(actualBlipNumber+1, extern.getRaceName(cds.x)))
                                ShowNumberOnBlip(Fblip2, actualBlipNumber+1)
                                createFlare(
                                    extern.vec(actualBlipNumber, extern.getRaceName(cds.x)).x,
                                    extern.vec(actualBlipNumber, extern.getRaceName(cds.x)).y,
                                    extern.vec(actualBlipNumber, extern.getRaceName(cds.x)).z
                                )
                                FreezeEntityPosition(pedVehicle, false)
                                countage(false)
                                Wait(500)
                                openRacingInterface(true)
                                if extern.yourTop() == '999999.00.000' then
                                    SendNUIMessage({
                                        racingcar = ''..string.upper(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(ped, false))))..' - Racing',
                                        topracer = 'Top tempo: '..extern.topRacer(),
                                        yourtop = 'Seu Top: X.XX.XXX',
                                        actualCheckPoint = 'Checkpoints: '..extern.allChecks(extern.getRaceName(cds.x))
                                    })
                                else
                                    SendNUIMessage({
                                        racingcar = ''..string.upper(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(ped, false))))..' - Racing',
                                        topracer = 'Top tempo: '..extern.topRacer(),
                                        yourtop = 'Seu Top: '..extern.yourTop(),
                                        actualCheckPoint = 'Checkpoints: '..extern.allChecks(extern.getRaceName(cds.x))
                                    })
                                end
                            else
                                print('Banido de correr.')
                            end
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)

CreateThread(function()
    while true do 
        local timer = 500 
        if racing then
            timer = 0
            local ped = PlayerPedId()
            local cds = GetEntityCoords(ped)
            if extern.vec(actualBlipNumber, extern.getRaceName(cds.x)) ~= 'fim' then
                local distance = #(cds - vec3(extern.vec(actualBlipNumber, extern.getRaceName(cds.x))))
                if distance <= 30.0 then
                    RemoveBlip(Fblip)
                    RemoveBlip(Fblip2)
                    actualBlipNumber = actualBlipNumber + 1
                    RemoveParticleFx(newPftx, false)
                    markBlip(extern.vec(actualBlipNumber, extern.getRaceName(cds.x)))
                    ShowNumberOnBlip(Fblip, actualBlipNumber)
                    if extern.vec(actualBlipNumber+1, extern.getRaceName(cds.x)) ~= 'fim' then 
                        markBlip2(extern.vec(actualBlipNumber+1, extern.getRaceName(cds.x)))
                        ShowNumberOnBlip(Fblip2, actualBlipNumber+1)
                    end
                    createFlare(
                        extern.vec(actualBlipNumber, extern.getRaceName(cds.x)).x,
                        extern.vec(actualBlipNumber, extern.getRaceName(cds.x)).y,
                        extern.vec(actualBlipNumber, extern.getRaceName(cds.x)).z
                    )
                end
            else
                openRacingInterface(false)
                RemoveBlip(Fblip)
                RemoveBlip(Fblip2)
                RemoveParticleFx(newPftx, false)
                racing = false
                actualBlipNumber = 2
                print('Você finalizou a corrida. Parabéns! Fuja da polícia!')
                extern.turnOffRas()
                extern.pay()
                SendNUIMessage({racefinish = true})
                RegisterNUICallback('finish:race', function(data)
                    extern.E(data, string.upper(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)))))
                end)
            end
        end
        Wait(timer)
    end
end)

local needHelp = false

RegisterCommand('helprace', function()
    if creating and extern.isAdmin() and not needHelp then 
        SendNUIMessage({helprace = true})
        needHelp = true
    elseif creating and extern.isAdmin and needHelp then 
        SendNUIMessage({helprace = false})
        needHelp = false
    end
end)

local clickRun = false

RegisterNUICallback('ButtonClick', function(data)
    if data == 'run' and not clickRun then 
        clickRun = true 
        markRoute(extern.run())
    elseif data == 'run' and clickRun then 
        RemoveBlip(Fblip)
        Wait(1000)
        clickRun = false
    elseif data == 'create' then 
        if extern.isAdmin() then 
            openInterface('tablet', false)
            openRC(true)
            creating = true
        end
    end
end)

RegisterNUICallback('BanRacer', function(data)
    SetNuiFocus(false, false)
    data = tonumber(data)
    if extern.isAdmin() then 
        extern.setBanned('otherID', data)
    end
end)

function isAdmin()
    if extern.isAdmin() then 
        SendNUIMessage({isAdmin = true})
    else
        SendNUIMessage({isAdmin = false})
    end
end

function openInterface(interface, toggle)
    if interface == 'tablet' and toggle == 'none' then 
        SetNuiFocus(true, true)
        SendNUIMessage({tablet = true})
        local callbackRegistered = false
        local callbackFunction = function()
            if not callbackRegistered then
                callbackRegistered = true
            end
        end
        RegisterNUICallback('Races', callbackFunction)
        RegisterNUICallback('Earnings', callbackFunction)
        RegisterNUICallback('Bestcar', callbackFunction)
        RegisterNUICallback('isAdmin', callbackFunction)
        RegisterNUICallback('SaveRace', callbackFunction)
        RegisterNUICallback('TimeRecord', callbackFunction)
        RegisterNUICallback('TimeOwner', callbackFunction)
        RegisterNUICallback('FinishedRace', callbackFunction)
        RegisterNUICallback('ActualCheckPoint', callbackFunction)
    else
        SetNuiFocus(toggle, toggle)
        SendNUIMessage({interface = toggle})
    end
end

function openRacingInterface(togg)
    SetNuiFocus(false, false)
    SendNUIMessage({racing = togg})
    local callbackRegistered = false
    local callbackFunction = function()
        if not callbackRegistered then
            callbackRegistered = true
        end
    end
    RegisterNUICallback('RacingCar', callbackFunction)
    RegisterNUICallback('TopRacer', callbackFunction)
    RegisterNUICallback('YourTop', callbackFunction)
end

RegisterCommand('painelcr', function()
    if extern.hasTablet() then 
        if extern.firstTime() then 
            extern.register()
            print('Você está sendo registrado. Abra novamente.')
        else
            if extern.isBanned() then 
                SendNUIMessage({
                    races = 'Você está banido.',
                    earnings = 'Você está banido.',
                    bestcar = 'Você está banido.',
                    tablet = 'banned'
                })
                openInterface('tablet', 'none')
            else
                isAdmin()
                SendNUIMessage({
                    races = 'Corridas: '..extern.info('Corridas'),
                    earnings = 'Ganhos: $'..extern.info('Ganhos'),
                    bestcar = 'Melhor Carro: '..extern.info('MelhorCarro'),
                    tablet = 'ok',
                    timerecord = 'Tempo Recorde: '..extern.topRacer(),
                    timeowner = 'Corredor: '..extern.timeOwner()
                })
                openInterface('tablet', 'none')
            end
        end
    end
end)

CreateThread(function()
    while true do 
        if settings.autobanPolicia then 
            if extern.isPolice() then 
                extern.setBanned()
            end
        elseif not settings.autobanPolicia then
            return
        end
        Wait(5000)
    end
end)

RegisterCommand('debugcorrida', function()
    if not racing and not creating and not extern.isPolice() then 
        RemoveBlip(Fblip)
        RemoveBlip(Fblip2)
    end
end)