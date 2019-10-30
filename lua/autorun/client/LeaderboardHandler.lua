scoreboard = scoreboard or {}
local Base = nil 

function scoreboard:show()

	local CombinedPing = 0
	local TotalPing = 0

	--<-> Adding the base frame

	Base = vgui.Create( "DFrame" )

	Base:SetSize( ScrW() , ScrH() )
	Base:Center()
	Base:SetDraggable( false )
	Base:ShowCloseButton( false )
	Base:SetTitle( " " )
	gui.EnableScreenClicker( true )

	Base.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color( 56, 56, 56, 50 ))
	end

	local FrontPanel = vgui.Create( "DFrame", Base ) 

	FrontPanel:SetDraggable( false ) 
	FrontPanel:ShowCloseButton( false )
	FrontPanel:SetTitle( " " ) 
	FrontPanel:SetSize( 800, 1000 )
	FrontPanel:Center()

	FrontPanel.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 255) )
	end

	--<-> Making player list 

	for i, ply in pairs( player.GetAll() ) do

		CombinedPing = CombinedPing + ply:Ping()
		
		local String = ply:Nick().."    Kills:    "..tostring(ply:Frags()).."    Deaths:    "..tostring(ply:Deaths()).."    Ping:   "..tostring(ply:Ping())
		local Element = vgui.Create( "DButton", FrontPanel )

		Element:SetText( String ) 
		Element:Dock(TOP)
		Element:SetHeight( 30 )
		Element:SetTextColor( Color( 0, 0, 0, 255) )
		Element:DockMargin(5, 0, 5, 5)

		Element.Paint = function( self, w, h)
			surface.SetDrawColor(self:IsHovered() and Color( 80, 80, 80, 255) or Color( 70, 70, 70, 255 ) )
			surface.DrawRect( 0, 0, w, h )
		end
	end


	TotalPing = CombinedPing/#player.GetAll()
	
	--< - > Creating Bottom of leaderboard serverwide stats 

	local EPanel = vgui.Create( "DFrame", FrontPanel )

	EPanel:Dock(TOP)
	EPanel:SetHeight( 100 )
	EPanel:SetTitle( " " )
	EPanel:SetDraggable( false )
	EPanel:ShowCloseButton( false )
	EPanel:DockMargin(5, 0, 5, 5)

	EPanel.Paint = function( self, w, h)
		surface.SetDrawColor(self:IsHovered() and Color( 80, 80, 80, 255) or Color( 70, 70, 70, 255) )
		surface.DrawRect( 0, 0, w, h)
	end

	local PingL = vgui.Create( "DLabel", EPanel )

	PingL:SetTextColor( Color(0) )
	PingL:SetWidth( 100 )
	PingL:SetHeight( 50 )
	PingL:Dock(TOP)
	PingL:DockMargin(5, 0, 5, 5)
	PingL:SetText( "Average ping: "..tostring(TotalPing) )

end

function scoreboard:hide()		
	Base:Remove()
	gui.EnableScreenClicker( false )
end

hook.Add("ScoreboardShow","HideScoreBoard", function()
	scoreboard:show()
	return false
end)
hook.Add("ScoreboardHide","ShowScoreBoard", function()
	scoreboard:hide() 	
	return false
end)

