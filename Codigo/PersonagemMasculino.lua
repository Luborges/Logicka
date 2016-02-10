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
            x=2,
            y=116,
            width=20,
            height=32,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 23,
            sourceHeight = 35
        },
        {
            -- PersonagemM02
            x=2,
            y=283,
            width=15,
            height=26,

            sourceX = 0,
            sourceY = 5,
            sourceWidth = 17,
            sourceHeight = 32
        },
        {
            -- PersonagemM03
            x=2,
            y=311,
            width=15,
            height=26,

            sourceX = 2,
            sourceY = 5,
            sourceWidth = 18,
            sourceHeight = 31
        },
        {
            -- PersonagemM04
            x=2,
            y=250,
            width=15,
            height=31,

            sourceX = 2,
            sourceY = 3,
            sourceWidth = 22,
            sourceHeight = 34
        },
        {
            -- PersonagemM05
            x=2,
            y=60,
            width=26,
            height=26,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 30,
            sourceHeight = 28
        },
        {
            -- PersonagemM06
            x=2,
            y=2,
            width=26,
            height=27,

            sourceX = 1,
            sourceY = 3,
            sourceWidth = 27,
            sourceHeight = 32
        },
        {
            -- PersonagemM07
            x=2,
            y=184,
            width=19,
            height=30,

            sourceX = 3,
            sourceY = 2,
            sourceWidth = 23,
            sourceHeight = 32
        },
        {
            -- PersonagemM08
            x=2,
            y=88,
            width=25,
            height=26,

            sourceX = 0,
            sourceY = 4,
            sourceWidth = 26,
            sourceHeight = 30
        },
        {
            -- PersonagemM09
            x=2,
            y=31,
            width=26,
            height=27,

            sourceX = 3,
            sourceY = 3,
            sourceWidth = 30,
            sourceHeight = 30
        },
        {
            -- PersonagemM10
            x=2,
            y=150,
            width=20,
            height=32,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 20,
            sourceHeight = 35
        },
        {
            -- PersonagemM11
            x=2,
            y=216,
            width=16,
            height=32,

            sourceX = 1,
            sourceY = 2,
            sourceWidth = 21,
            sourceHeight = 34
        },
        {
            -- PersonagemM12
            x=2,
            y=339,
            width=14,
            height=33,

            sourceX = 4,
            sourceY = 2,
            sourceWidth = 22,
            sourceHeight = 35
        },
    },
    
    sheetContentWidth = 30,
    sheetContentHeight = 374
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
