local definitions = require ("resources/gamemodes/tiny_galaxy/mods/blocks/block_definitions")

--------------------------------------------------
local function onLoad ()

    for _, model in ipairs (definitions.models) do
        dio.resources.loadMediumModel (model.id, model.filename, model.options)
    end

    for _, definition in ipairs (definitions.blocks) do
        local definitionId = dio.blocks.createNewDefinitionId ()
        definition.definitionId = definitionId
        dio.blocks.setDefinition (definition)
    end
end

--------------------------------------------------
local function onUnload ()

    for _, model in ipairs (definitions.models) do
        dio.resources.destroyMediumModel (model.id)
    end

end

--------------------------------------------------
local modSettings =
{
    name = "Blocks",

    description = "Adds the default Tiny Galaxy blocks",

    permissionsRequired =
    {
        blocks = true,
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