# Lucid Icons Grabber

I've seen many people use the same script for grabbing Lucid Icons, but I wanted to make my own in a different way.
This is mainly to combat the issues of having a massive script to load only some icons. This, however, only gets the icons that the script calls.
To use, simply do:
```lua
local icon = grabber.GetIcon("IconName")
```
And that's it. It will automatically return a custom asset.

Since this uses the `getcustomasset` function, some executors may not be able to support this script. In that case, use [this](https://github.com/deividcomsono/lucide-roblox-direct/blob/main/source.lua) method.