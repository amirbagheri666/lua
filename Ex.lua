
local CRCO  = require("MainPre")   -- MainPre.lua (with getUpdatesLP & methods attached)
local BOT_TOKENS = {
  "7843946839:AAH9T457tMVVkdp_woRPRszs0eMhtneQ_cs",-- crco 2
  "7813708495:AAH9JPH-Kuif511JvCAfCfOBt-g23flkK4Y",}--- crco 1
local function Command(bot, msg)
  if msg.type == "text" then
    local txt = (msg.text or ""):lower()
    if txt == "ping" then
      mainTD.sendMessage(msg.chat_id, "Pong!", msg.msg_id)
    elseif txt == "hello" then
      mainTD.sendMessage(msg.chat_id, "Hey there! 😊", msg.msg_id)
    else
      mainTD.sendMessage(msg.chat_id, "Unknown command: " .. (msg.text or ""), msg.msg_id)
    end

  elseif msg.type == "photo" then
    mainTD.sendMessage(msg.chat_id, "Nice photo! 📸", msg.msg_id)

  elseif msg.type == "document" then
    mainTD.sendMessage(msg.chat_id, "Document received ✅", msg.msg_id)

  end
end

local function runing(token)
  local bot = CRCO:ROS()
  local mainTD = bot.methods
  bot:setconfig{ token = token }
  while true do
    bot:getUpdatesLP(50)
    local upd = bot:PreMessage()
    while upd do
      local raw = upd.CRCO
      local msg = bot.methods.handleMessage(raw)
      Command(bot, msg)
      upd = bot:PreMessage()
    end
  end
end
for _, token in ipairs(BOT_TOKENS) do
  coroutine.wrap(function()
    runing(token)
  end)()
end
while true do
  coroutine.yield()
end
