local R, L, P = unpack(select(2, ...)) --Inport: Engine, Locales, ProfileDB
local CH = R:GetModule("Chat")

function CH:ChatEdit_CustomTabPressed(self)
    if strsub(tostring(self:GetText()), 1, 1) == "/" then return end

    if self:GetAttribute("chatType") == "SAY" then
        if IsPartyLFG() or GetNumBattlefieldScores()>0 then
            self:SetAttribute("chatType", "INSTANCE_CHAT")
            ChatEdit_UpdateHeader(self)
        elseif IsInGroup() then
            self:SetAttribute("chatType", "PARTY")
            ChatEdit_UpdateHeader(self)
        elseif IsInRaid() then
            self:SetAttribute("chatType", "RAID")
            ChatEdit_UpdateHeader(self)
        elseif IsInGuild() then
            self:SetAttribute("chatType", "GUILD")
            ChatEdit_UpdateHeader(self)
        else
            return
        end
    elseif self:GetAttribute("chatType") == "PARTY" then
        if IsPartyLFG() or GetNumBattlefieldScores()>0 then
            self:SetAttribute("chatType", "INSTANCE_CHAT")
            ChatEdit_UpdateHeader(self)
        elseif IsInRaid() then
            self:SetAttribute("chatType", "RAID")
            ChatEdit_UpdateHeader(self)
        elseif IsInGuild() then
            self:SetAttribute("chatType", "GUILD")
            ChatEdit_UpdateHeader(self)
        else
            self:SetAttribute("chatType", "SAY")
            ChatEdit_UpdateHeader(self)
        end         
    elseif self:GetAttribute("chatType") == "RAID" then
        if IsPartyLFG() or GetNumBattlefieldScores()>0 then
            self:SetAttribute("chatType", "INSTANCE_CHAT")
            ChatEdit_UpdateHeader(self)
        elseif IsInGuild() then
            self:SetAttribute("chatType", "GUILD")
            ChatEdit_UpdateHeader(self)
        else
            self:SetAttribute("chatType", "SAY")
            ChatEdit_UpdateHeader(self)
        end
    elseif self:GetAttribute("chatType") == "INSTANCE_CHAT" then
        if IsInGuild() then
            self:SetAttribute("chatType", "GUILD")
            ChatEdit_UpdateHeader(self)
        else
            self:SetAttribute("chatType", "SAY")
            ChatEdit_UpdateHeader(self)
        end
    elseif (self:GetAttribute("chatType") == "GUILD") then
        self:SetAttribute("chatType", "SAY")
        ChatEdit_UpdateHeader(self)
    elseif self:GetAttribute("chatType") ~= "WHISPER" and self:GetAttribute("chatType") ~= "BN_WHISPER" then
        self:SetAttribute("chatType", "SAY")
        ChatEdit_UpdateHeader(self)
    end
end

function CH:EasyChannel()
	self:RawHook("ChatEdit_CustomTabPressed", true)
end
