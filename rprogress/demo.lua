------------------------------------------------------------
--                          DEMO                          --
------------------------------------------------------------

TriggerEvent('chat:addSuggestion', '/rprogressStart', 'rprogress Start Demo', {
    { name="Label", help="The label to show" },
    { name="Duration (ms)", help="Duration of progress" }
})

TriggerEvent('chat:addSuggestion', '/rprogressAsync', 'rprogress Async Demo', {
    { name="Duration (ms)", help="Duration of progress" }
})

TriggerEvent('chat:addSuggestion', '/rprogressSync', 'rprogress Sync Demo', {
    { name="Duration (ms)", help="Duration of progress" }
})

TriggerEvent('chat:addSuggestion', '/rprogressCustom', 'rprogress Custom Demo', {
    { name="From (0-100)", help="Percentage to start from" },
    { name="To (0-100)", help="Percentage to stop at" },
    { name="Duration (ms)", help="Duration of progress" },
    { name="Radius (px)", help="Radius of the dial" },
    { name="Stroke (px)", help="Stroke width of bar" },
    { name="MaxAngle (deg)", help="Maximum arc of dial" },
    { name="Rotation (deg)", help="Rotation angle of dial" },
})

RegisterCommand("rprogressStart", function(source, args, raw)
    Start(args[1], tonumber(args[2]), function(data, cb)
        ShowNotification("~g~Event: onComplete")
    end) 
end)

RegisterCommand("rprogressSync", function(source, args, raw)
    ShowNotification("~b~Event: before")
    Custom({
        Async = false,
        Duration = tonumber(args[1]),
        onStart = function(data, cb)
            ShowNotification("~b~Event: onStart")
        end,
        onComplete = function(data, cb)
            ShowNotification("~g~Event: onComplete")
        end
    }) 
    ShowNotification("~g~Event: after")
end)

RegisterCommand("rprogressAsync", function(source, args, raw)
    ShowNotification("~b~Event: before")
    Custom({
        Duration = tonumber(args[1]),
        onStart = function(data, cb)
            ShowNotification("~b~Event: onStart")
        end,
        onComplete = function(data, cb)
            ShowNotification("~g~Event: onComplete")
        end
    }) 
    ShowNotification("~g~Event: after")
end)

RegisterCommand("rprogressCustom", function(source, args, raw)
    Custom({
        From = tonumber(args[1]),
        To = tonumber(args[2]),
        Duration = tonumber(args[3]),
        Radius = tonumber(args[4]) or Config.Radius,
        Stroke = tonumber(args[5]) or Config.Stroke,
        MaxAngle = tonumber(args[6]) or Config.MaxAngle,
        Rotation = tonumber(args[7]) or Config.Rotation,
        onStart = function(data, cb)
            ShowNotification("~b~Event: onStart")
        end,
        onComplete = function(data, cb)
            ShowNotification("~g~Event: onComplete")
        end
    }) 
end)

RegisterCommand("rprogressStatic", function(source, args, raw)
    local ProgressBar = NewRadialProgress({
        Label = "Foo",
        ShowProgress = true
    })

    local last = 0

    math.randomseed(GetGameTimer())

    for i = 1, 40 do
        Citizen.Wait(250)

        local max = last + 5

        local progress = math.random (last, max)

        if progress > 100 then
            progress = 100
        end

        ProgressBar.SetProgress(progress)
    
        last = last + 5

        if progress >= 100 then

            Citizen.Wait(1000)          

            ProgressBar.Remove()

            break
        end
    end  
end)