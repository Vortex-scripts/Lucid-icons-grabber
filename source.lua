local HttpService = game:GetService("HttpService")
local grabber = {}

local LoadedIcons = {}

local FilesLocation = "LucidIcons"

makefolder(FilesLocation)

local files = listfiles(FilesLocation)

for _, v in pairs(files) do
    LoadedIcons[v:gsub(FilesLocation .. "/", "")] = readfile(v)
end



function grabber.GetIcon(name: string): (boolean, string)
    if LoadedIcons[name .. ".png"] then
        return getcustomasset(LoadedIcons[name .. ".png"], false)
    end

    local RawSVG = request({
        Url = "https://raw.githubusercontent.com/lucide-icons/lucide/refs/heads/main/icons/" .. name .. ".svg",
        Method = "GET",
        -- Attempts to bypass some anti-crawler stuff
        Headers = {
            ["Origin"] = "https://github.com",
            ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
        }
    })

    if not (RawSVG.Success) then return false, "Issue with Github" end

    local UploadedSVG = request({
        Url = "https://svgtopng.onrender.com/convert",
        Method = "POST",
        Headers = {
            ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36",
            ["Content-Type"] = "application/x-www-form-urlencoded"
        },
        Body = "svg=" .. HttpService:UrlEncode(RawSVG.Body)
    })

    if not (UploadedSVG.Success) then return false, "Issue with other" end

    writefile(FilesLocation .. "/" .. name .. ".png", UploadedSVG.Body)

    LoadedIcons[name .. ".png"] = UploadedSVG.Body


    return true, getcustomasset(LoadedIcons[name], false)

end

return grabber