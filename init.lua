minetest.register_chatcommand("user_info",{
	param = "<user>",
	description = "Get your client's info",  -- Full description
	func = function(name, param)
		if not(param == "") then
			local havepriv, m = minetest.check_player_privs(name, {server=true})
			if not(havepriv) then
				return false, "No privs to do this!"
			end
			name = param
		end
		local info = minetest.get_player_information(name)
		if not info then return false, "player not found!" end
		minetest.chat_send_player(name, "Info of "..name..":")
		minetest.chat_send_player(name, "IP: "..info.address.." (IPv"..tostring(info.ip_version)..")")
		minetest.chat_send_player(name, "Uptime: "..tostring(info.connection_uptime).."sec")
	end,
})
