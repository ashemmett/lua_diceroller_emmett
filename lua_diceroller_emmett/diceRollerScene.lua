-----------------------------------------------------------------------------------------
--
-- diceRollerScene.lua | Ashton EMMETT | 10564416 | Programming Languages and Paradigms 
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local resultText
local diceQuantity 
local diceSides 

-- roll dice function
local function rollDice()
    local totalResult = 0
    local rollResults = {} -- table to store roll results
    for i = 1, diceQuantity do
        -- generate a random roll between 1 and the number of sides
        local result = math.random(1, diceSides)
        totalResult = totalResult + result
        table.insert(rollResults, result) -- store roll result
    end
    -- calculate average roll
    local averageRoll = totalResult / diceQuantity
    -- update the result text 
    local resultString = "Total: " .. totalResult .. "\nAverage: " .. averageRoll .. "\nRolls: "
    for i, roll in ipairs(rollResults) do
        resultString = resultString .. roll
        if i < #rollResults then
            resultString = resultString .. ", "
        end
    end
    resultText.text = resultString
end

-- side amount input function
local function inputAmountSide(event)
    if event.phase == "submitted" or event.phase == "ended" then
        diceSides = tonumber(event.target.text)
    end
end

-- dice amount input function
local function inputAmountDice(event)
    if event.phase == "submitted" or event.phase == "ended" then
        diceQuantity = tonumber(event.target.text)
    end
end

-- back button function
local function goToStartScene(event)
    if event.phase == "ended" then
        composer.gotoScene("startScene", { effect = "slideRight", time = 500 })
    end
end

----------------------------------------------------------------------------------------
-- Scene event functions
----------------------------------------------------------------------------------------
function scene:create(event)
    local sceneGroup = self.view

    -- Create title text
    local titleText = display.newText(sceneGroup, "Dice Roller Menu", display.contentCenterX, -30, native.systemFontBold, 24)
    titleText:setFillColor(1, 1, 1)  -- Set text color to white

    -- Create result text object
    resultText = display.newText({
        text = "Statistics! ",
        x = display.contentCenterX,
        y = display.contentCenterY,
        font = native.systemFontBold,
        fontSize = 16
    })
    resultText:setFillColor(1, 1, 1) -- Set text color to white
    sceneGroup:insert(resultText)

    -- dice sides input
    local sideInput = native.newTextField(display.contentCenterX - 50, display.contentCenterY - 200, 200, 30)
    sideInput.placeholder = "Enter amount of dice sides: "
    sideInput:addEventListener("userInput", inputAmountSide)
    sceneGroup:insert(sideInput)

    -- dice quantity input
    local diceInput = native.newTextField(display.contentCenterX - 50, display.contentCenterY - 150, 200, 30)
    diceInput.placeholder = "Enter quantity of dice: "
    diceInput:addEventListener("userInput", inputAmountDice)
    sceneGroup:insert(diceInput)

    -- roll button
    local rollButton = widget.newButton({
        label = "Roll!",
        x = display.contentCenterX,
        y = display.contentCenterY + 100,
        shape = "roundedRect",
        width = 300,
        height = 50,
        cornerRadius = 10,
        fillColor = { default={0, 0, 0.7}, over={0, 0, 0.2} }, -- Blue
        labelColor = { default={1, 1, 1} }, -- White Text
        font = native.systemFontBold,
        fontSize = 20,
        onPress = rollDice,
    })
    sceneGroup:insert(rollButton)

    -- back button
    local backButton = widget.newButton {
        label = "Back",
        labelColor = { default = { 1, 1, 1 }, over = { 0, 1, 0 } },
        onEvent = goToStartScene,
        emboss = false,
        shape = "roundedRect",
        width = 300,
        height = 50,
        cornerRadius = 10,
        fillColor = { default = { 1, 0, 0 }, over = { 1, 0, 0 } },
    }
    backButton.x = display.contentCenterX
    backButton.y = display.contentHeight - 50
    sceneGroup:insert(backButton)
end

----------------------------------------------------------------------------------------
-- scene event function listeners
----------------------------------------------------------------------------------------
scene:addEventListener("create", scene)

return scene