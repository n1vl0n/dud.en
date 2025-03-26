#!/bin/lua
local http = require("ssl.https")
local json = require("json")
local url = "https://api.dictionaryapi.dev/api/v2/entries/en/"
local data = {
  ["text"] = 1,
  ["definition"] = 3,
  ["partOfSpeech"] = 3,
  ["example"] = 3,
}
local bold = {
  ["partOfSpeech"] = true,
}




function help(table)
  for key, val in pairs(table) do
    if data[key] and data[key][1] > 0 then
      data[key][1] = data[key][1] - 1
      if bold[key] then
        print('\27[1m'..data[key][2]..val..'\27[m')
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
    ["partOfSpeech"] = {5, "  "},
  }
  help(res)
end
