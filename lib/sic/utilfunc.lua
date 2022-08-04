--[[
    Created by Sic
    -- Thanks to the lua peeps, SpecialEd, kaen01, dannuic, knightly, aquietone, brainiac and all the others


    This will act as a little include library for reused functions
--]]


local mq = require('mq')

locked = true
anon = false

--[[

    i did not get the color stuff working this way. maybe soon

--]]
-- Colors w/ full alpha
color_green = { 0, 1, 0, 1 }
color_red = '1, 0, 0, 1'
color_blue = '0, 0, 1, 1'

function Color_Text(rgba_t, text)
    local t = { unpack(rgba_t) }
    table.insert(t, #t+1, text)
    print(t)
    return unpack(t)
end

function printf(s,...)
    return print(string.format(s,...))
end

function isAnyoneInvis()
    local groupsize = mq.TLO.Me.GroupSize()
    if groupsize ~= nil and groupsize > 0 then
        for i = 0, mq.TLO.Me.GroupSize() do
            if not mq.TLO.Group.Member(i).OtherZone() and mq.TLO.Group.Member(i).Invis() then
                return true
            end
        end
    end
    
    return mq.TLO.Me.Invis()
end

-- If we "unlock" the window we want to be able to move it and resize it
-- If we "lock" the window, we don't want to be able to click it, resize it, move it, etc.
-- Do you have a flag?!
function getFlagForLockedState()
    if locked then
        return bit32.bor(ImGuiWindowFlags.NoTitleBar, ImGuiWindowFlags.NoBackground, ImGuiWindowFlags.NoResize, ImGuiWindowFlags.NoMove, ImGuiWindowFlags.NoInputs)
    elseif not locked then
        return bit32.bor(ImGuiWindowFlags.NoTitleBar)
    end
end