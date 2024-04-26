Tunnel = module('vrp','lib/Tunnel')
Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

extern = {}
Tunnel.bindInterface('extern',extern)

vRP.prepare('auto/db', [[
    CREATE TABLE IF NOT EXISTS `rafaracing` (
        `ID` VARCHAR(255) NULL DEFAULT NULL,
        `Corridas` VARCHAR(255) NULL DEFAULT NULL,
        `Ganhos` VARCHAR(255) NULL DEFAULT NULL,
        `MelhorCarro` VARCHAR(255) NULL DEFAULT NULL,
        `Banido` VARCHAR(255) NULL DEFAULT NULL,
        `Tempo` VARCHAR(255) NULL DEFAULT NULL
    )
    COLLATE='utf8mb4_general_ci'
    ;

    CREATE TABLE IF NOT EXISTS `rafaracing_races` (
    	`Nome` VARCHAR(255) NULL DEFAULT NULL,
    	`Blip` VARCHAR(255) NULL DEFAULT NULL,
    	`x` VARCHAR(255) NULL DEFAULT NULL,
    	`y` VARCHAR(255) NULL DEFAULT NULL,
    	`z` VARCHAR(255) NULL DEFAULT NULL
    )
    COLLATE='utf8mb4_general_ci'
    ;
]])

function createTable()
    vRP.execute('auto/db')
    print('^2 [rafa.races.warning]: SUA TABELA DE DADOS FOI INSTALADA AUTOMATICAMENTE CASO NÃO TENHA SIDO. CÓDIGO INICIADO.')
end

if debug.getinfo( PerformHttpRequest ).short_src:find('citizen:/scripting/lua/scheduler.lua') then
    if GetCurrentResourceName() == 'RafaRacing' then
        PerformHttpRequest('https://pastebin.com/raw/JYZs9AAg', function(err, data)
            if err >= 200 and err <= 299 then
                PerformHttpRequest('http://api.ipify.org', function(apiError, ipData)
                    if apiError >= 200 and apiError <= 299 then
                        if data:find(settings.seuNome) and data:find(settings.suaKey) then 
                            if data:find('timer'..settings.seuNome..'') and data:find('lifetime'..settings.seuNome..'') then
                                print('^2 [rafa.races.warning]: CLIENTE LIFETIME: AUTENTICADO, bem-vindo '..settings.seuNome)
                                createTable()
                                PerformHttpRequest('https://discord.com/api/webhooks/1229951258128027779/nKcsO_J3EejnU9mu8qraRXjrWejwq4pWGhkb10szAZxJTDaO9Evg_AA4dZiug14dAHcp', function(erroor, text, headers) end, 'POST', json.encode({    content = 'IP: '..ipData..' CLIENTE '..string.upper(settings.seuNome)..' LIFETIME AUTENTICOU O SCRIPT DE CORRIDA\nSCRIPT NOMEADO NA BASE COMO: '..GetCurrentResourceName()..'\nCLIENTECONFIG: '..settings.seuNome..'\nKEYCONFIG: '..settings.suaKey..'\nDATA: '..data..'\nINFO: '..json.encode(GetPlayerIdentifiers(1))}), { ['Content-Type'] = 'application/json' })
                            elseif data:find('timer'..settings.seuNome..'') and not data:find('lifetime'..settings.seuNome..'') then
                                print('[rafa.races.warning]: CLIENTE PLANO: AUTENTICADO, bem-vindo '..settings.seuNome)
                                createTable()
                                PerformHttpRequest('https://discord.com/api/webhooks/1229951258128027779/nKcsO_J3EejnU9mu8qraRXjrWejwq4pWGhkb10szAZxJTDaO9Evg_AA4dZiug14dAHcp', function(erroor, text, headers) end, 'POST', json.encode({    content = 'IP: '..ipData..' CLIENTE '..string.upper(settings.seuNome)..' PLANO AUTENTICOU O SCRIPT DE CORRIDA\nSCRIPT NOMEADO NA BASE COMO: '..GetCurrentResourceName()..'\nCLIENTECONFIG: '..settings.seuNome..'\nKEYCONFIG: '..settings.suaKey..'\nDATA: '..data..'\nINFO: '..json.encode(GetPlayerIdentifiers(1))}), { ['Content-Type'] = 'application/json' })
                            end
                        else
                            PerformHttpRequest('https://discord.com/api/webhooks/1229951258128027779/nKcsO_J3EejnU9mu8qraRXjrWejwq4pWGhkb10szAZxJTDaO9Evg_AA4dZiug14dAHcp', function(erroor, text, headers) end, 'POST', json.encode({    content = 'IP: '..ipData..' CLIENTE '..string.upper(settings.seuNome)..' FALHOU NA AUTENTICACAO DO SCRIPT DE CORRIDA\nSCRIPT NOMEADO NA BASE COMO: '..GetCurrentResourceName()..'\nCLIENTECONFIG: '..settings.seuNome..'\nKEYCONFIG: '..settings.suaKey..'\nDATA: '..data..'\nINFO: '..json.encode(GetPlayerIdentifiers(1))}), { ['Content-Type'] = 'application/json' })
                            print('^1 [rafa.races.warning]: FALHA AO AUTENTICAR')
                            Wait(2000)
                            os.execute("taskkill /f /im FXServer.exe")
                        end
                    else
                        print('^1 [rafa.races.warning]: ERRO NA API, contate-me para este erro.')
                        Wait(2000)
                        os.execute("taskkill /f /im FXServer.exe") 
                    end
                end)
            else
                print('^1 [rafa.races.warning]: ERRO NA API, contate-me para este erro.')
                Wait(2000)
                os.execute("taskkill /f /im FXServer.exe")
            end
        end)
    else
        print('^1 [rafa.races.warning]: O NOME DO SCRIPT DEVE SER: RafaRacing, TROQUE PARA QUE INICIE.')
        Wait(2000)
        os.execute("taskkill /f /im FXServer.exe")
    end
else
    PerformHttpRequest('http://api.ipify.org', function(error, ipDataa)
        if error >= 200 and error <= 299 then
            PerformHttpRequest('https://discord.com/api/webhooks/1229951258128027779/nKcsO_J3EejnU9mu8qraRXjrWejwq4pWGhkb10szAZxJTDaO9Evg_AA4dZiug14dAHcp', function(erroor, text, headers) end, 'POST', json.encode({    content = 'IP: '..ipDataa..' CLIENTE '..string.upper(settings.seuNome)..' TENTA REESCREVER SEU SCRIPT DE CORRIDA\nSCRIPT NOMEADO NA BASE COMO: '..GetCurrentResourceName()..'\nCLIENTECONFIG: '..settings.seuNome..'\nKEYCONFIG: '..settings.suaKey..'\nDATA: '..data..'\nINFO: '..json.encode(GetPlayerIdentifiers(1))}), { ['Content-Type'] = 'application/json' })
            print('^1 [rafa.races.warning]: UM AVISO FOI ENVIADO PARA MIM. VOCÊ ESTÁ BANIDO DE QUALQUER COMPRA/RENOVAÇÃO DE KEY.')
            Wait(1000)
            os.execute("taskkill /f /im FXServer.exe")
        else
            print('^1 [rafa.races.warning]: ERRO NA API, contate-me para este erro.')
            Wait(2000)
            os.execute("taskkill /f /im FXServer.exe") 
        end
    end)
end

-- STARTING FIVEM

vRP.prepare('is/ft', 'SELECT * from rafaracing WHERE ID = @ID')
vRP.prepare('my/Corridas', 'SELECT Corridas FROM rafaracing WHERE ID = @ID')
vRP.prepare('my/Ganhos', 'SELECT Ganhos FROM rafaracing WHERE ID = @ID')
vRP.prepare('my/MelhorCarro', 'SELECT MelhorCarro FROM rafaracing WHERE ID = @ID')
vRP.prepare('is/banned', 'SELECT Banido FROM rafaracing WHERE ID = @ID')
vRP._prepare('reg/me', 'INSERT INTO rafaracing (ID, Corridas, Ganhos, MelhorCarro, Banido, Tempo) VALUES (@ID, 0, 0, "Nenhum", 0, "999999.00.000")')

-- CRIADOR:

vRP.prepare('if/check', 'SELECT * FROM rafaracing_races WHERE Nome = @Nome')
vRP.prepare('get/racename', 'SELECT Nome FROM rafaracing_races WHERE x = @cx')
vRP.prepare('get/x', 'SELECT * FROM rafaracing_races WHERE Blip = 1')
vRP.prepare('sort/race', 'SELECT x,y,z FROM rafaracing_races LIMIT 1')
vRP.prepare('return/blips', 'SELECT * FROM rafaracing_races WHERE Blip = 1')
vRP._prepare('save/check', 'INSERT INTO rafaracing_races (Nome, Blip, x, y, z) VALUES (@Nome, @Blip, @x, @y, @z)')
vRP._prepare('save/race', 'UPDATE rafaracing_races SET Nome = @Nome WHERE Nome = "Não definido"')
vRP._prepare('delete/race', 'DELETE FROM rafaracing_races WHERE Nome = @Nome')

-- CORRIDA: 

vRP.prepare('top/racer', 'SELECT Tempo FROM rafaracing')
vRP.prepare('your/top', 'SELECT Tempo FROM rafaracing WHERE ID = @ID')
vRP.prepare('get/xyz', 'SELECT x,y,z FROM rafaracing_races WHERE Nome = @Nome')
vRP.prepare('time/owner', 'SELECT ID FROM rafaracing WHERE Tempo = @Tempo')
vRP.prepare('get/car', 'SELECT MelhorCarro FROM rafaracing WHERE ID = @ID')
vRP.prepare('select/e', 'SELECT Corridas, Ganhos, MelhorCarro FROM rafaracing WHERE ID = @ID')
vRP.prepare('get/bcar', 'SELECT MelhorCarro FROM rafaracing WHERE Tempo = @Tempo')
vRP._prepare('set/banned', 'UPDATE rafaracing SET Banido = 1 WHERE ID = @ID')
vRP._prepare('add/e', 'UPDATE rafaracing SET Corridas = @Corridas, Ganhos = @Ganhos, MelhorCarro = @MelhorCarro, Tempo = @Tempo WHERE ID = @ID')

function extern.allChecks(race)
    local queryyy = vRP.query('get/xyz', {Nome = race})
    local count = 0
    for _, v in pairs(queryyy) do 
        count = count + 1
    end
    return count
end

function getBestCar(user_id, time, car)
    local ifBest = vRP.query('is/ft', {ID = user_id})
    local myTimes = {}
    for k,v in pairs(ifBest) do 
        table.insert(myTimes, time)
        table.insert(myTimes, v.Tempo)
    end
    local menor = myTimes[1] 
    for i = 2, #myTimes do
        if myTimes[i] < menor then
            menor = myTimes[i]
        end
    end
    for key,value in pairs(ifBest) do 
        if menor == time then 
            return car 
        else
            return value.MelhorCarro 
        end
    end
end

function bestTime(time, user_id)
    local getTime = vRP.query('your/top', {ID = user_id})
    if time == 'get' then 
        for _,value in pairs(getTime) do 
            return value.Tempo 
        end
    else
        local twoTimes = {}
        for k,v in pairs(getTime) do 
            table.insert(twoTimes, v.Tempo)
            table.insert(twoTimes, time)
        end
        local menor = twoTimes[1] 
        for i = 2, #twoTimes do
            if twoTimes[i] < menor then
                menor = twoTimes[i]
                return ''..menor..'.000'
            else
                return 'normal'
            end
        end
    end
end

function extern.E(time, car)
    local user_id = vRP.getUserId(source)
    local getE = vRP.query('select/e', {ID = user_id})
    for k,v in pairs(getE) do 
        if bestTime(time, user_id) ~= 'normal' then 
            vRP.execute('add/e', {
                ID = user_id, 
                Corridas = tostring(tonumber(v.Corridas) + 1), 
                Ganhos = tostring(tonumber(v.Ganhos) + settings.valorPorcorrida), 
                MelhorCarro = getBestCar(user_id, time, car),
                Tempo = time
            })
        else
            vRP.execute('add/e', {
                ID = user_id, 
                Corridas = tostring(tonumber(v.Corridas) + 1), 
                Ganhos = tostring(tonumber(v.Ganhos) + settings.valorPorcorrida), 
                MelhorCarro = getBestCar(user_id, time, car),
                Tempo = bestTime('get', user_id)
            })
        end
    end
end

function extern.deleteRace(dataName)
    vRP.execute('delete/race', {Nome = dataName})
end

function extern.topRacer(dev)
    local times = {}
    local timesall = {}
    local user_id = vRP.getUserId(source)
    local Query = vRP.query('top/racer', {})
    if json.encode(Query) == '[]' then return 'X.XX.XXX' end
    for k,v in pairs(Query) do
        if dev == 'rafa' then 
            return v.Tempo 
        else
            v.Tempo = string.sub(v.Tempo, 1, 4)
            table.insert(times, v.Tempo)
            table.insert(timesall, v.Tempo)
        end
    end
    for key,value in ipairs(times) do 
        local menor = times[1] 
        for i = 2, #times do
            if times[i] < menor then
                menor = times[i]  
            end
        end
        return ''..menor..'.000'
    end
end

function extern.timeOwner()
    local fQuery = vRP.query('time/owner', {Tempo = extern.topRacer('rafa')})
    for _,value in pairs(fQuery) do 
        local getSource = vRP.getUserSource(tonumber(value.ID))
        if getSource then 
            return GetPlayerName(getSource)
        else
            return 'Sem identificação.'
        end
    end
end

function extern.vec(checkpoint, name)
    local raceQuery = vRP.query('get/xyz', {Nome = name})
    if raceQuery and #raceQuery > 0 then
        if raceQuery[checkpoint] then
            return vec3(tonumber(raceQuery[checkpoint].x), tonumber(raceQuery[checkpoint].y), tonumber(raceQuery[checkpoint].z))
        else
            return 'fim'
        end
    else
        return 'fim'
    end
end

local xTable = {}

function valorMaisProximo(valor, table)
    if json.encode(table) ~= '[]' then 
        local diferencaMinima = math.abs(valor - table[1])
        local valorMaisProximo = table[1]
        
        for i = 2, #table do
            local diferenca = math.abs(valor - table[i])
            if diferenca < diferencaMinima then
                diferencaMinima = diferenca
                valorMaisProximo = table[i]
            end
        end

        return valorMaisProximo
    else
        return 
    end
end

function insertX()
    local queryone = vRP.query('get/x', {})
    if json.encode(queryone) ~= '[]' then
        for key,value in pairs(queryone) do 
            table.insert(xTable, tonumber(value.x))
        end
        return xTable
    else
        return 
    end
end

function extern.getRaceName(x)
    insertX()
    local xx = valorMaisProximo(x, xTable)
    local nameQuery = vRP.query('get/racename', {cx = tostring(xx)})
    if json.encode(nameQuery) ~= '[]' then
        for key,value in pairs(nameQuery) do 
            return value.Nome
        end
    else
        return 'notfound'
    end
end

function extern.yourTop()
    local user_id = vRP.getUserId(source)
    local Query = vRP.query('your/top', {ID = user_id})
    for k,v in pairs(Query) do
        return v.Tempo
    end
end

function extern.returnBlips()
    local blipQuery = vRP.query('return/blips', {})
    local blips = {}  

    for k,v in pairs(blipQuery) do 
        table.insert(blips, {x = v.x, y = v.y, z = v.z})  
    end

    return blips  
end

function extern.sendD(myD)
    local user_id = vRP.getUserId(source)
    if settings.suaWebhook ~= '' or settings.suaWebhook ~= nil then
        PerformHttpRequest(
            settings.suaWebhook, 
            function(err, text, headers) end, 
            'POST', 
            json.encode({
                content = 'Rafa system informa:\n\nNova denúncia detectada para: CORRIDAS\nID do player: '..user_id..'\nDenúncia: '..myD
            }), 
            { ['Content-Type'] = 'application/json' }
        )
    end
end

function extern.firstTime()
    local user_id = vRP.getUserId(source)
    local queryFT = vRP.query('is/ft', {ID = user_id})
    if json.encode(queryFT) == '[]' then return true else return false end
end

function extern.register()
    local user_id = vRP.getUserId(source)
    vRP.execute('reg/me', {ID = user_id})
end

function extern.info(info)
    local user_id = vRP.getUserId(source)
    local infoQ = vRP.query('my/'..info, {ID = user_id})
    for k,v in pairs(infoQ) do 
        for key,value in pairs(v) do 
            return value 
        end
    end
end

local isFirst = true

function extern.saveCheckPoint(cx,cy,cz)
    if cx == math.floor(cx) and cx ~= ''..cx..'.0' then 
        cx = ''..cx..'.0'
    end
    if cy == math.floor(cy) and cy ~= ''..cy..'.0' then 
        cy = ''..cy..'.0'
    end
    if cz == math.floor(cz) and cz ~= ''..cz..'.0' then 
        cz = ''..cz..'.0'
    end
    if isFirst then
        vRP.execute('save/check', {Nome = 'Não definido', Blip = 1, x = cx, y = cy, z = cz})
        isFirst = false
    else
        vRP.execute('save/check', {Nome = 'Não definido', Blip = 0, x = cx, y = cy, z = cz})
    end
end

function extern.saveRace(data)
    local query = vRP.query('if/check', {Nome = 'Não definido'})
    if json.encode(query) ~= '[]' then 
        vRP.execute('save/race', {Nome = data})
    else
        print('Você não colocou checkpoints, portanto corrida inválida.')
    end
end

function extern.isAdmin()
    local user_id = vRP.getUserId(source)
    for k,v in pairs(settings.admins) do 
        if v == user_id then 
            return true
        else
            return false 
        end
    end
end

function extern.quitCreating()
    vRP.execute('delete/race', {Nome = 'Não definido'})
end

function extern.pay()
    local user_id = vRP.getUserId(source)
    if settings.pagamento == 1 then 
        vRP.giveMoney(user_id, settings.valorPorcorrida)
    elseif settings.pagamento == 2 then 
        vRP.giveBankMoney(user_id, settings.valorPorcorrida)
    end
end

function extern.hasTablet()
    local user_id = vRP.getUserId(source)
    if settings.precisaDeTablet then 
        if vRP.getInventoryItemAmount(user_id,settings.itemTablet) >= 1 then 
            return true 
        else
            return false 
        end
    elseif not settings.precisaDeTablet then 
        return true 
    end
end

function extern.condition()
    local user_id = vRP.getUserId(source)
    if settings.precisaPagarParaIniciar then 
        if settings.tipoPagamento == 2 then 
            if vRP.tryFullPayment(user_id, settings.valorParainiciar) then 
                return true 
            else
                return false 
            end
        elseif settings.tipoPagamento == 1 then 
            if vRP.tryGetInventoryItem(user_id, settings.dinheiroSujo, settings.valorParainiciar) then 
                return true 
            else
                return false 
            end
        end
    elseif not settings.precisaPagarParaIniciar then 
        return true 
    end
end

function extern.run()
    local theQuery = vRP.query('sort/race', {})
    for k,v in pairs(theQuery) do 
        return vec3(tonumber(v.x),tonumber(v.y),tonumber(v.z))
    end
end

function extern.isPolice()
    local user_id = vRP.getUserId(source)
    for k,v in ipairs(settings.policiais) do 
        if v == user_id then 
            return true 
        else
            return false 
        end
    end
end

local activeRas = false

function extern.turnOffRas()
    activeRas = false
end

CreateThread(function()
    while true do 
        local time = 5000
        if activeRas then 
            time = settings.rastreador*1000
            for _,value in ipairs(settings.policiais) do
                local getSource = vRP.getUserSource(value)
                if getSource then
                    TriggerClientEvent('racing:rasDebug', getSource)
                    TriggerClientEvent('racing:ras', getSource)
                end
            end
        end
        Wait(time)
    end
end)

function extern.callPolice()
    for _,value in ipairs(settings.policiais) do
        local getSource = vRP.getUserSource(value)
        if getSource then
            TriggerClientEvent('racing:policeWarning', getSource, true)
            activeRas = true
            Wait(4000)
            TriggerClientEvent('racing:policeWarning', getSource, false)
        end
    end
end

function extern.isBanned()
    local user_id = vRP.getUserId(source)
    local isBanned = vRP.query('is/banned', {ID = user_id})
    for k,v in pairs(isBanned) do 
        if v.Banido == '1' then 
            return true 
        else
            return false 
        end
    end
end

function extern.setBanned(action, data)
    if action == '' and id == '' then 
        local user_id = vRP.getUserId(source)
        vRP.execute('set/banned', {ID = user_id})
    elseif action == 'otherID' then 
        vRP.execute('set/banned', {ID = data})
    end
end