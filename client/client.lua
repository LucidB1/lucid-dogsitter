
QBCore = nil
local activejobData = {}
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
         if QBCore == nil then
             TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
             Citizen.Wait(200)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local player = PlayerPedId();
        local coords = GetEntityCoords(player, true);
        for k, v in pairs(Config.employerNpc) do
            local dist = #(coords - v.employer_coords)
            if dist < 10 then
                QBCore.Functions.DrawText3D(v.employer_coords.x, v.employer_coords.y,v.employer_coords.z + 1.0, v.active and 'E - Give the dog back' or   v.draw_text_label)
                if dist < 3.0 then
                    if IsControlJustPressed(0, 38) then
                        if v.active then
                            if(v.time <= 1) then
                                rewardPlayer(v)
                                v.active = false
                                activejobData = getActiveJobsData();
                                deleteDog(v)
                                createDog(v)
                            else
                                
                                QBCore.Functions.Notify("You didn't get your money because you didn't finish the time", 'error')
                                v.active = false
                                activejobData = getActiveJobsData();
                                deleteDog(v)
                                createDog(v)
                            end
                        else
                            startConversation(v)
                        end
                    end
                end           
            end
        end
    end
end)



local conversationActive = false

function rewardPlayer(ped)
    TriggerServerEvent('lucid-dogsitter:rewardPlayer', ped.price)
end

function startConversation(ped)
    CinematicCamDisplay(true) 
    createCamera(ped.employer_handler)
    for k,v in pairs(ped.possible_dialogs) do
        local selectedDialog = v[math.random(1, #v)]
        ped.dialogs[k] = {label = selectedDialog.label, owner = selectedDialog.owner };
    end

   for i = 1, #ped.dialogs, 1 do
       conversationActive = true
       while conversationActive do
           Citizen.Wait(0)  
           drawTxt(#ped.dialogs[i].label < 40 and 0.42  or 0.38 , 0.96, (ped.dialogs[i].owner == 'player' and GetPlayerName(PlayerId()) or ped.employer_name) .. ' : '..ped.dialogs[i].label)
       end
   end
    ped.price = ped.possible_prices[math.random(1, #ped.possible_prices)]
    ped.time = ped.possible_times[math.random(1, #ped.possible_times)]

    ped.active = true
    FreezeEntityPosition(ped.dog_handler, false)
    TaskFollowToOffsetOfEntity(ped.dog_handler, PlayerPedId(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
    SetPedKeepTask(ped.dog_handler, true)
    CinematicCamDisplay(false) 
    closeCam()
    activejobData = getActiveJobsData();
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if (next(activejobData) ~= nil) then
            for k,v in pairs(activejobData) do
                if v.time > 1 and (IsPedWalking(PlayerPedId()) or IsPedSprinting(PlayerPedId())) then
                    v.time = v.time - 1000
                elseif v.time <= 0 then
                    v.time = 1
                    finishJob(v)
                end
            end
        end
    end
end)


function finishJob(activejob)
    QBCore.Functions.Notify("The dog is tired you have to return it to home", 'primary')
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        if (next(activejobData) ~= nil) then
            if IsPedInAnyVehicle(PlayerPedId()) then
                QBCore.Functions.Notify("You can't enter vehicle while dog sitter job active", 'error')
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (next(activejobData) ~= nil) then
            for k,v in pairs(activejobData) do
            
                if v.time > 2 then
                    drawTxt(0.45 + (k / 10), 0.96, 'You have ' ..  msToTime(v.time) .. ' time to left for job '.. k )
                end
            end
        end
    end
end)



function getActiveJobsData()
    local activejobs = {}
    for k, v in pairs(Config.employerNpc) do
        if v.active then
            table.insert(activejobs, v)
        end
    end
    return activejobs
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if conversationActive then
            Citizen.Wait(3500)
            conversationActive = false
        end
    end
end)


function msToTime(ms) 
    
    local x = nil
    local seconds = nil
    local minutes = nil
    local hours = nil

    x = ms / 1000
    seconds = x % 60
    x = x / 60
    minutes = x % 60
    x = x / 60
    hours = x % 24
    x = x  /  24
    days = x

    return math.floor(minutes) .. ' : ' .. math.floor(seconds) 
end








