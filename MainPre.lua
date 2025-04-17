-- 2025 updated by Bagheri
json = require('rapidjson')
curl = require('cURL')
method = require("methods")
CRCO_ = {}
CRCO_.__index = CRCO_
function CRCO_:NEW(restab)
    local table = restab or {}
    setmetatable(table, self)
    return table
end
function CRCO_:ROS()
    local VAL_ = {}
    setmetatable(VAL_, {__index = self})
    return VAL_
end
function CRCO_:setconfig(cfg)
    self.setting_config = cfg
    self.MainUpdateMeta = ''
    self.MainUpdateRequest = ''
    self.MainUpdate = {}
    self.MainLastUpdate = 0
    self.MainUpdateQueue = {}
    method.setBot(self)
    self.methods = method
end
function CRCO_:Main_URL(method)
    return 'https://api.telegram.org/bot' .. self.setting_config.token .. '/' .. method
end

-- API request
function CRCO_:apiRequest(method, data)
    self.MainUpdateMeta = ''
    self.MainUpdateRequest = json.encode(data)
    curl.easy{
        url = self:Main_URL(method),
        writefunction = function(str) self.MainUpdateMeta = self.MainUpdateMeta .. str end,
        readfunction = function() 
            local chunk = self.MainUpdateRequest
            self.MainUpdateRequest = ''
            return chunk
        end,
        httpheader = {
            'Content-Type: application/json',
            'Content-Length: ' .. string.len(self.MainUpdateRequest),
            'Expect:'
        },
        [curl.OPT_TIMEOUT] = 20
    }:setopt(curl.OPT_POST, 1):perform():close()
end

function CRCO_:getUpdates()
    self:apiRequest('getUpdates', {offset = self.MainLastUpdate, limit = 10})
    self.MainUpdate = json.decode(self.MainUpdateMeta)
    self:handleMainUpdate()
end

function CRCO_:handleMainUpdate()
    if self.MainUpdate.ok then
        for _, msg in ipairs(self.MainUpdate.result) do
            if msg.message then
                if msg.update_id >= self.MainLastUpdate then
                    self.MainLastUpdate = msg.update_id + 1
                end
                table.insert(self.MainUpdateQueue, {CRCO = msg})
            end
        end
    end
end

function CRCO_:PreMessage()
    if #self.MainUpdateQueue ~= 0 then
        return table.remove(self.MainUpdateQueue, 1)
    else
        return nil
    end
end

function CRCO_:processUpdates()
    while true do
        self:getUpdates()
        local update = self:PreMessage()
        if update then
            local co = coroutine.create(function()
                local result = self:getMessage(update.CRCO)
                if result and result.text then
                    self:sendMessage(result.chat_id, result.text, result.msg_id, result.markdown)
                end
            end)
            coroutine.resume(co)
        end
        os.execute("sleep 1")
    end
end

function CRCO_:getMessage(msg)
    return nil
end

function CRCO_:sendMessage(chat_id_, text_, msg_id, markdown)
    local mark = markdown == 'html' and 'HTML' or 'Markdown'
    self:apiRequest('sendMessage', {
        chat_id = chat_id_,
        text = text_,
        reply_to_message_id = msg_id,
        parse_mode = mark
    })
end

function CRCO_:RUNNING()
    self:processUpdates()
end
function CRCO_:createBotInstance(token)
    local bot = self:ROS()
    bot:setconfig{token = token}
    return bot
end

return CRCO_

---mm
