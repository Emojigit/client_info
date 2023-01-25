local S = minetest.get_translator("client_info")

minetest.register_chatcommand("user_info",{
	param = S("[<user>]"),
	description = S("Get the information of youself, or any player if you are admin."),
	func = function(name, param)
		if param and param ~= "" then
			local havepriv, missing_privs = minetest.check_player_privs(name, {server=true})
			if not(havepriv) then
				return false, minetest.translate("__builtin","You don't have permission to run this command "
				.. "(missing privileges: @1).",
				table.concat(missing_privs, ", "))
			end
			name = param
		end
		local info = minetest.get_player_information(name)
		if not info then return false, S("Player does not exist, or is not online.") end
		return true,S("Information of @1",name) .. "\n" ..
					S("IP: @1 (IPv@2)",info.address,info.ip_version) .. "\n" ..
					S("Uptime: @1 seconds",info.connection_uptime) .. "\n" ..
					S("Protocol Version: @1",info.protocol_version) .. "\n" ..
					S("Formspec Version: @1",info.formspec_version) .. "\n" ..
					S("Language: @1",info.lang_code) .. "\n" ..
					S("RTT: @1~@2 (avg. @3)",info.min_rtt,info.max_rtt,info.avg_rtt) .. "\n" ..
					S("Package time jitter: @1~@2 (avg. @3)",info.min_jitter,info.max_jitter,info.avg_jitter)
	end,
})
