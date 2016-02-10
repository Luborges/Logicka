--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a99fd453820ab2e134ca9d7f2aefe9bf:2de36c7dfb376f9a7aec22d7aaecdcca:1f427874c82e8e154fa34c39593c9521$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- PersonagemF01
            x=4,
            y=372,
            width=42,
            height=60,

            sourceX = 4,
            sourceY = 4,
            sourceWidth = 50,
            sourceHeight = 64
        },
        {
            -- PersonagemF02
            x=4,
            y=632,
            width=32,
            height=60,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 38,
            sourceHeight = 63
        },
        {
            -- PersonagemF03
            x=4,
            y=696,
            width=30,
            height=56,

            sourceX = 6,
            sourceY = 6,
            sourceWidth = 35,
            sourceHeight = 61
        },
        {
            -- PersonagemF04
            x=4,
            y=568,
            width=36,
            height=60,

            sourceX = 4,
            sourceY = 6,
            sourceWidth = 43,
            sourceHeight = 68
        },
        {
            -- PersonagemF05
            x=4,
            y=64,
            width=52,
            height=50,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 59,
            sourceHeight = 57
        },
        {
            -- PersonagemF06
            x=4,
            y=176,
            width=50,
            height=52,

            sourceX = 4,
            sourceY = 8,
            sourceWidth = 53,
            sourceHeight = 59
        },
        {
            -- PersonagemF07
            x=4,
            y=232,
            width=42,
            height=66,

            sourceX = 4,
            sourceY = 4,
            sourceWidth = 46,
            sourceHeight = 71
        },
        {
            -- PersonagemF08
            x=4,
            y=118,
            width=50,
            height=54,

            sourceX = 2,
            sourceY = 6,
            sourceWidth = 54,
            sourceHeight = 59
        },
        {
            -- PersonagemF09
            x=4,
            y=4,
            width=52,
            height=56,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 58,
            sourceHeight = 68
        },
        {
            -- PersonagemF10
            x=4,
            y=504,
            width=40,
            height=60,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 47,
            sourceHeight = 64
        },
        {
            -- PersonagemF11
            x=4,
            y=302,
            width=42,
            height=66,

            sourceX = 4,
            sourceY = 2,
            sourceWidth = 48,
            sourceHeight = 68
        },
        {
            -- PersonagemF12
            x=4,
            y=436,
            width=40,
            height=64,

            sourceX = 2,
            sourceY = 8,
            sourceWidth = 49,
            sourceHeight = 72
        },
    },
    
    sheetContentWidth = 60,
    sheetContentHeight = 756
}

SheetInfo.frameIndex =
{

    ["PersonagemF01"] = 1,
    ["PersonagemF02"] = 2,
    ["PersonagemF03"] = 3,
    ["PersonagemF04"] = 4,
    ["PersonagemF05"] = 5,
    ["PersonagemF06"] = 6,
    ["PersonagemF07"] = 7,
    ["PersonagemF08"] = 8,
    ["PersonagemF09"] = 9,
    ["PersonagemF10"] = 10,
    ["PersonagemF11"] = 11,
    ["PersonagemF12"] = 12,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
