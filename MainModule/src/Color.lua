--------------------------------------------------------------------------------------------------------------------------------
--[[                                             Copyright (C) Inertia Lighting                                             ]] --
--------------------------------------------------------------------------------------------------------------------------------

local Color = {}

--------------------------------------------------------------------------------------------------------------------------------

--- Converts RGB color values to HSV color values
--- @param red number (0-255)
--- @param green number (0-255)
--- @param blue number (0-255)
--- @returns hue number (0-360), saturation number (0-1), value number (0-1)
function Color.rgbToHsv(red, green, blue)
    red, green, blue = red / 255, green / 255, blue / 255
    local maxVal = math.max(red, green, blue)
    local minVal = math.min(red, green, blue)
    local hue, saturation, value

    if maxVal == minVal then
        hue = 0
    elseif maxVal == red then
        hue = (60 * ((green - blue) / (maxVal - minVal))) % 360
    elseif maxVal == green then
        hue = (60 * ((blue - red) / (maxVal - minVal)) + 120) % 360
    elseif maxVal == blue then
        hue = (60 * ((red - green) / (maxVal - minVal)) + 240) % 360
    end

    if maxVal == 0 then
        saturation = 0
    else
        saturation = 1 - (minVal / maxVal)
    end

    value = maxVal

    return hue, saturation, value
end

--- Converts RGB color values to HTML color code
--- @param red number (0-255)
--- @param green number (0-255)
--- @param blue number (0-255)
--- @returns htmlColorCode string
function Color.rgbToHtml(red, green, blue)
    red = string.format("%02X", red)
    green = string.format("%02X", green)
    blue = string.format("%02X", blue)

    return "#" .. red .. green .. blue
end

--- Converts HSV color values to RGB color values
--- @param hue number (0-360)
--- @param saturation number (0-1)
--- @param value number (0-1)
--- @returns red number (0-255), green number (0-255), blue number (0-255)
function Color.hsvToRgb(hue, saturation, value)
    local chroma = value * saturation
    local huePrime = hue / 60
    local x = chroma * (1 - math.abs((huePrime % 2) - 1))
    local red, green, blue

    if huePrime >= 0 and huePrime < 1 then
        red, green, blue = chroma, x, 0
    elseif huePrime >= 1 and huePrime < 2 then
        red, green, blue = x, chroma, 0
    elseif huePrime >= 2 and huePrime < 3 then
        red, green, blue = 0, chroma, x
    elseif huePrime >= 3 and huePrime < 4 then
        red, green, blue = 0, x, chroma
    elseif huePrime >= 4 and huePrime < 5 then
        red, green, blue = x, 0, chroma
    elseif huePrime >= 5 and huePrime < 6 then
        red, green, blue = chroma, 0, x
    else
        red, green, blue = 0, 0, 0
    end

    local m = value - chroma

    red = (red + m) * 255
    green = (green + m) * 255
    blue = (blue + m) * 255

    return math.floor(red + 0.5), math.floor(green + 0.5), math.floor(blue + 0.5)
end

--- Converts HSV color values to HTML color code
--- @param hue number (0-360)
--- @param saturation number (0-1)
--- @param value number (0-1)
--- @returns htmlColorCode string
function Color.hsvToHtml(hue, saturation, value)
    local red, green, blue = Color.hsvToRgb(hue, saturation, value)
    return Color.rgbToHtml(red, green, blue)
end

--- Converts HTML color code to RGB color values
--- @param htmlColorCode string
--- @returns red number (0-255), green number (0-255), blue number (0-255)
function Color.htmlToRgb(htmlColorCode)
    local redHex = htmlColorCode:sub(2, 3)
    local greenHex = htmlColorCode:sub(4, 5)
    local blueHex = htmlColorCode:sub(6, 7)

    local red = tonumber(redHex, 16)
    local green = tonumber(greenHex, 16)
    local blue = tonumber(blueHex, 16)

    return red, green, blue
end

--- Converts HTML color code to HSV color values
--- @param htmlColorCode string
--- @returns hue number (0-360), saturation number (0-1), value number (0-1)
function Color.htmlToHsv(htmlColorCode)
    local red, green, blue = Color.htmlToRgb(htmlColorCode)
    return Color.rgbToHsv(red, green, blue)
end

return Color