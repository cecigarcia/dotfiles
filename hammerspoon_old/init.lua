-----------------------------------
-- Configuration watcher
-----------------------------------
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
hs.alert("Config loaded")


-----------------------------------
-- Modal bindings
-----------------------------------
b = hs.hotkey.modal.new({"cmd"}, "return")

b:bind({"cmd"}, "return", function() end)
b:bind({}, "escape", function() b:exit() end)

b:bind({}, "c", function() hs.application.launchOrFocus("Google Chrome") b:exit() end)
b:bind({}, "t", function() hs.application.launchOrFocus("iTerm") b:exit() end)
b:bind({}, "s", function() hs.application.launchOrFocus("Spotify") b:exit() end)
b:bind({}, "i", function() hs.application.launchOrFocus("IntelliJ IDEA 14") b:exit() end)


-----------------------------------
-- Window management
-----------------------------------

--------------------
-- Smart grid
--------------------
function gridOp(op, cell)
    if (op.x ~= null) then
        cell.x = cell.x + op.x
    end
    if (op.y ~= null) then
        cell.y = cell.y + op.y
    end
    if (op.w ~= null) then
        cell.w = cell.w + op.w
    end
    if (op.h ~= null) then
        cell.h = cell.h + op.h
    end
    return cell
end

function expandToRight(cell)  return gridOp({w = 1},         cell) end
function expandToLeft(cell)   return gridOp({x = -1, w = 1}, cell) end
function expandToBottom(cell) return gridOp({h = 1},         cell) end
function expandToTop(cell)    return gridOp({y = -1, h = 1}, cell) end

function shrinkToRight(cell)  return gridOp({x = 1, w = -1}, cell) end
function shrinkToLeft(cell)   return gridOp({w = -1},        cell) end
function shrinkToBottom(cell) return gridOp({y = 1, h = -1}, cell) end
function shrinkToTop(cell)    return gridOp({h = -1}       , cell) end

function smartResizeRight(cell)
    if ((cell.x + cell.w >= hs.grid.GRIDWIDTH) and (cell.w > 1)) then
        return shrinkToRight(cell)
    elseif ((cell.x + cell.w < hs.grid.GRIDWIDTH) and (cell.w < hs.grid.GRIDWIDTH)) then
        return expandToRight(cell)
    end
end

function smartResizeLeft(cell)
    if (cell.x + cell.w >= hs.grid.GRIDWIDTH) then
        if (cell.x > 0) then
            return expandToLeft(cell)
        else
            return shrinkToLeft(cell)
        end
    else
        if (cell.w > 1) then
            return shrinkToLeft(cell)
        elseif (cell.x > 0) then
            return expandToLeft(cell)
        end
    end
end

function smartResizeDown(cell)
    if ((cell.y + cell.h >= hs.grid.GRIDHEIGHT) and (cell.h > 1)) then
        return shrinkToBottom(cell)
    elseif ((cell.y + cell.h < hs.grid.GRIDHEIGHT) and (cell.h < hs.grid.GRIDHEIGHT)) then
        return expandToBottom(cell)
    end
end

function smartResizeUp(cell)
    if (cell.y + cell.h >= hs.grid.GRIDHEIGHT) then
        if (cell.y > 0) then
            return expandToTop(cell)
        else
            return shrinkToTop(cell)
        end
    else
        if (cell.h > 1) then
            return shrinkToTop(cell)
        elseif (cell.y > 0) then
            return expandToTop(cell)
        end
    end
end

function smartResizeWindowRight() hs.grid.adjustFocusedWindow(smartResizeRight) end
function smartResizeWindowLeft() hs.grid.adjustFocusedWindow(smartResizeLeft) end
function smartResizeWindowUp() hs.grid.adjustFocusedWindow(smartResizeUp) end
function smartResizeWindowDown() hs.grid.adjustFocusedWindow(smartResizeDown) end

function adjustGrid(h, w) hs.grid.adjustHeight(h) hs.grid.adjustWidth(w) end
function increaseGrid() adjustGrid(1, 1) end
function decreaseGrid() adjustGrid(-1, -1) end


--------------------
-- Bindings
--------------------
hs.window.animationDuration = 0
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 2
hs.grid.GRIDHEIGHT = 2

local cmd = {"cmd"}
local cmdalt = {"cmd", "alt"}
local ctrlcmdalt = {"ctrl", "cmd", "alt"}

hs.hotkey.bind(cmdalt, "s", function() hs.hints.windowHints() end)

hs.hotkey.bind(cmdalt, "h", function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(cmdalt, "l", function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(cmdalt, "k", function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(cmdalt, "j", function() hs.window.focusedWindow():focusWindowSouth() end)

hs.hotkey.bind(ctrlcmdalt, "f", function() hs.window.focusedWindow():toggleFullScreen() end)

hs.hotkey.bind(ctrlcmdalt, "h", hs.grid.pushWindowLeft)
hs.hotkey.bind(ctrlcmdalt, "j", hs.grid.pushWindowDown)
hs.hotkey.bind(ctrlcmdalt, "k", hs.grid.pushWindowUp)
hs.hotkey.bind(ctrlcmdalt, "l", hs.grid.pushWindowRight)

hs.hotkey.bind(ctrlcmdalt, "u", smartResizeWindowDown)
hs.hotkey.bind(ctrlcmdalt, "i", smartResizeWindowUp)
hs.hotkey.bind(ctrlcmdalt, "o", smartResizeWindowRight)
hs.hotkey.bind(ctrlcmdalt, "y", smartResizeWindowLeft)

-- hs.hotkey.bind(cmdalt, "[", decreaseGrid)
-- hs.hotkey.bind(cmdalt, "]", increaseGrid)

hs.hotkey.bind(ctrlcmdalt, "n", function() hs.grid.pushWindowNextScreen() end)
hs.hotkey.bind(ctrlcmdalt, "p", function() hs.grid.pushWindowPreviousScreen() end)

hs.hotkey.bind(ctrlcmdalt, "m", hs.grid.maximizeWindow)

hs.hotkey.bind(cmdalt, "delete", function() hs.window.focusedWindow():close() end)
hs.hotkey.bind(ctrlcmdalt, "delete", function() hs.window.focusedWindow():application():kill() end)


-----------------------------------
-- Window cleaner
-----------------------------------
__tostring_for_arrays = function(self)
    result = ""
    width = 0
    for i,v in hs.fnutils.sortByKeyValues(self) do result = result..tostring(v).."\n" end
    return result
end

closeList  = setmetatable({}, { __tostring = __tostring_for_arrays })
quitList   = setmetatable({}, { __tostring = __tostring_for_arrays })

closeQuitWatcher = hs.application.watcher.new(function(name, event, hsapp)
    if event == hs.application.watcher.deactivated then
        for i,v in ipairs(closeList) do
            if name and v == name then
                if #hsapp:allWindows() == 1 then hsapp:allWindows()[1]:close() end
                break
            end
        end
        for i,v in ipairs(quitList) do
            if name and v == name then
                hsapp:kill()
                break
            end
        end
    end
end)

closeQuitWatcher:start()
