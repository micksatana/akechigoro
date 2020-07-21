-- This information tells other players more about the mod
name = "Akechi Goro"
description = "A high school detective nicknamed \"The Second Coming of the Detective Prince\""
author = "Satana Charuwichitratana"
version = "1.0.0" -- This is the version of the template. Change it to your own number.

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- Character mods are required by all clients
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
"character",
}

configuration_options =
{
    {
        name = "reloadkey",
        label = "Reload Key",
        hover = "Reload the SIG-Sauer P230",
        options =
        {
            {description="C", data = 99},
            {description="R", data = 114},
            {description="X", data = 120},
            {description="Z", data = 122},
        },
        default = 114,
    },
}
