util.AddNetworkString( "Network" )


hook.Add("PlayerSay","Commands",function( ply, text, team )
	if string.sub( string.lower( text ) , 1 , 5 ) == "!kill" then

		local Str = string.sub( string.lower( text ) , 7, string.len( text ) )
		if Str ~= "" then
			local plyStr = 0 
			for k, v in pairs( player.GetAll() ) do
				if string.lower( v:Nick() ) == Str then
					plyStr = v
					net.Start("Network")
					net.WriteString( ply:Nick() )
					net.WriteString( v:Nick() )
					net.WriteString( " has killed: " )
					net.WriteColor( Color(255, 0, 0) )
					net.Send( player.GetAll() ) 				
					v:Kill()

				else
					
				end
			end
		else
			ply:Kill()
			net.Start("Network")
			net.WriteString( ply:Nick() )
			net.WriteString( " " )
			net.WriteString( " has killed themself" )
			net.WriteColor( Color( 255, 0, 0 ) )
			net.Send( player.GetAll() )
		end
		 
	end

	if string.sub( string.lower( text ) , 1, 5) == "!goto" then
		local Str = string.sub( string.lower( text ), 7, string.len( text ))
		if Str ~= "" then
			local plyStr = 0
			for k, v in pairs( player.GetAll() ) do
				if string.lower( v:Nick() ) == Str then
					plyStr = v
					ply:SetPos(v:GetPos() + Vector(0, 0, 100))
					net.Start("Network")
					net.WriteString( ply:Nick() )
					net.WriteString( v:Nick() )
					net.WriteString( "Has teleported to: " )
					net.WriteColor( Color(255, 0, 0 ) )
					net.Send( player.GetAll() )
				end
			end
		end
	end

	if string.sub( string.lower( text ) , 1, 6 ) == "!bring" then
		local Str = string.sub( string.lower( text ), 8, string.len( text ) )
		if Str ~= "" then
			local plyStr = 0
			for k, v in pairs( player.GetAll() ) do
				if string.lower( v:Nick() ) == Str then
					plyStr = v
					plyStr:SetPos( ply:GetPos() + Vector(0, 0, 100) )
					net.Start("Network")
					net.WriteString( ply:Nick() )
					net.WriteString( v:Nick() )
					net.WriteString( " has brought: " )
					net.WriteColor( Color(255, 0, 0) )
					net.Send( player.GetAll() )
				end
 			end
		end
	end

	if string.sub( string.lower( text ), 1, 10) == "!sethealth" then
		Str = string.sub( string.lower(text), 12, string.len(text) )
		if Str ~= "" then

			if string.tonumber( Str ) > 100 then
				ply:SetMaxHealth( string.tonumber( Str ) )
				ply:SetHealth( string.tonumber( Str ) )
				net.Start("Network")
				net.WriteString( ply:Nick() )
				net.WriteString( Str )
				net.WriteString( " Has set their health to: " )
				net.WriteColor( Color( 255, 0, 0 ) )
				net.Send( player.GetAll() )
			else
				if string.tonumber( Str ) <= 0 then
					net.Start("Network")
					net.WriteString( ply:Nick() )
					net.WriteString( Str )
					net.WriteString( " Has set their health to: " )
					net.WriteColor( Color( 255, 0, 0 ) )
					net.Send( player.GetAll() )					
					ply:Kill()
				else		
					ply:SetMaxHealth( 100 )
					ply:SetHealth( string.tonumber( Str ) )
					net.Start("Network")
					net.WriteString( ply:Nick() )
					net.WriteString( Str )
					net.WriteString( " Has set their health to: " )
					net.WriteColor( Color( 255, 0, 0 ) )
					net.Send( player.GetAll() )
				end
			end
		end
	end
end)