ESX = nil

Citizen.CreateThread(function()

    TriggerEvent('esx:getSharedObject', function(obj)
         ESX = obj
    end)

    while ESX == nil do Citizen.Wait(0) end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	Camera()
end)

local PanelChargement = false
local Percentage = 0.0

function MenuConnexion()
    local CMenu = RageUI.CreateMenu('Menu Connexion', '~g~Five Dev')
    CMenu:SetRectangleBanner(11, 11, 11, 1)
        RageUI.Visible(CMenu, not RageUI.Visible(CMenu))
            while CMenu do
            Citizen.Wait(0)
            RageUI.IsVisible(CMenu, true, true, true, function()

                RageUI.ButtonWithStyle("Appuyez sur ~y~[ENTER]~s~ pour continuer",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        PanelChargement = true
                    end
                end)


            if PanelChargement == true then
                RageUI.PercentagePanel(Percentage or 0.0, "Connexion ... ("..math.floor(Percentage * 100).."%)", "", "",  function(Hovered, Active, Percent)
                    if Percentage < 1.0 then
                        Percentage = Percentage + 0.004
                    else
                        DoScreenFadeOut(1000)
                        Citizen.Wait(2000)
                        RenderScriptCams(false, false, 0, true, true)
                        Wait(1000)
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                        SetEntityVisible(GetPlayerPed(-1), true, 0)
                        RageUI.CloseAll()
                        DoScreenFadeIn(2000)
                        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_MOBILE", 0, 0)
                        Wait(4000)
                        ClearPedTasks(GetPlayerPed(-1))
                        ESX.ShowAdvancedNotification("Bienvenue", "~g~Information", "Bienvenue sur ~y~FiveDev", 'CHAR_MP_FM_CONTACT', 1)
                        DisplayRadar(true)
                    end
                end)
            end
                
            end, function()
            end)            
            if not RageUI.Visible(CMenu) then
            CMenu = RMenu:DeleteType("CMenu", true)
        end
    end
end


function Camera()
    DoScreenFadeOut(1000)
    Wait(1000)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityVisible(GetPlayerPed(-1), false, 0)
    CamCo = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamCoord(CamCo, -237.88, -832.78, 365.70)
    SetCamRot(CamCo, 0.0, 0.0, 358.21)
    SetCamFov(CamCo, 45.97)
    ShakeCam(CamCo, "HAND_SHAKE", 0.1)
    SetCamActive(CamCo, true)
    RenderScriptCams(true, false, 2000, true, true)
    DisplayRadar(false)
    MenuConnexion()
    Wait(500)
    DoScreenFadeIn(1000)
end