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
            x=2,
            y=186,
            width=21,
            height=30,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 25,
            sourceHeight = 32
        },
        {
            -- PersonagemF02
            x=2,
            y=316,
            width=16,
            height=30,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 19,
            sourceHeight = 32
        },
        {
            -- PersonagemF03
            x=2,
            y=348,
            width=15,
            height=28,

            sourceX = 3,
            sourceY = 3,
            sourceWidth = 18,
            sourceHeight = 31
        },
        {
            -- PersonagemF04
            x=2,
            y=284,
            width=18,
            height=30,

            sourceX = 2,
            sourceY = 3,
            sourceWidth = 22,
            sourceHeight = 34
        },
        {
            -- PersonagemF05
            x=2,
            y=32,
            width=26,
            height=25,

            sourceX = 1,
            sourceY = 2,
            sourceWidth = 30,
            sourceHeight = 29
        },
        {
            -- PersonagemF06
            x=2,
            y=88,
            width=25,
            height=26,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 27,
            sourceHeight = 30
        },
        {
            -- PersonagemF07
            x=2,
            y=116,
            width=21,
            height=33,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 23,
            sourceHeight = 36
        },
        {
            -- PersonagemF08
            x=2,
            y=59,
            width=25,
            height=27,

            sourceX = 1,
            sourceY = 3,
            sourceWidth = 27,
            sourceHeight = 30
        },
        {
            -- PersonagemF09
            x=2,
            y=2,
            width=26,
            height=28,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 29,
            sourceHeight = 34
        },
        {
            -- PersonagemF10
            x=2,
            y=252,
            width=20,
            height=30,

            sourceX = 1,
            sourceY = 2,
            sourceWidth = 24,
            sourceHeight = 32
        },
        {
            -- PersonagemF11
            x=2,
            y=151,
            width=21,
            height=33,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 24,
            sourceHeight = 34
        },
        {
            -- PersonagemF12
            x=2,
            y=218,
            width=20,
            height=32,

            sourceX = 1,
            sourceY = 4,
            sourceWidth = 25,
            sourceHeight = 36
        },
    },
    
    sheetContentWidth = 30,
    sheetContentHeight = 378
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
