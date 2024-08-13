-----------------------------------------------------------------------------------------
--
-- startScene.lua | Ashton EMMETT | 10564416 | Programming Languages and Paradigms 
--
-----------------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- next scene function
local function goToRollScene(event)
    if event.phase == "ended" then
        composer.gotoScene("diceRollerScene", { effect = "slideLeft", time = 500 })
    end
end

function scene:create(event)
    local sceneGroup = self.view

    -- create title text
    local titleText = display.newText(sceneGroup, "Dice Roller", display.contentCenterX, -30, native.systemFontBold, 24)
    titleText:setFillColor(1, 1, 1)  -- Set text color to white

    -- create start button
    local startButton = widget.newButton {
        label = "Start",
        labelColor = { default = { 1, 1, 1 }, over = { 0, 1, 0 } },
        onEvent = goToRollScene,
        emboss = false,
        shape = "roundedRect",
        width = 300,
        height = 50,
        cornerRadius = 10,
        fillColor = { default = { 0.6, 0.6, 0.6  }, over = { 0.6, 0.6, 0.6  } },
    }
    startButton.x = display.contentCenterX
    startButton.y = display.contentCenterY 
    sceneGroup:insert(startButton)

    local infoText = display.newText(sceneGroup, "Roll any quantity of dice with any amount of sides!", display.contentCenterX, 10, native.systemFont, 14)
    infoText:setFillColor(1, 1, 1)  -- Set text color to white
end

-- add event listeners
scene:addEventListener("create", scene)

return scene