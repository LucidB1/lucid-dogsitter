Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local player = PlayerPedId();
        local coords = GetEntityCoords(player, true);
        for k, v in pairs(Config.employerNpc) do
            local dist = #(coords - v.employer_coords)
            if dist < 15 then
                if v.employer_handler == nil then
                    createEmployer(v)

                    if(not v.active)then
                        createDog(v)
                    end
                end
            else
                if(v.employer_handler ~= nil) then
                    deleteEmployer(v)
                end
                if(v.dog_handler ~= nil) then

                    if(not v.active) then
                        deleteDog(v)
                    end
                end
            end
        end
    end
end)

function PlayAnimation(ped, dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 2, 0.0, 0, 0, 0)
end

function deleteDog(ped)

    if(ped.dog_handler ~= nil) then
        if DoesEntityExist(ped.dog_handler) then
            DeleteEntity(ped.dog_handler)

            ped.dog_handler = nil
        end
    end
end

function deleteEmployer(ped)
    
    if(ped.employer_handler ~= nil) then
        if DoesEntityExist(ped.employer_handler) then
            DeleteEntity(ped.employer_handler)
            ped.employer_handler = nil

        end
    end
end



function createDog(ped)
    RequestModel(ped.dog_model)
    while not HasModelLoaded(ped.dog_model) do
        Wait(0)
    end

    ped.dog_handler = CreatePed(1, ped.dog_model, ped.dog_coords.x, ped.dog_coords.y, ped.dog_coords.z - 1.0, ped.dog_heading, false, true)
    SetEntityHeading(ped.dog_handler, ped.heading)
    TaskSetBlockingOfNonTemporaryEvents(ped.dog_handler, true)
    SetPedFleeAttributes(ped.dog_handler, 0, 0)
    SetPedCombatAttributes(ped.dog_handler, 17, 1)
    SetPedSeeingRange(ped.dog_handler, 0.0)
    SetPedHearingRange(ped.dog_handler, 0.0)
    SetPedAlertness(ped.dog_handler, 0)
    SetPedKeepTask(ped.dog_handler, true)
    SetEntityInvincible(ped.dog_handler, true)
    SetBlockingOfNonTemporaryEvents(ped.dog_handler, true)
    PlayAnimation(ped.dog_handler, Config.dog_anim['sit'].dict, Config.dog_anim['sit'].anim)
    FreezeEntityPosition(ped.dog_handler, true)
    SetModelAsNoLongerNeeded(ped.dog_model)  
end


function createEmployer(ped)
    RequestModel(ped.employer_model)
    while not HasModelLoaded(ped.employer_model) do
        Wait(0)
    end


    ped.employer_handler = CreatePed(1, ped.employer_model, ped.employer_coords.x, ped.employer_coords.y, ped.employer_coords.z - 1.0, ped.employer_heading, false, true)
    SetEntityHeading(ped.employer_handler, ped.employer_heading)
    TaskSetBlockingOfNonTemporaryEvents(ped.employer_handler, true)
    SetPedFleeAttributes(ped.employer_handler, 0, 0)
    SetPedCombatAttributes(ped.employer_handler, 17, 1)
    SetPedSeeingRange(ped.employer_handler, 0.0)
    SetPedHearingRange(ped.employer_handler, 0.0)
    SetPedAlertness(ped.employer_handler, 0)
    SetPedKeepTask(ped.employer_handler, true)
    SetEntityInvincible(ped.employer_handler, true)
    SetBlockingOfNonTemporaryEvents(ped.employer_handler, true)
    FreezeEntityPosition(ped.employer_handler, true)
    SetModelAsNoLongerNeeded(ped.employer_model)   
end

