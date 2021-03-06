-- repeatedly generated file. not safe to hand edit
local roomSettings =
{
	generators = 
	{
		{
            weightPass =
            {
                {
                    type = "gradient",
                    mode = "replace",

                    --axis = "y",
                    baseVoxel = -16,
                    heightInVoxels = 16,
                },
                {
                    type = "perlinNoise",
                    mode = "lessThan",

                    scale = 64,
                    octaves = 4,
                    perOctaveAmplitude = 0.5,
                    perOctaveFrequency = 2.0,
                },
            },

            voxelPass =
            {
                {
                    type = "addGrass",
                    mudHeight = 4,
                },
            },
		},
	},
	randomSeedAsString = "wobble",
	terrainId = "paramaterized",
}

return roomSettings
