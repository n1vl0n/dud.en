#!/bin/lua
local http = require("ssl.https")
local json = require("json")
local url = "https://api.dictionaryapi.dev/api/v2/entries/en/"

local one = {
  ["partOfSpeech"] = true,
}
local two = {
  ["example"] = true,
}
local three = {
  ["text"] = true,
}




function help(table)
  for key, val in pairs(table) do
    if data[key] and data[key][1] > 0 then
      data[key][1] = data[key][1] - 1
      if one[key] then
        print('\27[95m\27[1m'..data[key][2]..val..'\27[m')
      elseif two[key] then
        print('\27[94m\27[3m'..data[key][2]..val..'\27[m')
      elseif three[key] then
        print('\27[92m'..data[key][2]..val..'\27[m')
      else
        print(data[key][2]..val)
      end
    end
    if type(val) == "table" then
      help(val)
    end
  end
end

while true do
  local word = io.read()
  local res = json.decode(http.request(url..word))
  data = {
    ["text"] =         {1, "  "},
    ["definition"] =   {5, "    "},
    ["example"] =      {5, "    "},
    ["partOfSpeech"] = {5, "  "},
  }
  help(res)
end
