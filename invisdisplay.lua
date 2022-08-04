--[[
    Created by Sic
    -- Thanks to the lua peeps, SpecialEd, kaen01, dannuic, knightly, aquietone, brainiac and all the others
--]]

local mq = require 'mq'
require 'ImGui'
require('lib.sic.utilfunc')

-- GUI Control variables
local openGUI = true
local shouldDrawGUI = true

local invisdisplaymsg = '\ao[\agInvisDisplay\ao]\ag::\aw'

local function whattodisplay(i)
    if not anon then
        return mq.TLO.Group.Member(i).Name()
    elseif anon then 
        return mq.TLO.Group.Member(i).Class.ShortName()
    end
end

local function solodisplay()
    if not anon then
        return mq.TLO.Me.Name()
    elseif anon then 
        return mq.TLO.Me.Class.ShortName()
    end
end

-- ImGui main function for rendering the UI window
-- local uisample = function()
local bdebug = true
local invisDisplay = function()
    local draw = isAnyoneInvis()
    if draw then
        openGUI, shouldDrawGUI = ImGui.Begin('##Invis', openGUI, getFlagForLockedState())
        if shouldDrawGUI then
            local meinvis = mq.TLO.Me.Invis()  
            if meinvis then
                local invistype = 0

                if mq.TLO.Me.Invis(1)() then
                    invistype = invistype + 1
                end

                if mq.TLO.Me.Invis(2)() then
                    invistype = invistype + 2
                end

                if invistype == 3 then
                    -- both invis types; green
                    ImGui.TextColored(0.05, 0.95, 0.05, 1, solodisplay(i))
                elseif invistype == 2 then
                    -- ivu; blue
                    ImGui.TextColored(0.0, 0.2, 1.0, 1, solodisplay(i))
                elseif invistype == 1 then
                    -- regular invis; pink
                    ImGui.TextColored(0.9, 0.5, 1.0, 1, solodisplay(i))
                end
            end

            local groupsize = mq.TLO.Me.GroupSize()
            local grouped = mq.TLO.Me.Grouped()
            if grouped and groupsize > 0 then
                for i = 1, groupsize do
                    local groupinvis = mq.TLO.Group.Member(i).Invis()           
                    if groupinvis then
                        -- mq/eq does not let us know which kind
                        ImGui.TextColored(0.05, 0.95, 0.05, 1, whattodisplay(i))
                    end
                end
            end
        end
        ImGui.End()
    end
end

mq.imgui.init('invisDisplay', invisDisplay)

local function help()
    printf('%s \agInvisDisplay options include:', invisdisplaymsg)
    printf('%s \aounlock \ar---> \ag unlocks the window so you can move, size, and place it.', invisdisplaymsg)
    printf('%s \aolock \ar---> \ag locks the window, making it click through, transparent, and immovable.', invisdisplaymsg)
    printf('%s \aoanon on \ar---> \agDisplays Class ShortName instead of Character Name.', invisdisplaymsg)
    printf('%s \aoanon off \ar---> \agDisplays Character Name of Class ShortName.', invisdisplaymsg)
end

local function do_invisdisplay(cmd, cmd2)
    if cmd == 'unlock' then
        printf('%s \agUnlocked!', invisdisplaymsg)
        locked = false
    end

    if cmd == 'lock' then
        printf('%s \agLocked!', invisdisplaymsg)
       locked = true
    end

    if cmd == 'anon' then
        if cmd2 ~= nil and cmd2 == 'on' then
            printf('%s \agAnon on!', invisdisplaymsg)
            anon = true
        elseif cmd2 ~= nil and cmd2 == 'off' then
            printf('%s \agAnon off!', invisdisplaymsg)
            anon = false
        end
    end
end

local function bind_invisdisplay(cmd, cmd2)
    if cmd == nil or cmd == 'help' then 
       help()
       return
    end

    do_invisdisplay(cmd, cmd2)
end

local function setup()
    -- make the bind
    mq.bind('/invisdisplay', bind_invisdisplay)
    printf('%s \aoby \agSic', invisdisplaymsg)
    printf('%s Please \ar\"/invisdisplay help\"\ax for a options.', invisdisplaymsg)
end

local function main()
    while true do
        mq.delay(300)
    end
end

-- set it the bind and such
setup()
-- run the main loop
main()