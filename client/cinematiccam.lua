
local CinematicCamBool = false
local CinematicCamMaxHeight = 0.2 
local w = 0
local openedcam = false
local cameras = {}


Citizen.CreateThread(function() 

    minimap = RequestScaleformMovie("minimap")
    if not HasScaleformMovieLoaded(minimap) then
        RequestScaleformMovie(minimap)
        while not HasScaleformMovieLoaded(minimap) do 
            Wait(1)
        end
    end

    while true do
        Citizen.Wait(1)
        if w > 0 then
            DrawRects()
        end
        if CinematicCamBool then
            DESTROYHudComponents()
        end
    end
end)

function DESTROYHudComponents() 
    for i = 0, 22, 1 do
        if IsHudComponentActive(i) then
            HideHudComponentThisFrame(i)
        end
    end
end

function DrawRects() 
    DrawRect(0.0, 0.0, 2.0, w, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, w, 0, 0, 0, 255)
end

function DisplayHealthArmour(int) 
    BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(int)
    EndScaleformMovieMethod()
end

function CinematicCamDisplay(bool) 
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    if bool then
        DisplayRadar(false)
        DisplayHealthArmour(3)
        CinematicCamBool = bool
        for i = 0, CinematicCamMaxHeight, 0.01 do 
            Wait(10)
            w = i
        end
    else
        DisplayRadar(true)
        CinematicCamBool = bool
        DisplayHealthArmour(0)
        for i = CinematicCamMaxHeight, 0, -0.01 do
            Wait(10)
            w = i
        end 
    end
end 


function createCamera(ent)
    DoScreenFadeOut(100)
    Citizen.Wait(750)
    local pedCoords = GetEntityCoords(PlayerPedId(), true)
    local coordsCam = GetOffsetFromEntityInWorldCoords(ent, 0.0, 1.5, 0.8)
    local entity = GetEntityCoords(ent)
    local cam1 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", (coordsCam.x), (coordsCam.y ), (coordsCam.z ), 0.00, 0.00, 39.00, 35.0, false, 2)
    cameras = {
        ['ped'] = cam1,
    }
    PointCamAtCoord(cameras.ped, entity.x , entity.y, (entity.z + 0.65))
    openedcam = true
    SetCamActive(cameras.ped, true)
    RenderScriptCams(true, true, 500, true, true)
    SetEntityVisible(PlayerPedId(), false)
    DoScreenFadeIn(100)

end

function closeCam()
    if openedcam then

        DoScreenFadeOut(100)
        Citizen.Wait(750)
        SetCamActive(cameras['ped'], false)
        DestroyCam(cameras['ped'], true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
        DisplayRadar(true)
        openedcam = false
        SetEntityVisible(PlayerPedId(), true)

        CinematicCamBool = false
        CinematicCamDisplay(CinematicCamBool)
        DoScreenFadeIn(100)

    end
end


function drawTxt(x, y, text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.30)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end