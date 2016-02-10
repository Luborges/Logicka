--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:421fcc3748611fa51d9279f5ab18ea89:335561433c886a48e52a0f32f176b3dd:29dd74f336281e7acc82b4d2e1367b6d$
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
            -- PersonagemM01
            x=4,
            y=232,
            width=40,
            height=64,

            sourceX = 0,
            sourceY = 4,
            sourceWidth = 45,
            sourceHeight = 70
        },
        {
            -- PersonagemM02
            x=4,
            y=566,
            width=30,
            height=52,

            sourceX = 0,
            sourceY = 10,
            sourceWidth = 34,
            sourceHeight = 63
        },
        {
            -- PersonagemM03
            x=4,
            y=622,
            width=30,
            height=52,

            sourceX = 4,
            sourceY = 10,
            sourceWidth = 35,
            sourceHeight = 61
        },
        {
            -- PersonagemM04
            x=4,
            y=500,
            width=30,
            height=62,

            sourceX = 4,
            sourceY = 6,
            sourceWidth = 44,
            sourceHeight = 67
        },
        {
            -- PersonagemM05
            x=4,
            y=120,
            width=52,
            height=52,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 60,
            sourceHeight = 55
        },
        {
            -- PersonagemM06
            x=4,
            y=4,
            width=52,
            height=54,

            sourceX = 2,
            sourceY = 6,
            sourceWidth = 53,
            sourceHeight = 63
        },
        {
            -- PersonagemM07
            x=4,
            y=368,
            width=38,
            height=60,

            sourceX = 6,
            sourceY = 4,
            sourceWidth = 45,
            sourceHeight = 64
        },
        {
            -- PersonagemM08
            x=4,
            y=176,
            width=50,
            height=52,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 52,
            sourceHeight = 59
        },
        {
            -- PersonagemM09
            x=4,
            y=62,
            width=52,
            height=54,

            sourceX = 6,
            sourceY = 6,
            sourceWidth = 59,
            sourceHeight = 60
        },
        {
            -- PersonagemM10
            x=4,
            y=300,
            width=40,
            height=64,

            sourceX = 0,
            sourceY = 4,
            sourceWidth = 40,
            sourceHeight = 70
        },
        {
            -- PersonagemM11
            x=4,
            y=432,
            width=32,
            height=64,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 41,
            sourceHeight = 68
        },
        {
            -- PersonagemM12
            x=4,
            y=678,
            width=28,
            height=66,

            sourceX = 8,
            sourceY = 4,
            sourceWidth = 44,
            sourceHeight = 70
        },
    },
    
    sheetContentWidth = 60,
    sheetContentHeight = 748
}

SheetInfo.frameIndex =
{

    ["PersonagemM01"] = 1,
    ["PersonagemM02"] = 2,
    ["PersonagemM03"] = 3,
    ["PersonagemM04"] = 4,
    ["PersonagemM05"] = 5,
    ["PersonagemM06"] = 6,
    ["PersonagemM07"] = 7,
    ["PersonagemM08"] = 8,
    ["PersonagemM09"] = 9,
    ["PersonagemM10"] = 10,
    ["PersonagemM11"] = 11,
    ["PersonagemM12"] = 12,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo