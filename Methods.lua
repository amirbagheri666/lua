-- File: Mothods byte
local Methods = {}
function Methods.setBot(bot)
    assert(bot and bot.apiRequest, "Invalid bot instance. Use Methods.setBot(bot) with CRCO instance")
    Methods.bot = bot
end

local function validate_args(args)
    for k, v in pairs(args) do
        assert(v.value, v.error)
    end
end

function Methods.sendMessage(chat_id, text, reply_id, parse_mode)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        text = {value = text, error = "Missing text"},
        reply_id = {value = reply_id, error = "Missing reply_to_message_id"}
    })
    local mode = parse_mode == 'md' and 'Markdown' or 'HTML'
    Methods.bot:apiRequest('sendMessage', {chat_id = chat_id, text = text, reply_to_message_id = reply_id, parse_mode = mode})
end

function Methods.sendPhoto(chat_id, photo, caption, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        photo = {value = photo, error = "Missing photo file_id or URL"},
        reply_id = {value = reply_id, error = "Missing reply_to_message_id"}
    })
    Methods.bot:apiRequest('sendPhoto', {chat_id = chat_id, photo = photo, caption = caption, reply_to_message_id = reply_id})
end

function Methods.sendDocument(chat_id, document, caption, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        document = {value = document, error = "Missing document file_id or URL"},
        reply_id = {value = reply_id, error = "Missing reply_to_message_id"}
    })
    Methods.bot:apiRequest('sendDocument', {chat_id = chat_id, document = document, caption = caption, reply_to_message_id = reply_id})
end
function Methods.sendAudio(chat_id, audio, caption, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        audio = {value = audio, error = "Missing audio file_id or URL"},
        reply_id = {value = reply_id, error = "Missing reply_to_message_id"}
    })
    Methods.bot:apiRequest('sendAudio', {chat_id = chat_id, audio = audio, caption = caption, reply_to_message_id = reply_id})
end

-----send as video
function Methods.sendVideo(chat_id, video, caption, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        video = {value = video, error = "Missing video file_id or URL"},
        reply_id = {value = reply_id, error = "Missing reply_to_message_id"}
    })
    Methods.bot:apiRequest('sendVideo', {chat_id = chat_id, video = video, caption = caption, reply_to_message_id = reply_id})
end

-----send as animation (gif)
function Methods.sendAnimation(chat_id, animation, caption, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        animation = {value = animation, error = "Missing animation file_id or URL"},
        reply_id = {value = reply_id, error = "Missing reply_to_message_id"}
    })
    Methods.bot:apiRequest('sendAnimation', {chat_id = chat_id, animation = animation, caption = caption, reply_to_message_id = reply_id})
end

-----send as voice
function Methods.sendVoice(chat_id, voice, caption, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        voice = {value = voice, error = "Missing voice file_id or URL"},
        reply_id = {value = reply_id, error = "Missing reply_to_message_id"}
    })
    Methods.bot:apiRequest('sendVoice', {chat_id = chat_id, voice = voice, caption = caption, reply_to_message_id = reply_id})
end

-----send as media group
function Methods.sendMediaGroup(chat_id, media)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        media = {value = media, error = "Missing media array"}
    })
    Methods.bot:apiRequest('sendMediaGroup', {chat_id = chat_id, media = media})
end

-----send as location
function Methods.sendLocation(chat_id, latitude, longitude, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        latitude = {value = latitude, error = "Missing latitude"},
        longitude = {value = longitude, error = "Missing longitude"}
    })
    Methods.bot:apiRequest('sendLocation', {chat_id = chat_id, latitude = latitude, longitude = longitude, reply_to_message_id = reply_id})
end

-----send as venue
function Methods.sendVenue(chat_id, latitude, longitude, title, address, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        latitude = {value = latitude, error = "Missing latitude"},
        longitude = {value = longitude, error = "Missing longitude"},
        title = {value = title, error = "Missing title"},
        address = {value = address, error = "Missing address"}
    })
    Methods.bot:apiRequest('sendVenue', {chat_id = chat_id, latitude = latitude, longitude = longitude, title = title, address = address, reply_to_message_id = reply_id})
end

-----send as contact
function Methods.sendContact(chat_id, phone_number, first_name, last_name, reply_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        phone_number = {value = phone_number, error = "Missing phone_number"},
        first_name = {value = first_name, error = "Missing first_name"}
    })
    Methods.bot:apiRequest('sendContact', {chat_id = chat_id, phone_number = phone_number, first_name = first_name, last_name = last_name, reply_to_message_id = reply_id})
end

-- Forward message
function Methods.forwardMessage(chat_id, from_chat_id, message_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        from_chat_id = {value = from_chat_id, error = "Missing from_chat_id"},
        message_id = {value = message_id, error = "Missing message_id"}
    })
    Methods.bot:apiRequest('forwardMessage', {chat_id = chat_id, from_chat_id = from_chat_id, message_id = message_id})
end

-- Copy message
function Methods.copyMessage(chat_id, from_chat_id, message_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        from_chat_id = {value = from_chat_id, error = "Missing from_chat_id"},
        message_id = {value = message_id, error = "Missing message_id"}
    })
    Methods.bot:apiRequest('copyMessage', {chat_id = chat_id, from_chat_id = from_chat_id, message_id = message_id})
end

-- Edit message text
function Methods.editMessageText(chat_id, message_id, text, parse_mode)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        message_id = {value = message_id, error = "Missing message_id"},
        text = {value = text, error = "Missing text"}
    })
    local mode = parse_mode == 'md' and 'Markdown' or 'HTML'
    Methods.bot:apiRequest('editMessageText', {chat_id = chat_id, message_id = message_id, text = text, parse_mode = mode})
end

-- Edit message reply markup
function Methods.editMessageReplyMarkup(chat_id, message_id, reply_markup)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        message_id = {value = message_id, error = "Missing message_id"}
    })
    Methods.bot:apiRequest('editMessageReplyMarkup', {chat_id = chat_id, message_id = message_id, reply_markup = reply_markup})
end

-- Delete message
function Methods.deleteMessage(chat_id, message_id)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        message_id = {value = message_id, error = "Missing message_id"}
    })
    Methods.bot:apiRequest('deleteMessage', {chat_id = chat_id, message_id = message_id})
end

-- Answer callback query
function Methods.answerCallbackQuery(callback_query_id, text, show_alert)
    validate_args({
        callback_query_id = {value = callback_query_id, error = "Missing callback_query_id"}
    })
    Methods.bot:apiRequest('answerCallbackQuery', {callback_query_id = callback_query_id, text = text, show_alert = show_alert})
end

-----send as chat action
function Methods.sendChatAction(chat_id, action)
    validate_args({
        chat_id = {value = chat_id, error = "Missing chat_id"},
        action = {value = action, error = "Missing action"}
    })
    Methods.bot:apiRequest('sendChatAction', {chat_id = chat_id, action = action})
end
-- meff
function Methods.handleMessage(raw)
    local msg = raw.message or raw
    local out = {
        chat_id = msg.chat and msg.chat.id,
        msg_id = msg.message_id,
        from_id = msg.from and msg.from.id,
        text = msg.text,
        photo = msg.photo,
        document = msg.document,
        audio = msg.audio,
        video = msg.video,
        voice = msg.voice,
        animation = msg.animation,
        sticker = msg.sticker,
        location = msg.location,
        venue = msg.venue,
        contact = msg.contact,
        dice = msg.dice,
        poll = msg.poll,
        forward_from = msg.forward_from,
        reply_to_message = msg.reply_to_message,
        chat_type = msg.chat and msg.chat.type,
        type = nil
    }

    -----type of msg
    if out.text then
        out.type = "text"
    elseif out.photo then
        out.type = "photo"
    elseif out.document then
        out.type = "document"
    elseif out.audio then
        out.type = "audio"
    elseif out.video then
        out.type = "video"
    elseif out.animation then
        out.type = "animation"
    elseif out.voice then
        out.type = "voice"
    elseif out.sticker then
        out.type = "sticker"
    elseif out.location then
        out.type = "location"
    elseif out.venue then
        out.type = "venue"
    elseif out.contact then
        out.type = "contact"
    elseif out.dice then
        out.type = "dice"
    elseif out.poll then
        out.type = "poll"
    elseif out.forward_from then
        out.type = "forward"
    elseif out.reply_to_message then
        out.type = "reply"
    else
        out.type = "unknown"
    end

    return out
end

return Methods