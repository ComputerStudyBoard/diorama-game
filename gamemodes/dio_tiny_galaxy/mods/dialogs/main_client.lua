local Chat = require ("resources/scripts/utils/chat")
local Easing = require ("resources/scripts/utils/easing")
local EmoteDefinitions = require ("gamemodes/default/mods/chat/emote_definitions")

--------------------------------------------------
local instance = nil

--------------------------------------------------
local messages = 
{
    BEGIN_GAME =        "You live on a tiny, tiny world... in a tiny, tiny galaxy. If only you could collect all the hidden artifacts then maybe the 'collect all the artifacts and be happy for ever' legend could come true. All your tiny, tiny world has is a computer and thrusters. Use your computer and scour the galaxy...! You have but one life <3.",
    WARN_HEAT =         "You are too close to the Tiny Binary Sun World. You can not pass the asteroid belt until you have found a HEAT SHIELD.",
    WARN_COLD =         "You are too close to the Tiny Ice World. You can not get any closer until you have found an ICE SHIELD.",
    SUCCESS =           "You have found all the artifacts. But are you any happier, really? You shouldn't believe in legends at your age. Still, YOU BEAT THE TINY GAME!",
    DIED =              "You died. And you were warned this game only gives you one life per attempt. Don't like it? Add the code yourself.",

    smallAxe =          "You have found an AXE. You can chop thin tree trunks with the left mouse button!",
    smallJumpBoots =    "You have found JUMP BOOTS. You can now jump two blocks high!",
    iceShield =         "You have found an ICE SHIELD. You can get close to ice worlds!",
    belt =              "You have found a BELT OF STRENGTH. You can now crush broken rocks with the left mouse button!",
    fireShield =        "You have found a HEAT SHIELD. You can get closer to the sun and pass the asteroid belt!",
    teleporter =        "You have found a TELEPORTER. Look at a red target and the left mouse button to teleport!",
    largeJumpBoots =    "You have found SUPER JUMP BOOTS. You can now jump three blocks high!",
    bean =              "You have found SOME MAGIC BEANS. Plant on BEAN squares with the left mouse button to grow a jump pad plant!",
    bigAxe =            "You have found the BIG AXE. Chop down bigger tree trunks! You have all the items. Now collect all the artifacts!",

    ARTIFACT_1 =        "You have found artifact 1 of 6! Remember - collect them all and be happy for! YMMV.",
    ARTIFACT_2 =        "You have found artifact 2 of 6! Remember - collect them all and be happy for! YMMV.",
    ARTIFACT_3 =        "You have found artifact 3 of 6! Remember - collect them all and be happy for! YMMV.",
    ARTIFACT_4 =        "You have found artifact 4 of 6! Remember - collect them all and be happy for! YMMV.",
    ARTIFACT_5 =        "You have found artifact 5 of 6! Remember - collect them all and be happy for! YMMV.",
    ARTIFACT_6 =        "You have found artifact 6 of 6! Get to the Tiny Artifact Howmeworld to win!",

    SPECIAL =           "You have found a SPECIAL ITEM but it does nothing for now. Tough."
}

--------------------------------------------------
local clickToRestart =
{
    SUCCESS = true,
    DIED = true,
}

--------------------------------------------------
local function renderBg (self)
    dio.drawing.font.drawBox (0, 0, self.size.w, self.size.h, 0x000000C0);
end

--------------------------------------------------
local function onEarlyRender (self)
    
    if instance.isDirty then

        local width = 100

        local lines = Chat.linesFromSentence (messages [instance.eventId], instance.size.w, EmoteDefinitions)

        dio.drawing.setRenderToTexture (self.renderToTexture)
        renderBg (self)

        local lineHeight = 14
        local y = ((instance.size.h + lineHeight) * 0.5) + (#lines * lineHeight * 0.5);

        for _, line in ipairs (lines) do
            y = y - lineHeight
            Chat.renderLine ((instance.size.w - line.width) * 0.5, y, line, EmoteDefinitions, instance.emoteTexture)
        end

        if instance.mode == "STATIC" then
            local text = clickToRestart [instance.eventId] and "CLICK TO RESTART" or "CLICK TO CONTINUE"
            local width = dio.drawing.font.measureString (text)
            dio.drawing.font.drawString ((instance.size.w - width) * 0.5, 0, text, 0xff000ff)
        end

        dio.drawing.setRenderToTexture (nil)

        instance.isDirty = false

    end
end

--------------------------------------------------
local function onLateRender (self)
    if instance.isVisible then

        local windowW, windowH = dio.drawing.getWindowSize ()
        local x = windowW * 0.5
        local y = windowH * 0.5

        dio.drawing.drawTexture3 (
                self.renderToTexture, 
                0.5, 0.5,
                x, y, 
                self.texture.w * self.scale, self.texture.h * self.scale, 
                instance.rotation,
                0xffffffff)
    end
end

--------------------------------------------------
local function onServerEventReceived (event)

    if event.id == "tinyGalaxy.DIALOGS" then

        instance.eventId = event.payload
        instance.isVisible = true
        instance.isDirty = true
        instance.mode = "ON"
        instance.modeTime = 0
        instance.scale = 0
        instance.rotation = 0

        dio.inputs.setArePlayingControlsEnabled (false)
        event.cancel = true

    end
end

--------------------------------------------------
local function onPlayerControlChanged (event)
    if event.isEnabled then
        if instance.isVisible and instance.mode ~= "OFF" then
            dio.inputs.setArePlayingControlsEnabled (false)
        end
    end
end

--------------------------------------------------
local function onUpdated (event)

    if instance.isVisible then

        if instance.mode == "ON" then

            instance.modeTime = instance.modeTime + event.timeDelta

            local coeff1 = Easing.backOut (instance.modeTime / instance.appearDuration)
            instance.scale = Easing.tween (coeff1, 0, instance.maxScale)

            if instance.modeTime >= instance.appearDuration then
                instance.mode = "STATIC"
                instance.modeTime = 0
                instance.scale = instance.maxScale
                instance.rotation = 0
                instance.isDirty = true

            end
        
        elseif instance.mode == "STATIC" then

            local mouse = dio.inputs.getMouse ()

            if mouse.leftClicked then
                instance.mode = "OFF"
                instance.modeTime = 0
                instance.isDirty = true
                instance.scale = instance.maxScale
                instance.rotation = 0
                
                dio.inputs.setArePlayingControlsEnabled (true)
            end
        
        elseif instance.mode == "OFF" then

            instance.modeTime = instance.modeTime + event.timeDelta

            local coeff1 = Easing.easeInCubic (instance.modeTime / instance.offDuration)
            instance.scale = Easing.tween (coeff1, instance.maxScale, 0)

            local coeff2 = Easing.easeInCubic (instance.modeTime / instance.offDuration)
            instance.rotation = Easing.tween (coeff2, -math.pi * 2, 0)

            if instance.modeTime >= instance.offDuration then
                instance.mode = nil
                instance.modeTime = 0
                instance.isVisible = false
                dio.clientChat.send ("DIALOG_CLOSED")
            end
        end
    end
end


--------------------------------------------------
local function onLoad ()

    instance =
    {
        size = {w = 256, h = 128},
        texture = {w = 256, h = 128},
        border = 4,
        isVisible = false,
        isDirty = false,
        eventId = "TEST",
        emoteTexture = dio.resources.loadTexture ("DIALOG_EMOTES", "textures/emotes_00.png"),

        appearDuration = 0.4,
        offDuration = 0.4,
        maxScale = 3,

        bgFadeDuration = 0.2,
        bgFadeAmount = 0,
    }

    instance.renderToTexture = dio.drawing.createRenderToTexture (instance.texture.w, instance.texture.h)

    dio.drawing.addRenderPassBefore (1.0, function () onEarlyRender (instance) end)
    dio.drawing.addRenderPassAfter (1.0, function () onLateRender (instance) end)

    local types = dio.types.clientEvents
    dio.events.addListener (types.SERVER_EVENT_RECEIVED, onServerEventReceived)
    dio.events.addListener (types.PLAYER_CONTROL_CHANGED, onPlayerControlChanged)
    dio.events.addListener (types.UPDATED, onUpdated)
end

--------------------------------------------------
local function onUnload ()
    dio.resources.destroyTexture ("DIALOG_EMOTES")
end

--------------------------------------------------
local modSettings =
{
    name = "Tiny Galaxy Dialogs",

    description = "",

    permissionsRequired =
    {
        clientChat = true,
        drawing = true,
        inputs = true,
        resources = true,
    },

    callbacks = 
    {
        onLoad = onLoad,
        onUnload = onUnload,
    },    
}

--------------------------------------------------
return modSettings
