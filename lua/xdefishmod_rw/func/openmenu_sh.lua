local Zom = Material( "vgui/zoom" )
function xdefm_OpenMenu( ply, typ, tab )
    if !isnumber( typ ) and ( tab != nil and !istable( tab ) ) then return end
    if SERVER and IsValid( ply ) and ply:IsPlayer() and !ply:IsBot() then
        net.Start( "NET_xdefm_Menu" )
        net.WriteString( tonumber( typ ) )
        net.WriteString( util.TableToJSON( tab ) )
        net.Send( ply )
        return
    end
    if CLIENT then
        ply = LocalPlayer()
        typ = math.Round( typ )
        local yes = istable( tab )
        if !yes then return end
        xdefm.bck_col = Color( GetConVar( "xdefmod_bgr" ):GetInt(), GetConVar( "xdefmod_bgg" ):GetInt(), GetConVar( "xdefmod_bgb" ):GetInt(), GetConVar( "xdefmod_bga" ):GetInt() )
        xdefm.ext_col = Color( GetConVar( "xdefmod_brr" ):GetInt(), GetConVar( "xdefmod_brg" ):GetInt(), GetConVar( "xdefmod_brb" ):GetInt(), GetConVar( "xdefmod_bra" ):GetInt() )
        if typ == 0 then -- 背包
            if IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then return end
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Inventory = pan  pan.T_Data = tab  pan.T_Slots = {}
            pan:SetPos( ScrW()/2 -500, ScrH()/2 -500/2 ) pan:SetSize( 450, 550 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:ParentToHUD() pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -500, ScrH()/2 -550/2, 0.2 ) ply.xdefm_Profile = tab  function pan:OnRemove()
                if ispanel( xdefm.miscs.Menus.Double ) then xdefm.miscs.Menus.Double:Remove() end
                if ispanel( xdefm.miscs.Menus.Bank ) then xdefm.miscs.Menus.Bank:Remove() end
                if ispanel( xdefm.miscs.Menus.Trade ) then xdefm.miscs.Menus.Trade:Remove() end
                if ispanel( xdefm.miscs.Menus.Craft ) then xdefm.miscs.Menus.Craft:Remove() end
                if ispanel( xdefm.miscs.Menus.Struct ) then xdefm.miscs.Menus.Struct:Remove() end
            end function pan:Paint( w, h ) local tab = pan.T_Data
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.TextShadow( { text = ply:Nick(), pos = { 80, 24 }, font = "xdefm_Font5",
                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                draw.TextShadow( { text = language.GetPhrase( "#xdefm.Money" )..": "..tab.Money, pos = { 80, 54 }, font = "xdefm_Font1",
                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 ) end
            if true then -- 头像
                pan.P_AIcon = pan:Add( "AvatarImage" )  local pax = pan.P_AIcon
                pax:SetPos( 8, 8 ) pax:SetSize( 64, 64 ) pax:SetPlayer( ply, 128 ) pax:SetMouseInputEnabled( false )
                pan.P_AFrame = pan:Add( "DPanel" )  pax = pan.P_AFrame
                pax:SetText( "" ) pax:SetPos( 8, 8 ) pax:SetSize( 64, 64 ) pax:SetMouseInputEnabled( false )
                function pax:Paint( w, h ) surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h ) end end
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 410, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end
            if true then -- 等级框架
                pan.P_Level = pan:Add( "DPanel" )  local pax = pan.P_Level
                pax:SetPos( 8, 80 ) pax:SetSize( 434, 75 )
                function pax:Paint( w, h )  local tab = pan.T_Data
                    local pp = xdefm_LevelExp( tab.Level )  local ee = math.Round( math.min( pp, math.Round( tab.Exp ) ) )
                    surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h )
                    draw.TextShadow( { text = language.GetPhrase( "#xdefm.Level" )..": "..tab.Level, pos = { 12, 18 }, font = "xdefm_Font1",
                    xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                    local xx, yy = pax:GetPos()  local x2, y2 = pan:GetPos()  xx = xx + x2  yy = yy + y2  local per = math.Clamp(ee/pp,0,1)
                    surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 8, 32, 416, 30 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 8, 32, 416, 30, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 8, 32, 416, 30 )
                    render.SetScissorRect( xx +8, yy +32, xx +8 +416*per, yy +58, true )
                    draw.RoundedBox( 4, 4 +8, 4 +32, 416 -8, 30 -8, Color( 0, 155, 200 ) )
                    render.SetScissorRect( 0, 0, 0, 0, false )
                    local txt = ""  if self.B_Hover then txt = ee.." / "..pp else txt = tostring(math.floor(per*100)).." %" end
                    draw.TextShadow( { text = txt, pos = { w/2, 46 }, font = "xdefm_Font2",
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                end
                function pax:OnCursorEntered() self.B_Hover = true end function pax:OnCursorExited() self.B_Hover = false end end
            if true then -- 背包/升级/记录/排行/商店
                pan.P_Invent = vgui.Create( "DPropertySheet", pan )  local pax = pan.P_Invent
                pax:SetPos( 8, 165 ) pax:SetSize( 434, 377 ) function pax:Paint( w, h )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 18, w, h -18, 2 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 18, w, h -18, 1 )
                end pax:SetPadding( 1 )
                local function AddASheetFM( tit, ico, hel ) local pae = vgui.Create( "DPanel" ) function pae:Paint( w, h ) end 
                    local ttt = pax:AddSheet( tit, pae, ico ) if isstring( hel ) then ttt.Tab:SetTooltip( hel ) end function ttt.Tab:Paint( w, h )
                        local alp = ttt.Tab:IsActive() and 1 or 0.5  local rr, gg, bb = xdefm.bck_col.r, xdefm.bck_col.g, xdefm.bck_col.b
                        draw.RoundedBoxEx( 4, 0, 0, w, 20, xdefm.ext_col, true, true, false, false )
                        draw.RoundedBoxEx( 4, 1, 1, w -2, 20, xdefm.lin_col, true, true, false, false )
                        draw.RoundedBoxEx( 4, 3, 3, w -4, 20, Color( rr*alp, gg*alp, bb*alp, 255 ), true, true, false, false )
                    end ttt.Tab.xdefm_DC = ttt.Tab.DoClick
                    function ttt.Tab:DoClick() ttt.Tab:xdefm_DC() end return pae end
                pan.P_Menu1 = AddASheetFM( language.GetPhrase( "xdefm.M1" ), "icon16/basket.png", language.GetPhrase( "xdefm.M11" ) )
                pan.P_Menu5 = AddASheetFM( language.GetPhrase( "xdefm.M5" ), "icon16/cart.png", language.GetPhrase( "xdefm.M55" ) )
                pan.P_Menu2 = AddASheetFM( language.GetPhrase( "xdefm.M2" ), "icon16/lightning.png", language.GetPhrase( "xdefm.M22" ) )
                pan.P_Menu3 = AddASheetFM( language.GetPhrase( "xdefm.M3" ), "icon16/star.png", language.GetPhrase( "xdefm.M33" ) )
                if GetConVar( "xdefmod_lbdelay" ):GetInt() > 0 and !game.SinglePlayer() then
                    pan.P_Menu4 = AddASheetFM( language.GetPhrase( "xdefm.M4" ), "icon16/chart_bar.png", language.GetPhrase( "xdefm.M44" ) )
                end for k, v in pairs( { pan.P_Menu2, pan.P_Menu3, pan.P_Menu4, pan.P_Menu5 } ) do if !IsValid( v ) then continue end
                    function v:Paint( w, h ) surface.SetDrawColor( Color( xdefm.bck_col.r*0.5, xdefm.bck_col.g*0.5, xdefm.bck_col.b*0.5, xdefm.bck_col.a*0.5 ) )
                    surface.DrawRect( 0, 0, w, h ) end end
                for k, v in pairs( { pan.P_Menu1, pan.P_Menu2, pan.P_Menu3, pan.P_Menu5 } ) do if !IsValid( v ) then continue end
                    v.P_Scroll = v:Add( "DScrollPanel" )  v.P_Scroll:Dock( FILL )  local vba = v.P_Scroll:GetVBar()
                    vba:SetHideButtons( true )  vba:SetSize( 0, 0 )
                    function vba.btnGrip:Paint( w, h )
                        surface.SetDrawColor( 125, 125, 125, 255 ) surface.DrawRect( 0, 0, w, h )
                        surface.SetDrawColor( 0, 0, 0, 255 ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    end function vba:Paint( w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color( 45, 45, 45, 255 ) ) end end
                if true then local pax = pan.P_Menu1 --背包栏目
                    pax.P_Hold = pax.P_Scroll:Add( "DIconLayout" )  local pa2 = pax.P_Hold  pa2:Dock( FILL )
                    pa2:SetSpaceX( 1.75 ) pa2:SetSpaceY( 2 ) function pa2:Paint( w, h ) end local inv = pan.T_Data.Items
                    for i=1, 21 do local siz = ( i == 21 and 64 or 85 )
                    local slo = xdefm_SlotBox( 0, 0, siz, siz, i, i==21 and language.GetPhrase( "xdefm.Bait" ) or tostring( i ) )
                    if i == 21 then pan:Add( slo ) slo:SetPos( 336, 10 ) else pax.P_Hold:Add( slo ) end 
                    slo.S_Type = "Inventory"  slo:F_SetupItem( inv[i] ) pan.T_Slots[ i ] = slo
                        function slo:DoRightClick( Pnl ) if slo.T_Item == nil or slo:IsDragging() then return end
                            if IsValid( pan.P_DMenu ) then pan.P_DMenu:Remove() end pan.P_DMenu = DermaMenu( false, nil )  local dnm = pan.P_DMenu
                            local prc = xdefm_GetPrice( slo.S_Item )  local des = ( prc > 0 and "#xdefm.Sell" or "#xdefm.Destroy" )
                            local ico = ( prc > 0 and "icon16/coins.png" or "icon16/bin_closed.png" )
                            local O_Drop = dnm:AddOption( "#xdefm.Drop", function() if !slo.B_OnMove then xdefm_Command( LocalPlayer(), "DropInv", slo.S_Place ) end end )
                            local O_Destroy = dnm:AddOption( des, function() if !slo.B_OnMove then xdefm_Command( LocalPlayer(), "DestroyInv", slo.S_Place ) end end )
                            O_Drop:SetIcon( "icon16/basket_remove.png" ) O_Destroy:SetIcon( ico )
                            if IsValid( xdefm.miscs.Menus[ "Bank" ] ) then
                                local O_Store = dnm:AddOption( "#xdefm.Store", function()
                                if !slo.B_OnMove and IsValid( xdefm.miscs.Menus[ "Bank" ] ) then local num = 0
                                for k, v in pairs( LocalPlayer().xdefm_Profile.Bnk ) do if k > ply.xdefm_Profile.UpdF then break end
                                if isstring( v ) and v == "_" then num = k break end end if num > 0 then
                                xdefm_Command( LocalPlayer(), "MoveBank", slo.S_Place.."|"..num )
                                else xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) end end end )
                                O_Store:SetIcon( "icon16/basket_go.png" )
                            elseif IsValid( xdefm.miscs.Menus[ "Structure" ] ) and xdefm.miscs.Menus[ "Structure" ].N_SType == 1 then
                                local O_Store = dnm:AddOption( "#xdefm.Store", function()
                                if !slo.B_OnMove and IsValid( xdefm.miscs.Menus[ "Structure" ] ) and xdefm.miscs.Menus[ "Structure" ].N_SType == 1 then local num = 0
                                for k, v in pairs( xdefm.miscs.Menus[ "Structure" ].T_Items ) do
                                if isstring( v ) and v == "_" then num = k break end end if num > 0 then
                                xdefm_Command( LocalPlayer(), "Structure", slo.S_Place.."|"..num )
                                else xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) end end end )
                                O_Store:SetIcon( "icon16/basket_go.png" )
                            end
                            if slo.T_Item.Type == "Bait" then
                                if slo.S_Place != "21" then
                                    local O_Equip = dnm:AddOption( "#xdefm.Equip", function()
                                    if !slo.B_OnMove then xdefm_Command( LocalPlayer(), "MoveInv", slo.S_Place.."|21" ) end end )
                                    O_Equip:SetIcon( "icon16/bug_go.png" ) else
                                    local O_Dequip = dnm:AddOption( "#xdefm.Dequip", function() if slo.B_OnMove then return end
                                    local num = 0  for k, v in pairs( LocalPlayer().xdefm_Profile.Items ) do if k != 21 and v == "_" then num = k break end end
                                    if num > 0 then xdefm_Command( LocalPlayer(), "MoveInv", "21|"..num ) end end ) O_Dequip:SetIcon( "icon16/bug_go.png" )
                                end
                            end
                            if slo.T_Item.Type == "Recipe" and IsValid( xdefm.miscs.Menus[ "Craft" ] ) then
                                local O_Store = dnm:AddOption( "#xdefm.Store", function()
                                if !slo.B_OnMove and IsValid( xdefm.miscs.Menus[ "Craft" ] ) then
                                    xdefm_Command( LocalPlayer(), "MoveCraft", slo.S_Place )
                                else xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) end end )
                                O_Store:SetIcon( "icon16/script_go.png" )
                            end
                            if IsValid( xdefm.miscs.Menus[ "Trade" ] ) then
                                local O_Store = dnm:AddOption( "#xdefm.Weapon_Trade", function()
                                if !slo.B_OnMove and IsValid( xdefm.miscs.Menus[ "Trade" ] ) and istable( xdefm.miscs.Menus[ "Trade" ].T_Slo1 ) then
                                local num = 0  for k, v in pairs( xdefm.miscs.Menus[ "Trade" ].T_Slo1 ) do
                                if isstring( v.S_Item ) and v.S_Item == "_" then num = k break end end if num > 0 then
                                xdefm_Command( LocalPlayer(), "MoveTrade", slo.S_Place.."|"..num )
                                else xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) end end end )
                                O_Store:SetIcon( "icon16/basket_go.png" )
                            end
                            dnm:Open()
                        end
                    end end
                if true then local pax = pan.P_Menu2 --升级栏目
                    local skp = pax.P_Scroll:Add( "DPanel" ) skp:SetSize( 0, 30 ) skp:Dock( TOP )
                    function skp:Paint( w, h ) local tab = xdefm.miscs.Menus.Inventory.T_Data
                        draw.TextShadow( { text = language.GetPhrase( "xdefm.Skp" )..": "..tab.Skp, pos = { 8, h/2 }, font = "xdefm_Font7",
                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                    end local MatA = Material( "gui/gradient_up" )
                    local function AddASkillTab( ski ) local num = xdefm.miscs.Costs[ ski ]  if !isnumber( num ) or !tab[ "Upd"..ski ] then return end
                        local pan = pax.P_Scroll:Add( "DPanel" ) pan:SetSize( 0, 38 ) pan:Dock( TOP ) pan.N_Goto = math.Clamp( tab[ "Upd"..ski ]/100, 0, 1 )
                        function pan:Paint( w, h ) local tab = xdefm.miscs.Menus.Inventory.T_Data
                            pan.N_Goto = Lerp( 0.1, pan.N_Goto, math.Clamp( tab[ "Upd"..ski ]/( ski == "G" and 5 or 100 ), 0, 1 ) )
                            surface.SetDrawColor( Color( 0, 155, 155, 55 ) ) surface.DrawRect( 8, 4, w -16, h -8 )
                            local col = xdefm.ext_col  if ski == "G" and GetConVar( "xdefmod_nomorehook" ):GetInt() >= 1 then col = Color( 255-col.r, 255-col.g, 255-col.b ) end
                            draw.RoundedBox( 0, 8, 2, 415*pan.N_Goto, h -4, col )
                            surface.SetMaterial( MatA ) surface.SetDrawColor( xdefm.bck_col ) surface.DrawTexturedRect( 8, 2, w -16, h -4 )
                            surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 8, 2, w -16, h -4, 2 )
                            surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 8, 2, w -16, h -4, 1 )
                            draw.TextShadow( { text = language.GetPhrase( "xdefm.Upd"..ski )..( ski == "G" and GetConVar( "xdefmod_nomorehook" ):GetInt() >= 1 and " ※" or "" ),
                            pos = { 16, h/2 }, font = "xdefm_Font5", xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                            draw.TextShadow( { text = "Lv."..( ( ski == "G" and tab[ "Upd"..ski ] >= 5 or tab[ "Upd"..ski ] >= 100 ) and "Max" or tab[ "Upd"..ski ] ),
                            pos = { w -160, h/2 }, font = "xdefm_Font5", xalign = TEXT_ALIGN_RIGHT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                            draw.TextShadow( { text = "±"..tostring( num ), pos = { w -72, h/2 }, font = "xdefm_Font1",
                            xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                        end for i=1, 2 do
                            local but = pan:Add( "DButton" ) but:SetSize( 30, 20 ) but:SetPos( 305 +(i-1)*80, 10 ) but:SetText( "" )
                                but.B_Hover = false  but.N_Lerp = 0  function but:Paint( w, h ) but.N_Lerp = Lerp( 0.2, but.N_Lerp, but.B_Hover and 1 or 0 )
                                col = Color( 100 +55*but.N_Lerp, 100 +100*but.N_Lerp, 100 +100*but.N_Lerp ) local skl = xdefm.miscs.Menus.Inventory.T_Data[ "Upd"..ski ]
                                local mmm = ( ski == "G" and skl >= 5 or skl >= 100 )
                                if ( i == 2 and mmm ) or ( i == 1 and skl <= 0 ) or ( i == 2 and xdefm.miscs.Menus.Inventory.T_Data[ "Skp" ] < num ) then return end
                                draw.RoundedBox( 0, 1, 1, w -2, h -2, col ) draw.TextShadow( { text = ( i == 2 and "+" or "-" ), pos = { w/2, h/2 }, font = "xdefm_Font4",
                                xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                                surface.SetDrawColor( 0, 0, 0, 255 ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                                surface.SetDrawColor( 255, 255, 255, 255 ) surface.DrawOutlinedRect( 0, 0, w, h, 1 ) end
                            function but:OnCursorEntered() self.B_Hover = true end function but:OnCursorExited() self.B_Hover = false end
                            function but:DoClick() local skl = xdefm.miscs.Menus.Inventory.T_Data[ "Upd"..ski ]
                                local skl = xdefm.miscs.Menus.Inventory.T_Data[ "Upd"..ski ]  local mmm = ( ski == "G" and skl >= 5 or skl >= 100 )
                                if ( i == 2 and mmm ) or ( i == 1 and skl <= 0 ) or ( i == 2 and xdefm.miscs.Menus.Inventory.T_Data[ "Skp" ] < num ) then return end
                                xdefm_Command( LocalPlayer(), i == 1 and "Downgrade" or "Upgrade", ski.."|"..1 ) end
                            function but:DoRightClick() if IsValid( pan.P_DMenu ) then pan.P_DMenu:Remove() end
                                local skl = xdefm.miscs.Menus.Inventory.T_Data[ "Upd"..ski ]  local mmm = ( ski == "G" and skl >= 5 or skl >= 100 )
                                if ( i == 2 and mmm ) or ( i == 1 and skl <= 0 ) or ( i == 2 and xdefm.miscs.Menus.Inventory.T_Data[ "Skp" ] < num ) then return end
                                pan.P_DMenu = DermaMenu( false, nil )  local dnm = pan.P_DMenu  local wt = ( i == 2 and "+" or "-" )
                                local O_X1 = dnm:AddOption( wt.."1", function() if !IsValid( xdefm.miscs.Menus.Inventory ) then return end
                                    xdefm_Command( LocalPlayer(), i == 1 and "Downgrade" or "Upgrade", ski.."|"..1 ) end )
                                local O_X5 = dnm:AddOption( wt.."5", function() if !IsValid( xdefm.miscs.Menus.Inventory ) then return end
                                    xdefm_Command( LocalPlayer(), i == 1 and "Downgrade" or "Upgrade", ski.."|"..5 ) end )
                                if ski != "G" then local O_X10 = dnm:AddOption( wt.."10", function() if !IsValid( xdefm.miscs.Menus.Inventory ) then return end
                                    xdefm_Command( LocalPlayer(), i == 1 and "Downgrade" or "Upgrade", ski.."|"..10 ) end )
                                local O_X50 = dnm:AddOption( wt.."50", function() if !IsValid( xdefm.miscs.Menus.Inventory ) then return end
                                    xdefm_Command( LocalPlayer(), i == 1 and "Downgrade" or "Upgrade", ski.."|"..50 ) end )
                                local O_X100 = dnm:AddOption( wt.."100", function() if !IsValid( xdefm.miscs.Menus.Inventory ) then return end
                                    xdefm_Command( LocalPlayer(), i == 1 and "Downgrade" or "Upgrade", ski.."|"..100 ) end ) end
                                dnm:Open() end
                        end
                    end local MaX = Material( "gui/center_gradient" )
                    AddASkillTab( "A" ) AddASkillTab( "B" ) AddASkillTab( "C" ) AddASkillTab( "D" ) AddASkillTab( "E" ) AddASkillTab( "F" ) AddASkillTab( "G" )
                    if true then --清点按钮
                        local ppp = pax.P_Scroll:Add( "DPanel" ) ppp:SetSize( 0, 75 ) ppp:Dock( TOP ) function ppp:Paint( w, h ) end ppp.N_Lerp = 0
                        local but = ppp:Add( "DButton" ) but:SetSize( 150, 28 ) but:SetPos( 274, 8 ) but:SetText( "" ) but.B_Hover = false function but:Paint( w, h )
                            ppp.N_Lerp = Lerp( 0.2, ppp.N_Lerp, but.B_Hover and 1 or 0 )
                            col = Color( 100 +55*ppp.N_Lerp, 100 +100*ppp.N_Lerp, 100 +100*ppp.N_Lerp )
                            if xdefm.miscs.SkpCool > CurTime() then col = Color( 55, 55, 55 ) end
                            surface.SetDrawColor( col ) surface.DrawRect( 0, 0, w, h ) local txt = language.GetPhrase( "xdefm.ResetSkp" )
                            if xdefm.miscs.SkpCool > CurTime() then txt = math.Round( xdefm.miscs.SkpCool-CurTime() ).."s"
                                local per = math.Clamp( (xdefm.miscs.SkpCool-CurTime())/GetConVar( "xdefmod_skpcool" ):GetInt(), 0, 1 )
                                surface.SetDrawColor( 255, 55, 55 ) surface.DrawRect( 0, 0, w*per, h )
                            end surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                            surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 ) draw.TextShadow( { text = txt,
                            pos = { w/2, h/2 -1 }, font = "xdefm_Font2", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                        end function but:OnCursorEntered() self.B_Hover = true end function but:OnCursorExited() self.B_Hover = false end
                        function but:DoClick() if xdefm.miscs.SkpCool > CurTime() then return end
                            if IsValid( pan.P_DMenu ) then pan.P_DMenu:Remove() end pan.P_DMenu = DermaMenu( false, nil )  local dnm = pan.P_DMenu
                            local O_Yes = dnm:AddOption( "#xdefm.Confirm", function() if xdefm.miscs.SkpCool <= CurTime() and IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then
                                xdefm.miscs.SkpCool = CurTime()+GetConVar( "xdefmod_skpcool" ):GetInt() xdefm_Command( LocalPlayer(), "ResetSkp", "_" )
                            end end ) O_Yes:SetIcon( "icon16/tick.png" ) dnm:Open()
                        end
                    end end
                if true then local pax = pan.P_Menu3 --状态栏目
                    local function AddAStatTab( stt, aba )
                        local pan = pax.P_Scroll:Add( "DPanel" ) pan:SetSize( 0, stt == "!V" and 9 or 30 ) pan:Dock( TOP )
                        function pan:Paint( w, h ) if stt == "!V" then return end local tab = xdefm.miscs.Menus.Inventory.T_Data
                            local dat, num = stt, 0  if isnumber( xdefm.miscs.Costs[ stt ] )
                            then dat = "Upd"..stt  num = xdefm_GetUpValue( tab[ dat ], stt ) else num = tab[ stt ] or 0 end
                            draw.TextShadow( { text = language.GetPhrase( "xdefm."..dat )..": "..num,
                            pos = { 16, h/2 }, font = "xdefm_Font1", xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                        end
                    end
                    AddAStatTab( "!V" ) AddAStatTab( "TCatch" ) AddAStatTab( "TEarn" ) AddAStatTab( "TExp" )
                    AddAStatTab( "TBuy" ) AddAStatTab( "TCraft" ) AddAStatTab( "TQuest" ) end end
                if true then local pax = pan.P_Menu5 --商店栏目
                    pax.P_Scroll:Dock( NODOCK ) pax.P_Scroll:SetPos( 2, 2 ) pax.P_Scroll:SetSize( 434, 347 )
                    pax.P_Hold = pax.P_Scroll:Add( "DIconLayout" )  local pa2 = pax.P_Hold  pa2:SetSize( 434, 347 )
                    pa2:SetSpaceX( 3 ) pa2:SetSpaceY( 3 ) pa2:SetPos( 3, 2 ) local MaX = Material( "gui/center_gradient" )
                    for k, v in SortedPairsByMemberValue( xdefm.shop, 2 ) do
                        local Item = pax.P_Hold:Add( "DButton" ) Item:SetSize( 210, 75 ) Item.N_Clicked = 0  Item:SetCursor( "blank" )
                        local aa, bb = xdefm_ItemGet( k ) if !istable( bb ) or bb.Type != "Bait" then Item:Remove() return end  Item.N_Lerp = 0.3
                        Item.S_Name = bb.Name  Item.N_Rarity = bb.Rarity  Item.S_Item = k  Item.N_Level = v[ 2 ]  Item.N_Cost = math.ceil( v[ 1 ] * v[ 3 ] )
                        function Item:OnCursorEntered() xdefm.miscs.AimPan = Item  xdefm.miscs.Marker = Item.S_Item  Item.B_OnMove = true  xdefm.miscs.LC = false end
                        function Item:OnCursorExited() if xdefm.miscs.AimPan == Item then xdefm.miscs.AimPan = nil  xdefm.miscs.Marker = nil end Item.B_OnMove = false end
                        function Item:DoClick() Item.N_Clicked = CurTime() +0.2  local yes, pro = true, LocalPlayer().xdefm_Profile
                            if pro.Money < Item.N_Cost then xdefm_AddNote( ply, "xdefm.NoMoney", "resource/warning.wav", "cross", 5 ) yes = false end
                            if yes and pro.Level < Item.N_Level then xdefm_AddNote( ply, "xdefm.NoLevel", "resource/warning.wav", "cross", 5 ) yes = false end
                            if yes then xdefm_Command( LocalPlayer(), "BuyBait", Item.S_Item ) end end
                        function Item:OnRemove() Item:OnCursorExited() end
                        function Item:Paint( w, h ) local col = xdefm.miscs.Rarity[ Item.N_Rarity+1 ]
                            local tab = xdefm.shop[ k ]  Item.N_Cost = math.ceil( tab[ 1 ] * tab[ 3 ] )
                            draw.RoundedBox( 0, 0, 0, w, h, col )  local pro = LocalPlayer().xdefm_Profile  if !istable( pro ) then return end
                            Item.N_Lerp = Lerp( 0.2, Item.N_Lerp, Item.N_Clicked > CurTime() and 0.1 or ( xdefm.miscs.AimPan == Item and 0.5 or 0.3 ) )
                            local ccc = Item.N_Lerp  draw.RoundedBox( 0, 1, 1, w -2, h -2, Color( col.r*ccc, col.g*ccc, col.b*ccc ) )
                            surface.SetMaterial( MaX ) surface.SetDrawColor( col.r*ccc*1.5, col.g*ccc*1.5, col.b*ccc*1.5 ) surface.DrawTexturedRect( 1, 1, w -2, h -2 )
                            local co1, co2 = Color( 255, 0, 0 ), Color( 0, 255, 0 )
                            draw.TextShadow( {
                                text = language.GetPhrase( Item.S_Name ), pos = { 75, 15 }, font = "xdefm_Font2",
                                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = col
                            }, 1, 255 )
                            draw.TextShadow( {
                                text = language.GetPhrase( "xdefm.Price" )..": "..Item.N_Cost, pos = { 75, 35 }, font = "xdefm_Font2",
                                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = pro.Money >= Item.N_Cost and co2 or co1
                            }, 1, 255 )
                            draw.TextShadow( {
                                text = language.GetPhrase( "xdefm.Level" )..": "..Item.N_Level, pos = { 75, 55 }, font = "xdefm_Font2",
                                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = pro.Level >= Item.N_Level and co2 or co1
                            }, 1, 255 ) end
                        Item.P_Frame = Item:Add( "DPanel" )  Item:SetText( "" )
                        Item.P_Frame:SetSize( 64, 64 ) Item.P_Frame:SetPos( 6, 6 )
                        Item.P_Frame:SetMouseInputEnabled( false )  function Item.P_Frame:Paint( w, h ) local col = xdefm.miscs.Rarity[ Item.N_Rarity+1 ]
                            surface.SetDrawColor( Color( col.r*0.2, col.g*0.2, col.b*0.2 ) )  surface.DrawRect( 0, 0, w, h )
                            surface.SetDrawColor( col )  surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                            surface.SetDrawColor( xdefm.lin_col )  surface.DrawOutlinedRect( 0, 0, w, h, 1 ) end
                        Item.P_Icon = Item.P_Frame:Add( "ModelImage" ) Item.P_Icon:DockMargin( 5, 5, 5, 5 )
                        Item.P_Icon:Dock( FILL ) Item.P_Icon:SetModel( bb.Model[ 1 ] ) Item.P_Icon:SetMouseInputEnabled( false )
                    end end
                if GetConVar( "xdefmod_lbdelay" ):GetInt() > 0 and !game.SinglePlayer() then local pax = pan.P_Menu4 --排行栏目
                    local ldb = pax:Add( "DPanel" ) ldb:SetSize( 0, 355 ) ldb:Dock( TOP ) pax.T_Leader = xdefm.Leader
                    function ldb:Paint( w, h ) local tab = xdefm.miscs.Menus.Inventory.T_Data
                        if !istable( pax.T_Leader ) or #pax.T_Leader <= 0 then
                            draw.TextShadow( { text = language.GetPhrase( "xdefm.NoInfo" ), pos = { w/2, h/2 }, font = "xdefm_Font5",
                            xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 ) return end
                        draw.TextShadow( { text = language.GetPhrase( "xdefm.Level" ), pos = { 245, 24 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                        draw.TextShadow( { text = language.GetPhrase( "xdefm.Money" ), pos = { 345, 24 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                        draw.TextShadow( { text = language.GetPhrase( "xdefm.Player" ), pos = { 65, 24 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                    end local Mat, Ma2 = Material( "gui/noicon.png" ), Material( "gui/center_gradient" )
                    pax.P_Scroll = ldb:Add( "DScrollPanel" ) pax.P_Scroll:SetSize( 420, 310 ) local scr = pax.P_Scroll
                    local vba = pax.P_Scroll:GetVBar() pax.P_Scroll:SetPos( 6, 40 ) vba:SetHideButtons( true ) vba:SetSize( 0, 0 )
                    function vba.btnGrip:Paint( w, h ) end function vba:Paint( w, h ) end function pax.P_Scroll:Paint( w, h ) end
                    function pax:UpdateLbd( tab ) pax.T_Leader = tab  scr:Clear() if !istable( tab ) then return end
                        for k, v in pairs( tab ) do
                            local plc = scr:Add( "DPanel" ) plc:Dock( TOP ) plc:SetSize( 0, 40 ) plc:DockMargin( 0, 4, 0, 0 )
                            plc.N_Place = k  plc.T_Data = v  plc.S_Sid = v[ 2 ]
                            local avt = plc:Add( "AvatarImage" ) avt:SetPos( 33, 4 ) avt:SetSize( 32, 32 ) avt:SetSteamID( plc.S_Sid, 64 )
                            plc:SetToolTip( plc.S_Sid ) function plc:Paint( w, h ) local col = xdefm.ext_col
                                local npl = plc.N_Place  if npl == 1 then col = Color( 255, 255, 55 ) elseif npl == 2 then col = Color( 255, 255, 255 )
                                elseif npl == 3 then col = Color( 255, 155, 55 ) end local co2 = Color( col.r*0.3, col.g*0.3, col.b*0.3 )  local co3 = Color( col.r*0.6, col.g*0.6, col.b*0.6 )
                                surface.SetDrawColor( co2 ) surface.DrawRect( 0, 0, w, h )
                                surface.SetDrawColor( co3 ) surface.SetMaterial( Ma2 ) surface.DrawTexturedRect( 0, 0, w, h )
                                local bb, si = ( LocalPlayer():SteamID64() == plc.S_Sid ), ( 0.5 +0.5*math.abs( math.sin( CurTime()*4 ) ) )
                                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, bb and 3 or 2 )
                                surface.SetDrawColor( bb and Color( col.r*si, col.g*si, col.b*si ) or col ) surface.DrawOutlinedRect( 0, 0, w, h, bb and 2 or 1 )
                                draw.TextShadow( { text = k..".", pos = { 16, h/2 }, font = "xdefm_Font7",
                                xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = col }, 1, 255 )
                                surface.SetMaterial( Mat ) surface.SetDrawColor( 255, 255, 255 ) surface.DrawTexturedRect( 32, 3, 33, 33 )
                                surface.SetDrawColor( col ) surface.DrawOutlinedRect( 32, 3, 34, 34, 2 )
                                draw.TextShadow( { text = plc.T_Data[ 3 ], pos = { 72, h/2 }, font = "xdefm_Font2",
                                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = col }, 1, 255 )
                                draw.TextShadow( { text = plc.T_Data[ 4 ], pos = { 240, h/2 }, font = "xdefm_Font2",
                                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = col }, 1, 255 )
                                draw.TextShadow( { text = plc.T_Data[ 5 ], pos = { 340, h/2 }, font = "xdefm_Font2",
                                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = col }, 1, 255 )
                            end
                        end
                    end pax:UpdateLbd( xdefm.leader ) end
            if true then -- 鱼饵框架
                pan.P_AFrame = pan:Add( "DPanel" )  pax = pan.P_AFrame
                pax:SetText( "" ) pax:SetPos( 336 -4, 9 -3 ) pax:SetSize( 64 +8, 64 +8 ) pax:SetMouseInputEnabled( false )
                function pax:Paint( w, h ) surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 ) end end
            function pan:XDEFM_Update( id, dt ) if id == 7 and IsValid( pan.P_Menu4 ) then pan.P_Menu4:UpdateLbd( dt ) end
                if id == 0 then pan.T_Data = dt  for k, v in pairs( pan.T_Slots ) do v:F_SetupItem( dt.Items[ k ] ) end end
            end
        elseif typ == 1 then --任务
            if IsValid( xdefm.miscs.Menus[ "Quest" ] ) then return end local Aro = Material( "gui/arrow" )
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Quest = pan
            pan:SetPos( ScrW()/2 -300, ScrH()/2 -300 ) pan:SetSize( 600, 400 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:ParentToHUD() pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -300, ScrH()/2 -300, 0.2 ) pan.T_Require = {} pan.T_Reward = {}
            pan.B_1 = false  pan.B_2 = false  pan.B_3 = false  pan.N_Total = 0
            function pan:Paint( w, h ) local tab = pan.T_Data
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.Quest" ) .. " #"..pan.N_Total, font = "xdefm_Font6", pos = { w/2, 24 },
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                }, 1, 255 )
                draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.Require" ), font = "xdefm_Font5", pos = { w/2 -160, 50 },
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                }, 1, 255 )
                draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.Reward" ), font = "xdefm_Font5", pos = { w/2 +160, 50 },
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                }, 1, 255 ) surface.SetMaterial( Aro )
                surface.SetDrawColor( pan.B_2 and Color( 0, 255, 0 ) or Color( 255, 0, 0 ) ) surface.DrawTexturedRectRotated( w/2, h/2 -15, 60, 60, 90 )
                surface.SetDrawColor( pan.B_1 and Color( 0, 255, 0 ) or Color( 255, 0, 0 ) ) surface.DrawTexturedRectRotated( w/2, h/2 +15, 60, 60, 270 ) end
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 560, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end --
            for i=1, 2 do -- 需求奖励
                local pax = pan:Add( "DPanel" ) pax:SetPos( 300 -110 -175 +320*( i-1 ), 75 ) pax:SetSize( 250, 250 )
                function pax:Paint( w, h )
                    surface.SetDrawColor( Color( xdefm.bck_col.r*0.5, xdefm.bck_col.g*0.5, xdefm.bck_col.b*0.5 ) ) surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h )
                end
                pax.P_Scroll = pax:Add( "DScrollPanel" ) pax.P_Scroll:SetSize( 246, 246 ) pax.P_Scroll:SetPos( 1, 2 )
                local vba = pax.P_Scroll:GetVBar()  vba:SetHideButtons( true )  vba:SetSize( 0, 0 )
                function vba.btnGrip:Paint( w, h ) end function vba:Paint( w, h ) end function pax.P_Scroll:Paint( w, h ) end
                pax.P_Hold = pax.P_Scroll:Add( "DIconLayout" )  local pa2 = pax.P_Hold  pa2:SetSize( 246, 0 )
                pa2:DockMargin( 4, 4, 4, 4 ) pa2:SetSpaceX( 3 ) pa2:SetSpaceY( 3 ) pa2:SetPos( 4, 2 ) function pa2:Paint( w, h ) end
                if i == 1 then pan.P_1 = pax.P_Hold else pan.P_2 = pax.P_Hold end
            end
            for i=1, 2 do -- 跳过结算
                local but = pan:Add( "DButton" ) but:SetPos( 300 -75 -( i == 1 and -100 or 100 ), 340 ) but:SetSize( 150, 45 )
                but:SetText( "" )  but.B_Hover = false  but.N_Lerp = 0  but.N_Clicked = 0
                function but:Paint( w, h ) local col = Color( 0, 155, 0 )
                    but.N_Lerp = Lerp( 0.2, but.N_Lerp, but.N_Clicked > CurTime() and -1 or ( but.B_Hover and 1 or 0 ) )
                    if ( i == 1 and ( !pan.B_1 or !pan.B_2 ) ) or ( i == 2 and !pan.B_3 ) then col = Color( 155, 0, 0 ) end
                    col = Color( col.r +col.r*0.5*but.N_Lerp, col.g +col.g*0.5*but.N_Lerp, col.b +col.b*0.5*but.N_Lerp )
                    surface.SetDrawColor( col ) surface.DrawRect( 0, 0, w, h )
                    draw.TextShadow( { text = i == 1 and "#xdefm.Finish" or "#xdefm.Skip", pos = { w/2, h/2 }, font = "xdefm_Font4",
                    color = Color( 255, 255, 255 ), xalign = TEXT_ALIGN_CENTER, yalign =  TEXT_ALIGN_CENTER }, 1, 200 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                end
                function but:OnCursorEntered() but.B_Hover = true end
                function but:OnCursorExited() but.B_Hover = false end
                function but:DoClick() if but.N_Clicked > CurTime() then return end
                    but.N_Clicked = CurTime() +0.25
                    if i == 1 then
                        if !pan.B_1 then
                            xdefm_AddNote( ply, "xdefm.Deny1", "resource/warning.wav", "cross", 5 )
                        elseif !pan.B_2 then
                            xdefm_AddNote( ply, "xdefm.Deny2", "resource/warning.wav", "cross", 5 )
                        else
                            pan.P_Close:DoClick()
                            xdefm_Command( LocalPlayer(), "Quest", "_" )
                        end
                    elseif !pan.B_3 then
                        xdefm_AddNote( ply, "xdefm.Deny3", "resource/warning.wav", "cross", 5 )
                    else
                        pan.P_Close:DoClick()
                        xdefm_Command( LocalPlayer(), "Skip", "_" )
                    end
                end
                if i == 1 then pan.P_3 = but else pan.P_4 = but end
            end
            function pan:XDEFM_Update( id, dt )
                pan.B_1 = true
                pan.B_2 = false
                pan.B_3 = ( LocalPlayer():GetNWFloat( "XDEFM_QC" ) <= CurTime() )
                if id == 0 then
                    pan.N_Total = ( dt.TQuest or 0 ) +1
                    local tem = {}
                    for k, v in pairs( pan.T_Require ) do
                        local yes = false
                        for m, n in pairs( dt.Items ) do
                            if m != 21 and !tem[ m ] and xdefm_GetClass( n ) == v then
                                tem[ m ] = 0
                                yes = true
                                break
                            end
                        end
                        if !yes then pan.B_1 = false break end
                    end
                    local emp = 0
                    for k, v in pairs( dt.Items ) do
                        if k != 21 and ( v == "_" or tem[ k ] ) then emp = emp +1 end
                    end
                    pan.B_2 = ( emp >= #pan.T_Reward )
                elseif id == 10 then
                    pan.P_1:Clear() pan.P_2:Clear() pan.T_Require = {} pan.T_Reward = {}
                    for i=1, 2 do
                        local tab = dt[ i+1 ]  if !isstring( tab ) then break end
                        tab = string.Explode( "&", tab ) or { tab }
                        for k, v in pairs( tab ) do
                            local aa, bb = xdefm_ItemGet( v )
                            if istable( bb ) then
                                local slo = xdefm_SlotBox( 0, 0, 58, 58, i, nil, nil, true ) slo:F_SetupItem( v )
                                if i == 1 then pan.P_1:Add( slo ) table.insert( pan.T_Require, v )
                                else pan.P_2:Add( slo ) table.insert( pan.T_Reward, v ) end
                            end
                        end
                    end
                end
            end
            pan:XDEFM_Update( 10, tab )
        elseif typ == 2 then -- 兑换
            if IsValid( xdefm.miscs.Menus[ "Exchange" ] ) then xdefm.miscs.Menus[ "Exchange" ]:Remove() return end
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Exchange = pan  pan.T_Data = tab  pan.N_Enter = 0
            pan:SetPos( ScrW()/2 -300, ScrH()/2 -150 ) pan:SetSize( 600, 275 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:ParentToHUD() pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -300, ScrH()/2 -275/2, 0.2 ) ply.xdefm_Profile = tab  pan.N_Clicked = 0
            function pan:Paint( w, h ) local tab = pan.T_Data
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.TextShadow( { text = ply:Nick(), pos = { 115, 25 }, font = "xdefm_Font4",
                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                draw.TextShadow( { text = language.GetPhrase( "#xdefm.FMoney" )..": "..tab.Money, pos = { 115, 55 }, font = "xdefm_Font1",
                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                draw.TextShadow( { text = language.GetPhrase( "#xdefm.DMoney" )..": "..( ply.getDarkRPVar and ply:getDarkRPVar("money") or "Currency Not Found!" ), pos = { 115, 78 }, font = "xdefm_Font1",
                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                local rat = math.Round( 0.99*GetConVar( "xdefmod_darkrp" ):GetFloat()*100, 2 ).."%"
                draw.TextShadow( { text = language.GetPhrase( "#xdefm.DRate" )..": "..rat, pos = { 115, 101 }, font = "xdefm_Font1",
                xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 8, 115, 582, 150, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 8, 115, 582, 150 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 16, 126, 564, 43 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 16, 126, 564, 43 ) end
            if true then -- 头像
                pan.P_AIcon = pan:Add( "AvatarImage" )  local pax = pan.P_AIcon
                pax:SetPos( 8, 10 ) pax:SetSize( 100, 100 ) pax:SetPlayer( ply, 128 ) pax:SetMouseInputEnabled( false )
                pan.P_AFrame = pan:Add( "DPanel" )  pax = pan.P_AFrame
                pax:SetText( "" ) pax:SetPos( 8, 10 ) pax:SetSize( 100, 100 ) pax:SetMouseInputEnabled( false )
                function pax:Paint( w, h ) surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 3 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 ) end end
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 560, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end
            if true then -- 数值
                pan.P_Entry = vgui.Create( "DTextEntry", pan )
                pan.P_Entry:SetSize( 555, 35 ) pan.P_Entry:SetPos( 20, 130 ) pan.P_Entry:SetFont( "xdefm_Font4" )
                pan.P_Entry:SetUpdateOnType( true ) pan.P_Entry:SetNumeric( true ) pan.P_Entry:SetMultiline( false )
                pan.P_Entry:SetTextColor( Color( 0, 0, 0 ) )
                pan.P_Entry:SetPlaceholderText( "#xdefm.DEnter" )
                function pan.P_Entry:OnValueChange( val )
                    local num = isnumber( tonumber( val ) ) and tonumber( val ) or 0
                    if !isnumber( num ) or num < 0 or num > 2147483647 then
                        num = math.Clamp( !isnumber( num ) and 0 or num, 0, 2147483647 )
                        pan.P_Entry:SetText( num ) surface.PlaySound( "resource/warning.wav" )
                    end
                    pan.N_Enter = num
                end end
            for i=1, 2 do -- 转换按钮
                if !ply.getDarkRPVar then break end
                local but = vgui.Create( "DButton", pan )  but:SetText( "" )  but.B_Hover = false  but.N_Lerp = 0
                but:SetSize( 200, 60 ) but:SetPos( -180 +i*250, 190 ) but.N_Num = 0
                function but:Paint( w, h )
                    local rat = GetConVar( "xdefmod_darkrp" ):GetFloat()
                    local num = math.max( i == 1 and math.floor( pan.N_Enter*rat*0.99 ) or math.floor( pan.N_Enter/rat*0.99 ), 0 )
                    local col = Color( 155, 0, 0 )
                    if num > 0 then
                        if ( i == 1 and pan.T_Data.Money >= pan.N_Enter ) or ( i == 2 and LocalPlayer():canAfford( pan.N_Enter ) ) then
                            col = Color( 0, 155, 0 )
                        end
                    end
                    but.N_Num = Lerp( 0.2, but.N_Num, num )
                    but.N_Lerp = Lerp( 0.2, but.N_Lerp, pan.N_Clicked > CurTime() and -1 or ( but.B_Hover and 1 or 0 ) )
                    col = Color( col.r +col.r*0.5*but.N_Lerp, col.g +col.g*0.5*but.N_Lerp, col.b +col.b*0.5*but.N_Lerp )
                    surface.SetDrawColor( col ) surface.DrawRect( 0, 0, w, h )
                    draw.TextShadow( { text = i == 1 and "#xdefm.Conv1" or "#xdefm.Conv2", pos = { w/2, 16 }, font = "xdefm_Font5",
                    color = Color( 255, 255, 255 ), xalign = TEXT_ALIGN_CENTER, yalign =  TEXT_ALIGN_CENTER }, 1, 200 )
                    draw.TextShadow( { text = math.Round( but.N_Num ), pos = { w/2, 45 }, font = "xdefm_Font5",
                    color = Color( 255, 255, 255 ), xalign = TEXT_ALIGN_CENTER, yalign =  TEXT_ALIGN_CENTER }, 1, 200 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                end
                function but:OnCursorEntered() but.B_Hover = true end
                function but:OnCursorExited() but.B_Hover = false end
                function but:DoClick() if pan.N_Clicked > CurTime() then return end
                    local rat = GetConVar( "xdefmod_darkrp" ):GetFloat()
                    local num = math.max( i == 1 and math.floor( pan.N_Enter*rat*0.99 ) or math.floor( pan.N_Enter/rat*0.99 ), 0 )
                    if num > 0 and ( ( i == 1 and pan.T_Data.Money >= pan.N_Enter ) or ( i == 2 and LocalPlayer():canAfford( pan.N_Enter ) ) ) then
                        xdefm_Command( ply, "Convert", pan.N_Enter.."|"..i )
                        pan.N_Clicked = CurTime() +0.5
                    else
                        surface.PlaySound( "resource/warning.wav" )
                        pan.N_Clicked = CurTime() +0.25
                    end
                end end
            function pan:XDEFM_Update( id, dt ) if id == 0 then pan.T_Data = dt end end
        elseif typ == 3 then -- 渔夫
            if IsValid( xdefm.miscs.Menus[ "NPC" ] ) then return end
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.NPC = pan  pan.T_Data = tab  pan.N_Enter = 0
            pan:SetPos( ScrW()/2 -250, ScrH()/2 -150 ) pan:SetSize( 500, 345 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:ParentToHUD() pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -250, ScrH()/2 -275/2, 0.2 ) ply.xdefm_Profile = tab  pan.N_Clicked = 0
            function pan:Paint( w, h ) local tab = pan.T_Data
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.TextShadow( { text = "#xdefm.DarkNPC2", pos = { w/2, 24 }, font = "xdefm_Font4",
                xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                surface.SetDrawColor( Color( xdefm.bck_col.r*0.5, xdefm.bck_col.g*0.5, xdefm.bck_col.b*0.5, xdefm.bck_col.a*0.5 ) ) surface.DrawRect( 8, 45, 484, 290 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 8, 45, 484, 290, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 8, 45, 484, 290 ) end
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 460, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end
            local icos = { "box", "coins", "basket", "wrench", "camera", "script", "arrow_refresh" }
            for i=1, 7 do -- 互动按钮
                local but = vgui.Create( "DButton", pan )  but:SetText( "" )  but.B_Hover = false  but.N_Lerp = 0
                but:SetSize( 472, 36 ) but:SetPos( 14, 12 +40*i ) but:SetIcon( "icon16/"..icos[ i ]..".png" ) but.N_Clicked = 0
                function but:Paint( w, h ) local col = Color( 100, 100, 100 )
                    but.N_Lerp = Lerp( 0.2, but.N_Lerp, but.N_Clicked > CurTime() and -1 or ( but.B_Hover and 1 or 0 ) )
                    col = Color( col.r +col.r*0.5*but.N_Lerp, col.g +col.g*0.5*but.N_Lerp, col.b +col.b*0.5*but.N_Lerp )
                    surface.SetDrawColor( col ) surface.DrawRect( 0, 0, w, h )
                    draw.TextShadow( { text = "#xdefm.NPC"..i, pos = { 36, h/2 }, font = "xdefm_Font5",
                    color = Color( 255, 255, 255 ), xalign = TEXT_ALIGN_LEFT, yalign =  TEXT_ALIGN_CENTER }, 1, 200 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 ) end
                function but:OnCursorEntered() but.B_Hover = true end
                function but:OnCursorExited() but.B_Hover = false end
                function but:DoClick() if but.N_Clicked > CurTime() then return end
                    surface.PlaySound( "buttons/lightswitch2.wav" )  but.N_Clicked = CurTime() +0.3
                    xdefm_Command( LocalPlayer(), "NPC", tostring( i ) )
                end end
            function pan:XDEFM_Update( id, dt ) if id == 0 then pan.T_Data = dt end end
        elseif typ == 4 then -- 建筑
            if IsValid( xdefm.miscs.Menus[ "Structure" ] ) then return end  local MaR = Material( "gui/gradient" )
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Struct = pan  pan.T_Data = ply.xdefm_Profile  pan.S_Recipe = "_"
            pan:SetPos( ScrW()/2 -40, ScrH()/2 -550/2 ) pan:SetSize( 600, 550 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -40, ScrH()/2 -500/2, 0.2 ) pan.S_Struct = "_"  pan.N_Num = -1  pan.N_Max = -1  pan.N_SType = 0
            function pan:Paint( w, h )
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                local rec, col = "xdefm.Struct", Color( 200, 200, 200 )
                if isstring( pan.S_Struct ) and pan.S_Struct != "_" then
                    local aa, bb = xdefm_ItemGet( pan.S_Struct )
                    if istable( aa ) and istable( bb ) then
                        rec = bb.Name  col = xdefm.miscs.Rarity[ bb.Rarity +1 ]
                        local nam = language.GetPhrase( "xdefm.ST"..pan.N_SType )
                        if pan.N_Num != -1 then nam = nam..( pan.N_Max != -1 and " ( "..pan.N_Num.." / "..pan.N_Max.." )" or " ( "..pan.N_Num.." )" ) end
                        draw.TextShadow( { text = nam, pos = { w/2, 52 }, font = "xdefm_Font7",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 128, 128, 128 ) }, 1, 255 )
                    end
                end
                draw.TextShadow( { text = language.GetPhrase( rec ), pos = { w/2, 25 }, font = "xdefm_Font6",
                xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = col }, 1, 255 )
            end
            function pan:OnRemove() xdefm_Command( LocalPlayer(), "StructExit", "_" ) xdefm.miscs.LC = false end
            if true then -- 框架
                pan.P_Base = pan:Add( "DPanel" )  local pax = pan.P_Base  pax.N_Type = 0  pan.T_Slots = {}
                pax:SetPos( 8, 70 ) pax:SetSize( 582, 470 ) function pax:Paint( w, h ) end
                function pax:Paint( w, h )
                    surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h )
                end
                pax.P_Scroll = pax:Add( "DScrollPanel" )  pax.P_Scroll:SetSize( 576, 462 ) pax.P_Scroll:SetPos( 4, 4 )
                local vba = pax.P_Scroll:GetVBar()  vba:SetHideButtons( true )  vba:SetSize( 0, 0 )
                function vba.btnGrip:Paint( w, h ) end function vba:Paint( w, h ) end
                function pax.P_Scroll:Paint( w, h ) end
                pax.P_Hold = pax.P_Scroll:Add( "DIconLayout" )  local pa2 = pax.P_Hold  pa2:Dock( FILL )
                pa2:SetSpaceX( 2 ) pa2:SetSpaceY( 2 ) function pa2:Paint( w, h ) end
                function pax:OnCursorEntered() self.B_Hover = true end function pax:OnCursorExited() self.B_Hover = false end
                pax.P_Hold.N_Num = 0
            end
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 560, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end
                function pax:OnCursorExited() pax.B_Hover = false end
            end --
            function pan:XDEFM_Update( id, dt ) if id == 0 then pan.T_Data = dt end
                if id == 3 then if !istable( dt ) or !istable( pan.T_Items ) or pan.N_SType != 1 then return end
                    for k, v in pairs( dt ) do
                        if !isnumber( k ) or !pan.T_Items[ k ] or !pan.T_Slots[ k ] then continue end
                        if pan.T_Items[ k ] == "_" and v != "_" then pan.N_Num = pan.N_Num +1
                        elseif pan.T_Items[ k ] != "_" and v == "_" then pan.N_Num = pan.N_Num -1 end
                        pan.T_Items[ k ] = v  pan.T_Slots[ k ]:F_SetupItem( v )
                    end
                elseif id == 2 then if !istable( dt ) or #dt < 1 then return end local str = dt[ 1 ]
                    local aa, bb = xdefm_ItemGet( str )
                    if istable( aa ) and istable( bb ) and bb.Type == "Structure" then
                        pan.S_Struct = str  local stp, pax = bb.SType, pan.P_Base  pan.N_SType = stp
                        if stp == 1 then table.remove( dt, 1 )  pan.T_Slots = {}  pan.N_Max = 0  pan.N_Num = 0  pan.T_Items = {}
                            for k, v in pairs( dt ) do
                                local slo = xdefm_SlotBox( 0, 0, 94, 94, k, tostring( k ) )  pax.P_Hold:Add( slo )
                                pan.T_Slots[ k ] = slo  slo.S_Type = "Storage"  slo:F_SetupItem( v )  pan.N_Max = pan.N_Max +1
                                if v != "_" then pan.N_Num = pan.N_Num +1 end  pan.T_Items[ k ] = v
                                function slo:DoRightClick( Pnl ) if slo.T_Item == nil or slo:IsDragging() or !IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then return end
                                    if IsValid( pan.P_DMenu ) then pan.P_DMenu:Remove() end pan.P_DMenu = DermaMenu( false, nil )  local dnm = pan.P_DMenu
                                    local O_Take = dnm:AddOption( "#xdefm.Take", function() if !slo.B_OnMove and IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then
                                    local num = 0  for k, v in pairs( LocalPlayer().xdefm_Profile.Items ) do
                                        if isstring( v ) and v == "_" then num = k break end
                                    end if num > 0 then xdefm_Command( LocalPlayer(), "Structure", num.."|"..k )
                                    else xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 ) end end end )
                                    O_Take:SetIcon( "icon16/basket_put.png" ) dnm:Open()
                                end
                            end
                        elseif stp == 2 then pan.N_Num = 0
                            local function xdefm_AddCraft( tab ) pan.N_Num = pan.N_Num +1
                            local cc = string.Explode( "&", tab ) if !istable( cc ) or #cc < 2 then return end
                            local slo = vgui.Create( "DButton", pax.P_Hold ) slo:SetSize( 50, 80 ) slo:Dock( TOP ) slo:SetText( "" ) slo:SetCursor( "blank" )
                            local aa, bb = xdefm_ItemGet( cc[ #cc ] ) if !istable( aa ) or !istable( bb ) then slo:Remove() return end
                            local col = xdefm.miscs.Rarity[ bb.Rarity +1 ]  local icc = xdefm.miscs.Icons[ bb.Type ]  slo.S_Item = cc[ #cc ]
                            slo.B_Hover = false  slo.N_Num = pan.N_Num  slo.N_Clk = 0  slo.N_Lerp = 0 if icc != nil then
                            pax.P_Sprite = vgui.Create( "DPanel", slo ) local spr = pax.P_Sprite  
                            spr:SetPos( 79, 23 ) spr:SetSize( 16, 16 ) spr:SetMouseInputEnabled( false )
                            function spr:Paint( w, h ) surface.SetMaterial( icc )
                                surface.SetDrawColor( Color( 255, 255, 255, 255 ) ) surface.DrawTexturedRect( 0, 0, w, h )
                            end end slo.T_Craft = cc function slo:Paint( w, h )
                            local coc = ( slo.B_Hover and 0.4 or 0.2 ) local co2 = Color( col.r*coc, col.g*coc, col.b*coc )
                            slo.N_Lerp = Lerp( 0.1, slo.N_Lerp, ( slo.N_Clk <= CurTime() and slo.B_Hover ) and 0 or 1 )
                            local co3 = Color( col.r*coc*2, col.g*coc*2, col.b*coc*2, 55 +slo.N_Lerp*100 ) draw.RoundedBox( 0, 2 +3, 2, w -1 -8, h -2, co2 )
                            surface.SetDrawColor( co3 ) surface.SetMaterial( MaR ) surface.DrawTexturedRect( 2 +5, 2, w -5 -8, h -2 -2 )
                            surface.SetDrawColor( xdefm.ext_col )  surface.DrawOutlinedRect( 2 +3, 2, w -1 -8, h -2, 2 )
                            surface.SetDrawColor( xdefm.lin_col )  surface.DrawOutlinedRect( 2 +3, 2, w -1 -8, h -2 )
                            draw.TextShadow( { text = bb.Name, pos = { 102, 30 }, font = "xdefm_Font5",
                            xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = col }, 1, 255 )
                            draw.TextShadow( { text = language.GetPhrase( "xdefm.Materials" )..": "..tostring( #cc -1 ),
                            pos = { 80, 60 }, font = "xdefm_Font1", xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                            draw.TextShadow( { text = "#"..slo.N_Num,
                            pos = { 540, 40 }, font = "xdefm_Font4", xalign = TEXT_ALIGN_RIGHT, yalign = TEXT_ALIGN_CENTER, color = Color( 200, 200, 200 ) }, 1, 255 ) end
                            function slo:OnCursorEntered() slo.B_Hover = true  xdefm.miscs.Craft = cc  pan.P_Select = slo  xdefm.miscs.AimPan = slo
                            xdefm.miscs.Ings = {}  xdefm.miscs.Ing2 = {}  xdefm.miscs.Marker = slo.S_Item  xdefm.miscs.LC = true end
                            function slo:OnCursorExited() slo.B_Hover = false  if xdefm.miscs.AimPan == slo then xdefm.miscs.AimPan = nil end
                            if pan.P_Select == slo then xdefm.miscs.Marker = nil
                            pan.P_Select = nil  xdefm.miscs.Marker = nil end end
                            function slo:DoClick() if slo.N_Clk > CurTime() then return end slo.N_Clk = CurTime() +0.25
                            xdefm_Command( LocalPlayer(), "Structure", tostring( slo.N_Num ) ) end
                            local ico = xdefm_SlotBox( 13, 11, 60, 60, 1 ) slo:Add( ico ) ico:F_SetupItem( cc[ #cc ] )
                            ico.P_Txt:Remove() ico:SetMouseInputEnabled( false )
                            end for k, v in pairs( bb.Crafts ) do xdefm_AddCraft( v ) end
                        elseif stp == 3 then pan.N_Num = 0  local MaX = Material( "gui/center_gradient" )
                            for k, v in SortedPairsByMemberValue( bb.Shop, 1 ) do
                                local Item = pax.P_Hold:Add( "DButton" ) Item:SetSize( 286, 75 ) Item.N_Clicked = 0  Item:SetCursor( "blank" )
                                local aa, bb = xdefm_ItemGet( k ) if !istable( bb ) then Item:Remove() return end  Item.N_Lerp = 0.3  pan.N_Num = pan.N_Num +1
                                Item.S_Name = bb.Name  Item.N_Rarity = bb.Rarity  Item.N_Cost = v[ 1 ]  Item.N_Level = v[ 2 ]
                                function Item:OnCursorEntered() xdefm.miscs.AimPan = Item  xdefm.miscs.Marker = k  Item.B_OnMove = true  xdefm.miscs.LC = false end
                                function Item:OnCursorExited() if xdefm.miscs.AimPan == Item then xdefm.miscs.AimPan = nil  xdefm.miscs.Marker = nil end Item.B_OnMove = false end
                                function Item:DoClick() Item.N_Clicked = CurTime() +0.2  local yes, pro = true, LocalPlayer().xdefm_Profile
                                    if pro.Money < Item.N_Cost then xdefm_AddNote( ply, "xdefm.NoMoney", "resource/warning.wav", "cross", 5 ) yes = false end
                                    if pro.Level < Item.N_Level then xdefm_AddNote( ply, "xdefm.NoLevel", "resource/warning.wav", "cross", 5 ) yes = false end
                                    if yes then xdefm_Command( LocalPlayer(), "Structure", k ) end end
                                function Item:OnRemove() Item:OnCursorExited() end
                                function Item:Paint( w, h ) local col = xdefm.miscs.Rarity[ Item.N_Rarity+1 ]
                                    draw.RoundedBox( 0, 0, 0, w, h, col )  local pro = LocalPlayer().xdefm_Profile  if !istable( pro ) then return end
                                    Item.N_Lerp = Lerp( 0.2, Item.N_Lerp, Item.N_Clicked > CurTime() and 0.1 or ( xdefm.miscs.AimPan == Item and 0.5 or 0.3 ) )
                                    local ccc = Item.N_Lerp  draw.RoundedBox( 0, 1, 1, w -2, h -2, Color( col.r*ccc, col.g*ccc, col.b*ccc ) )
                                    surface.SetMaterial( MaX ) surface.SetDrawColor( col.r*ccc*1.5, col.g*ccc*1.5, col.b*ccc*1.5 ) surface.DrawTexturedRect( 1, 1, w -2, h -2 )
                                    local co1, co2 = Color( 255, 0, 0 ), Color( 0, 255, 0 )
                                    draw.TextShadow( {
                                        text = language.GetPhrase( Item.S_Name ), pos = { 75, 15 }, font = "xdefm_Font2",
                                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = col
                                    }, 1, 255 )
                                    draw.TextShadow( {
                                        text = language.GetPhrase( "xdefm.Price" )..": "..Item.N_Cost, pos = { 75, 35 }, font = "xdefm_Font2",
                                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = pro.Money >= Item.N_Cost and co2 or co1
                                    }, 1, 255 )
                                    draw.TextShadow( {
                                        text = language.GetPhrase( "xdefm.Level" )..": "..Item.N_Level, pos = { 75, 55 }, font = "xdefm_Font2",
                                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = pro.Level >= Item.N_Level and co2 or co1
                                    }, 1, 255 ) end
                                Item.P_Frame = Item:Add( "DPanel" )  Item:SetText( "" )
                                Item.P_Frame:SetSize( 64, 64 ) Item.P_Frame:SetPos( 6, 6 )
                                Item.P_Frame:SetMouseInputEnabled( false )  function Item.P_Frame:Paint( w, h ) local col = xdefm.miscs.Rarity[ Item.N_Rarity+1 ]
                                    surface.SetDrawColor( Color( col.r*0.2, col.g*0.2, col.b*0.2 ) )  surface.DrawRect( 0, 0, w, h )
                                    surface.SetDrawColor( col )  surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                                    surface.SetDrawColor( xdefm.lin_col )  surface.DrawOutlinedRect( 0, 0, w, h, 1 ) end
                                Item.P_Icon = Item.P_Frame:Add( "ModelImage" ) Item.P_Icon:DockMargin( 5, 5, 5, 5 )
                                Item.P_Icon:Dock( FILL ) Item.P_Icon:SetModel( bb.Model[ 1 ] ) Item.P_Icon:SetMouseInputEnabled( false )
                            end
                        end
                    end
                end
            end
            pan:XDEFM_Update( 2, tab )
        elseif typ == 5 then -- 银行
            if IsValid( xdefm.miscs.Menus[ "Bank" ] ) then return end
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Bank = pan  pan.T_Data = tab  pan.T_Slots = {}  pan.N_Store = 0
            pan:SetPos( ScrW()/2 -40, ScrH()/2 -550/2 ) pan:SetSize( 800, 600 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:ParentToHUD() pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -40, ScrH()/2 -500/2, 0.2 )
            function pan:Paint( w, h ) local tab = pan.T_Data  local pro = LocalPlayer().xdefm_Profile
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.Bank" ).." ( "..pan.N_Store.." / "..pro.UpdF.." )", pos = { w/2, 25 }, font = "xdefm_Font6",
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                }, 1, 255 ) end
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 760, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end --
            if true then -- 内容
                local bck = pan:Add( "DPanel" ) bck:SetSize( 784, 541 ) bck:SetPos( 8, 50 )
                pan.P_Scroll = pan:Add( "DScrollPanel" )
                pan.P_Scroll:SetSize( 784, 534 ) pan.P_Scroll:SetPos( 9, 53 )  pan.N_Sto = 0
                local vba = pan.P_Scroll:GetVBar()  vba:SetHideButtons( true )  vba:SetSize( 0, 0 )
                function vba.btnGrip:Paint( w, h ) end function vba:Paint( w, h ) end
                function pan.P_Scroll:Paint( w, h ) end
                function bck:Paint( w, h )
                    surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h )
                end pan.P_Hold = pan.P_Scroll:Add( "DIconLayout" )  local pa2 = pan.P_Hold  pa2:SetSize( 784, 0 )
                pa2:DockMargin( 4, 4, 4, 4 ) pa2:SetSpaceX( 3 ) pa2:SetSpaceY( 3 ) pa2:SetPos( 4, 2 ) function pa2:Paint( w, h ) end end
            function pan:XDEFM_Update( id, dt ) if id == 0 then local pro = dt  pan.N_Store = 0
                    for k, v in pairs( pan.T_Slots ) do
                        if IsValid( v ) and k > pro.UpdF then v:Remove() pan.T_Slots[ k ] = nil end
                    end if pro.UpdF <= 0 then pan.T_Slots = {} return end
                    for i=1, pro.UpdF do local ite = pro.Bnk[ i ]  if !isstring( ite ) then continue end
                        local slo = nil  if IsValid( pan.T_Slots[ i ] ) then slo = pan.T_Slots[ i ] else
                            slo = xdefm_SlotBox( 0, 0, 108, 108, i, tostring( i ) )  pan.P_Hold:Add( slo )
                            pan.T_Slots[ i ] = slo  slo.S_Type = "Bank"
                        end slo:F_SetupItem( ite )  if ite != "_" then pan.N_Store = pan.N_Store + 1 end
                        function slo:DoRightClick( Pnl ) if slo.T_Item == nil or slo:IsDragging() or !IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then return end
                            if IsValid( pan.P_DMenu ) then pan.P_DMenu:Remove() end pan.P_DMenu = DermaMenu( false, nil )  local dnm = pan.P_DMenu
                            local O_Take = dnm:AddOption( "#xdefm.Take", function() if !slo.B_OnMove and IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then
                            local num = 0  for k, v in pairs( LocalPlayer().xdefm_Profile.Items ) do
                                if isstring( v ) and v == "_" then num = k break end
                            end if num > 0 then xdefm_Command( LocalPlayer(), "MoveBank", num.."|"..i )
                            else xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 ) end end end )
                            O_Take:SetIcon( "icon16/basket_put.png" ) dnm:Open()
                        end
                    end
                end
            end pan:XDEFM_Update( 0, LocalPlayer().xdefm_Profile )
        elseif typ == 6 then -- 好友列表
            if IsValid( xdefm.miscs.Menus[ "Friends" ] ) then return end
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Friends = pan  pan.T_Data = tab  pan.N_Count = 0  pan.B_Edited = false
            pan:SetPos( ScrW()/2 -200, ScrH()/2 -550/2 ) pan:SetSize( 400, 550 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:ParentToHUD() pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -200, ScrH()/2 -500/2, 0.2 ) pan.N_Clicked = 0
            function pan:Paint( w, h ) local tab = pan.T_Data
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.FList" ), font = "xdefm_Font6", pos = { w/2, 24 },
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                }, 1, 255 )
                draw.RoundedBox( 0, 8 +0, 50 +0, 382, 420, xdefm.lin_col )
                draw.RoundedBox( 0, 8 +1, 50 +1, 382 -2, 420 -2, xdefm.ext_col )
                draw.RoundedBox( 0, 8 +2, 50 +2, 382 -4, 420 -4, xdefm.bck_col )
                draw.RoundedBox( 0, 8 +0, 474 +0, 382, 30, xdefm.lin_col )
                draw.RoundedBox( 0, 8 +1, 474 +1, 382 -2, 30 -2, xdefm.ext_col )
                draw.RoundedBox( 0, 8 +2, 474 +2, 382 -4, 30 -4, xdefm.bck_col ) end
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 360, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end --
            if true then -- 列表
                pan.P_List = vgui.Create( "DListView", pan )
                pan.P_List:SetPos( 11, 53 ) pan.P_List:SetSize( 376, 414 )
                pan.P_List:SetMultiSelect( false )
                local p1 = pan.P_List:AddColumn( language.GetPhrase( "xdefm.Player" ) )
                local p2 = pan.P_List:AddColumn( language.GetPhrase( "xdefm.Friend" ) )
                p1:SetWidth( 180 )
                function pan.P_List:RefreshPlayerS() pan.P_List:Clear()
                    for k, v in pairs( pan.T_Data ) do if !isnumber( tonumber( v[ 2 ] ) ) then return end
                        local aa, cc, dd, nn = false, tonumber( v[ 2 ] ), player.GetBySteamID( k ), k
                        if IsValid( dd ) and dd:IsPlayer() then nn = dd:Nick() else nn = v[ 1 ] end
                        local ee = ( cc > 0 and language.GetPhrase( "xdefm.Allow" ) or language.GetPhrase( "xdefm.Disallow" ) )
                        local pnl = pan.P_List:AddLine( nn, ee )  pnl.N_RightStat = cc  pnl.S_SteamID = k  pnl.S_Name = nn
                        pnl:SetToolTip( k )  pan.N_Count = pan.N_Count +1
                    end
                end
                function pan.P_List:OnRowSelected( id, pnl ) local stt = pnl.N_RightStat  pan.P_List:ClearSelection()
                    if IsValid( pan.P_DMenu ) then pan.P_DMenu:Remove() end pan.P_DMenu = DermaMenu( false, nil )  local dnm = pan.P_DMenu
                    local aa = stt > 0 and true or false
                    local O_ = dnm:AddOption( pnl.S_Name, function() xdefm_AddNote( ply, "xdefm.CopiedID", "weapons/pistol/pistol_empty.wav", "tick", 5 )
                    SetClipboardText( pnl:GetTooltip() ) end )
                    local O_aa = dnm:AddOption( language.GetPhrase( aa and "xdefm.Disallow" or "xdefm.Allow" ).." "..language.GetPhrase( "xdefm.Friend" ), function()
                        if !IsValid( pan ) or !istable( pan.T_Data ) then return end
                        if !IsValid( pnl ) or !istable( pan.T_Data[ pnl.S_SteamID ] ) or !isnumber( pnl.N_RightStat ) then return end local stt = math.Clamp( math.Round( pnl.N_RightStat ), 0, 1 )
                        if aa then if stt > 0 then pnl.N_RightStat = 0 end else if stt == 0 then pnl.N_RightStat = 1 end end
                        pnl:SetColumnText( 2, language.GetPhrase( aa and "xdefm.Disallow" or "xdefm.Allow" ) )  pan.B_Edited = true
                        pan.T_Data[ pnl.S_SteamID ][ 2 ] = pnl.N_RightStat
                    end )
                    O_aa:SetIcon( aa and "icon16/cross.png" or "icon16/tick.png" )
                    local O_cc = dnm:AddOption( language.GetPhrase( "xdefm.Delete" ), function()
                        if !IsValid( pan ) or !istable( pan.T_Data ) then return end
                        if !IsValid( pnl ) or !istable( pan.T_Data[ pnl.S_SteamID ] ) or !isnumber( pnl.N_RightStat ) then return end
                        pan.T_Data[ pnl.S_SteamID ] = nil  pan.P_List:RemoveLine( id ) pan.B_Edited = true
                    end )
                    O_cc:SetIcon( "icon16/group_delete.png" ) dnm:Open()
                end
                pan.P_List:RefreshPlayerS() end
            if true then -- 添加
                pan.P_Entry = vgui.Create( "DTextEntry", pan )
                pan.P_Entry:SetSize( 376, 24 ) pan.P_Entry:SetPos( 11, 477 )
                pan.P_Entry:SetUpdateOnType( true ) pan.P_Entry:SetNumeric( false ) pan.P_Entry:SetMultiline( false )
                pan.P_Entry:SetTextColor( Color( 0, 0, 0 ) ) pan.P_Entry.S_Enter = ""
                pan.P_Entry:SetPlaceholderText( "#xdefm.FriendAdd" )
                function pan.P_Entry:FindTheFriend() local ply, str = nil, pan.P_Entry.S_Enter
                    if pan.N_Count >= 16 then xdefm_AddNote( ply, "xdefm.FriendAd5", "resource/warning.wav", "cross", 5 ) return end
                    if str == "" then xdefm_AddNote( ply, "xdefm.FriendAd3", "resource/warning.wav", "cross", 5 ) return end
                    for k, v in pairs( player.GetAll() ) do if !IsValid( v ) or v:IsBot() or v == LocalPlayer() or istable( pan.T_Data[ v:SteamID() ] ) then continue end
                        if v:SteamID() == str then ply = v break end
                        local st, ed = string.find( string.lower( v:Nick() ), string.lower( str ) )
                        if st then ply = v break end
                    end if !IsValid( ply ) then xdefm_AddNote( ply, "xdefm.FriendAd3", "resource/warning.wav", "cross", 5 ) return end
                    local pnl = pan.P_List:AddLine( ply:Nick(), language.GetPhrase( "xdefm.Disallow" ), language.GetPhrase( "xdefm.Disallow" ) )  pnl.N_RightStat = 0
                    pnl.S_SteamID = ply:SteamID()  pnl.S_Name = ply:Nick()  pnl:SetToolTip( ply:SteamID() )
                    xdefm_AddNote( ply, language.GetPhrase( "xdefm.FriendAd4" )..": "..ply:Nick(), "buttons/button15.wav", "group_add", 5 ) pnl.S_SteamID = ply:SteamID()
                    pan.N_Count = pan.N_Count +1  pan.T_Data[ ply:SteamID() ] = { ply:Nick(), 0 }
                    pan.P_Entry.S_Enter = ""  pan.P_Entry:SetText( "" )  pan.B_Edited = true
                end
                function pan.P_Entry:OnEnter() pan.P_Entry.FindTheFriend() end
                function pan.P_Entry:OnValueChange( val ) if string.len( val ) >= 64 then
                    pan.P_Entry:SetText( pan.P_Entry.S_Enter ) surface.PlaySound( "resource/warning.wav" )
                    else pan.P_Entry.S_Enter = val end
                end
                pan.P_Search = vgui.Create( "DImageButton", pan.P_Entry ) local pax = pan.P_Search
                pax:SetImage( "icon16/add.png" ) pax:SetToolTip( "#xdefm.FriendAd2" )
                pax:SetPos( 356, 4 ) pax:SetSize( 16, 16 ) end function pan.P_Search:DoClick() pan.P_Entry.FindTheFriend() end
            for i=1, 2 do -- 重置/确认
                local but = vgui.Create( "DButton", pan )  but:SetText( "" )  but.B_Hover = false  but.N_Lerp = 0
                but:SetSize( 120, 30 )  but:SetPos( -100 +i*160, 510 ) but:SetIcon( i == 1 and "icon16/group_go.png" or "icon16/group_edit.png" )
                function but:Paint( w, h ) local col = Color( 100, 100, 100 )
                    but.N_Lerp = Lerp( 0.2, but.N_Lerp, pan.N_Clicked > CurTime() and -1 or ( but.B_Hover and 1 or 0 ) )
                    if pan.B_Edited then col = Color( 155, 0, 0 ) end
                    col = Color( col.r +col.r*0.5*but.N_Lerp, col.g +col.g*0.5*but.N_Lerp, col.b +col.b*0.5*but.N_Lerp )
                    surface.SetDrawColor( col ) surface.DrawRect( 0, 0, w, h )
                    draw.TextShadow( { text = i == 1 and "#xdefm.Reset" or "#xdefm.Apply", pos = { w/2, h/2 }, font = "xdefm_Font1",
                    color = Color( 255, 255, 255 ), xalign = TEXT_ALIGN_CENTER, yalign =  TEXT_ALIGN_CENTER }, 1, 200 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                end
                function but:OnCursorEntered() but.B_Hover = true end
                function but:OnCursorExited() but.B_Hover = false end
                function but:DoClick() if pan.N_Clicked > CurTime() then return end
                    pan.N_Clicked = CurTime() +1  pan.B_Edited = false  local str = util.TableToJSON( pan.T_Data, true )
                    net.Start( "NET_xdefm_SendFriends" ) if i == 2 then net.WriteString( str ) end net.SendToServer()
                end
            end
            function pan:XDEFM_Update( id, dt ) if id == 2 then pan.T_Data = dt  pan.P_List:RefreshPlayerS() end end
        elseif typ == 7 then -- 交易
            if IsValid( xdefm.miscs.Menus[ "Trade" ] ) then return end
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Trade = pan
            pan.T_PlyA = { LocalPlayer():Nick(), LocalPlayer():SteamID64(), LocalPlayer():GetNWFloat( "XDEFMod_RTT" ) }
            pan.T_PlyB = { "_", nil, false }  pan.T_Slo1 = {}  pan.T_Slo2 = {}
            pan.T_TabA = tab  pan.T_TabB = { "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", 0 }
            pan:SetPos( ScrW()/2 -40, ScrH()/2 -750/2 ) pan:SetSize( 500, 685 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:ParentToHUD() pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -40, ScrH()/2 -700/2, 0.2 )
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 455, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end --
            function pan:Paint( w, h ) local tab = pan.T_Data  local pro = LocalPlayer().xdefm_Profile
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.Weapon_Trade" ), pos = { w/2, 25 }, font = "xdefm_Font6",
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                }, 1, 255 ) end
            for i=1, 2 do -- 已方对方
                local pax = vgui.Create( "DPanel", pan ) pax:SetPos( 8, 50 +(i-1)*315 ) pax:SetSize( 484, 310 ) pax.N_Clicked = 0
                function pax:Paint( w, h ) local bb = ( i == 1 and true or false )
                    local tab = ( i == 1 and pan.T_PlyA or pan.T_PlyB )  local ta2 = ( i == 1 and pan.T_TabA or pan.T_TabB )
                    surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h )
                    draw.TextShadow( {
                        text = tab[ 1 ], pos = { 80, 24 }, font = "xdefm_Font4",
                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                    }, 1, 255 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 10, 77, 464, 188, 2 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 10, 77, 464, 188, 1 )
                    draw.TextShadow( {
                        text = language.GetPhrase( "xdefm.Money" )..": ", pos = { 8, 285 }, font = "xdefm_Font1",
                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                    }, 1, 255 )
                    if IsValid( pax.P_Entry ) and i != 2 then
                        local col = ( pax.P_Entry:IsEditing() and Color( 150, 150, 150 ) or Color( 75, 75, 75 ) )
                        if !pax.P_Entry:IsEditing() and ta2[ 11 ] != pax.P_Entry.N_Enter then col = Color( 150, 25, 25 ) end
                        surface.SetDrawColor( Color( xdefm.bck_col.r*0.5, xdefm.bck_col.g*0.5, xdefm.bck_col.b*0.5, xdefm.bck_col.a*0.5 ) ) surface.DrawRect( 80, 272, 215 +6, 30 )
                        surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 80, 272, 215 +6, 30, 2 )
                        surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 80, 272, 215 +6, 30 )
                    end
                end
                if true then -- 交易确认
                    local but = vgui.Create( "DButton", pax )  but:SetText( "" )  but.B_Hover = false
                    but:SetSize( 150, 25 )  but:SetPos( 84, 42 )
                    function but:Paint( w, h ) local col, ply = Color( 100, 100, 100 ), LocalPlayer()
                        if !ply:GetNWEntity( "XDEFMod_TPL" ):IsPlayer() or ply:GetNWEntity( "XDEFMod_TPL" ):GetNWEntity( "XDEFMod_TPL" ) != ply then return end
                        local rd = false  if i == 1 then rd = ( LocalPlayer():GetNWFloat( "XDEFMod_RTT" ) == 1 )
                        elseif i == 2 then rd = ( pan.T_PlyB[ 3 ] == 1 ) end
                        col = ( rd and Color( 55, 155, 55 ) or Color( 155, 55, 55 ) )
                        if pax.N_Clicked <= CurTime() and but.B_Hover then col = Color( col.r*1.5, col.g*1.5, col.b*1.5 ) end
                        if pax.N_Clicked > CurTime() then col = Color( col.r*0.25, col.g*0.25, col.b*0.25 ) end
                        surface.SetDrawColor( col ) surface.DrawRect( 0, 0, w, h )
                        draw.TextShadow( { text = rd and "#xdefm.ReadyY" or "#xdefm.ReadyN", pos = { w/2, h/2 -2 }, font = "xdefm_Font1",
                        color = Color( 255, 255, 255 ), xalign = TEXT_ALIGN_CENTER, yalign =  TEXT_ALIGN_CENTER }, 1, 200 )
                        if i == 1 then surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                        surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 ) end
                    end if i == 2 then but:SetMouseInputEnabled( false ) end if i == 1 then pan.P_ButA = but else pan.P_ButB = but end
                    function but:OnCursorEntered() but.B_Hover = true end function but:OnCursorExited() but.B_Hover = false end
                    function but:DoClick() if pax.N_Clicked > CurTime() then return end
                        pax.N_Clicked = CurTime() +1  xdefm_Command( LocalPlayer(), "TradeToggle", "_" ) 
                    end end
                if true then -- 钱数
                    pax.P_Entry = vgui.Create( "DTextEntry", pax ) 
                    pax.P_Entry:SetSize( 215, 24 )
                    pax.P_Entry:SetPos( 85, 275 )
                    pax.P_Entry:SetUpdateOnType( true )
                    pax.P_Entry:SetNumeric( true )
                    pax.P_Entry:SetMultiline( false )
                    pax.P_Entry:SetCursorColor( Color( 255, 255, 255 ) )
                    pax.P_Entry:SetFont( "xdefm_Font5" )
                    pax.P_Entry:SetPaintBackground( false )
                    pax.P_Entry:SetTextColor( Color( 255, 255, 255 ) )
                    local tab = ( i == 1 and pan.T_TabA or pan.T_TabB )
                    pax.P_Entry.N_Enter = tab[ 11 ]
                    pax.P_Entry:SetText( tostring( pax.P_Entry.N_Enter ) )
                    pax.P_Entry:SetPlaceholderText( "#xdefm.PutMoney" )
                    pax.P_Entry:SetToolTip( tab[ 11 ] )
                    function pax.P_Entry:OnEnter() xdefm_Command( LocalPlayer(), "TradeMoney", tostring( pax.P_Entry.N_Enter ) ) end
                    function pax.P_Entry:OnValueChange( val ) local tum, vat, fce = tonumber( val ), 0, false  if val != "" and ( !isnumber( tum ) or string.len( val ) >= 64 or tum < 0 or tum > 2147483647 ) then
                        if isnumber( tum ) and tum > 2147483647 then vat = 2147483647  fce = true elseif isnumber( tum ) and tum < 0 then vat = 0  fce = true else vat = pax.P_Entry.N_Enter
                        pax.P_Entry:SetText( tostring( pax.P_Entry.N_Enter ) ) end surface.PlaySound( "resource/warning.wav" )
                        else vat = tum  if val == "" then vat = 0  fce = true end end if pax.P_Entry.N_Enter != vat then pax.P_Entry.N_Enter = vat end
                        if fce then pax.P_Entry:SetText( tostring( pax.P_Entry.N_Enter ) ) end
                    end if i == 2 then pax.P_Entry:SetEnabled( false )  pax.P_Entry:SetMouseInputEnabled( false ) else
                        pax.P_Confirm = vgui.Create( "DImageButton", pax.P_Entry ) local pa2 = pax.P_Confirm
                        pa2:SetImage( "icon16/cog.png" ) pa2:SetToolTip( "#xdefm.PutMone2" )
                        pa2:SetPos( 173, 4 ) pa2:SetSize( 16, 16 ) function pa2:DoClick() xdefm_Command( LocalPlayer(), "TradeMoney", tostring( pax.P_Entry.N_Enter ) ) end
                        pax.P_Take = vgui.Create( "DImageButton", pax.P_Entry ) local pa3 = pax.P_Take
                        pa3:SetImage( "icon16/coins.png" ) pa3:SetToolTip( "#xdefm.PutMone3" )
                        pa3:SetPos( 193, 4 ) pa3:SetSize( 16, 16 ) function pa3:DoClick() xdefm_Command( LocalPlayer(), "TradeMoney", "0" ) end
                    end end
                if true then -- 头像
                    pax.P_AIcon = pax:Add( "AvatarImage" )  local pa2 = pax.P_AIcon
                    pa2:SetPos( 8, 8 ) pa2:SetSize( 64, 64 ) pa2:SetMouseInputEnabled( false )
                    pax.P_AFrame = pax:Add( "DPanel" )  pa2 = pax.P_AFrame
                    local tab = ( i == 1 and pan.T_PlyA or pan.T_PlyB )
                    if tab[ 2 ] != nil then pax.P_AIcon:SetSteamID( tab[ 2 ], 128 ) end
                    pa2:SetText( "" ) pa2:SetPos( 8, 8 ) pa2:SetSize( 64, 64 ) pa2:SetMouseInputEnabled( false )
                    function pa2:Paint( w, h ) surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 ) end end
                if true then -- 物品框架
                    pax.P_Hold = pax:Add( "DIconLayout" )  pax.P_Hold:SetPos( 13, 80 ) pax.P_Hold:SetSize( 484-16, 180 )
                    pax.P_Hold:SetSpaceX( 2 ) pax.P_Hold:SetSpaceY( 2 ) local tab = nil
                    if i == 1 then tab = pan.T_Slo1 else tab = pan.T_Slo2 end
                    for x = 1, 10 do local slo = xdefm_SlotBox( 0, 0, 90, 90, x, tostring( x ), nil, ( i == 2 and true or false ) )
                    if i == 1 then slo.S_Type = "Trade"
                        function slo:DoRightClick( Pnl ) if slo.T_Item == nil or slo:IsDragging() or !IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then return end
                            if IsValid( pan.P_DMenu ) then pan.P_DMenu:Remove() end pan.P_DMenu = DermaMenu( false, nil )  local dnm = pan.P_DMenu
                            local O_Take = dnm:AddOption( "#xdefm.Take", function() if !slo.B_OnMove and IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then
                            local num = 0  for k, v in pairs( LocalPlayer().xdefm_Profile.Items ) do
                                if isstring( v ) and v == "_" then num = k break end
                            end if num > 0 then xdefm_Command( LocalPlayer(), "MoveTrade", num.."|"..x )
                            else xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 ) end end end )
                            O_Take:SetIcon( "icon16/basket_remove.png" ) dnm:Open()
                        end
                    end pax.P_Hold:Add( slo ) table.insert( tab, slo ) end end
                if i == 1 then pan.P_PanA = pax else pan.P_PanB = pax end end
            if true then -- 无交易对象时遮住下头
                pan.P_NoTrade = vgui.Create( "DPanel", pan ) pan.P_NoTrade:SetPos( 8, 365 ) pan.P_NoTrade:SetSize( 484, 310 )
                function pan.P_NoTrade:Paint( w, h )
                    surface.SetDrawColor( Color( xdefm.bck_col.r*0.5, xdefm.bck_col.g*0.5, xdefm.bck_col.b*0.5, 255 ) ) surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h )
                    draw.TextShadow( {
                        text = language.GetPhrase( "xdefm.Trade17" ), pos = { w/2, h/2 }, font = "xdefm_Font6",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 )
                    }, 1, 255 )
                end end
            pan.P_NoTrade:SetMouseInputEnabled( true ) pan.P_NoTrade:SetAlpha( 255 )
            pan.P_PanB:SetMouseInputEnabled( false ) pan.P_PanB:SetAlpha( 0 )
            function pan:XDEFM_Update( id, dt )
                if id == 4 then pan.T_TabA = dt  for i=1, 10 do pan.T_Slo1[ i ]:F_SetupItem( dt[ i ] ) end
                    pan.P_PanA.P_Entry.N_Enter = dt[ 11 ]  pan.P_PanA.P_Entry:SetText( tostring( dt[ 11 ] ) ) pan.P_PanA.P_Entry:SetToolTip( dt[ 11 ] )
                end
                if id == 5 then pan.T_TabB = dt  for i=1, 10 do pan.T_Slo2[ i ]:F_SetupItem( dt[ i ] ) end
                    pan.P_PanB.P_Entry.N_Enter = dt[ 11 ]  pan.P_PanB.P_Entry:SetText( tostring( dt[ 11 ] ) ) pan.P_PanB.P_Entry:SetToolTip( dt[ 11 ] )
                end
                if id == 6 then pan.T_PlyB = dt  local sid = dt[ 2 ]
                    if sid != nil then
                        pan.P_NoTrade:SetMouseInputEnabled( false ) pan.P_NoTrade:SetAlpha( 0 )
                        pan.P_PanB:SetMouseInputEnabled( true ) pan.P_PanB:SetAlpha( 255 )
                        pan.P_PanB.P_AIcon:SetSteamID( sid, 128 )
                    else pan.P_NoTrade:SetMouseInputEnabled( true ) pan.P_NoTrade:SetAlpha( 255 )
                    pan.P_PanB:SetMouseInputEnabled( false ) pan.P_PanB:SetAlpha( 0 ) end
                end
            end pan:XDEFM_Update( 4, tab )
        elseif typ == 8 then -- 图鉴
            if IsValid( xdefm.miscs.Menus[ "Bestiary" ] ) then return end
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Bestiary = pan  pan.T_Items = {}  pan.N_Total = 0  pan.N_All = 0
            for k, v in pairs( xdefm.items ) do pan.N_All = pan.N_All +1 end pan.N_Bing = -1
            pan.T_Typs = { ["Creature"] = true, ["Bait"] = true, ["Useless"] = true, ["Recipe"] = true, ["Structure"] = true }
            pan.T_Rars = { true, true, true, true, true }  pan.T_Buts = {}  pan.T_But2 = {}  pan.T_Dats = { PagO = 0, PagT = 0, Num = 0 }
            local Typs = { "Creature", "Bait", "Useless", "Recipe", "Structure" }
            local cvar = string.Explode( "", GetConVar( "xdefmod_collection" ):GetString() )
            if !istable( cvar ) or #cvar != 11 then RunConsoleCommand( "xdefmod_collection", "11111111111" )
            else
                for k, v in pairs( cvar ) do
                    v = tonumber( v )  if !isnumber( v ) then continue end
                    if k <= 5 then pan.T_Typs[ Typs[ k ] ] = ( v != 0 )
                    elseif k != 11 then pan.T_Rars[ k-5 ] = ( v != 0 )
                    else pan.T_Dats.PagO = v end
                end
            end
            if istable( xdefm.besti ) then for k, v in pairs( xdefm.besti ) do if xdefm.items[ k ] then table.insert( pan.T_Items, k ) pan.N_Total = pan.N_Total +1 end end end
            pan:SetPos( ScrW()/2 -750/2, ScrH()/2 -700/2 ) pan:SetSize( 750, 700 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:ParentToHUD() pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -750/2, ScrH()/2 -750/2, 0.2 ) pan.B_Hover = false
            if ply:IsSuperAdmin() then pan:SetIcon( "icon16/shield.png" ) end
            local Ma2 = Material( "vgui/gradient_up" )
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 710, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end --
            function pan:Paint( w, h ) local pro = LocalPlayer().xdefm_Profile
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.RoundedBox( 0, 24 +0, 45 +0, -52 +w, 80, xdefm.lin_col )
                draw.RoundedBox( 0, 24 +1, 45 +1, -52 +w -2, 80 -2, xdefm.ext_col )
                draw.RoundedBox( 0, 24 +2, 45 +2, -52 +w -4, 80 -4, xdefm.bck_col )
                local per = math.Clamp( pan.N_Total/pan.N_All, 0, 1 )
                local col = Color( 0, 155, 200 ) if per >= 1 then col = Color( 200, 155, 0 ) end
                draw.RoundedBox( 0, 8 +0, 650 +0, -16 +w, 40, xdefm.lin_col )
                draw.RoundedBox( 0, 8 +1, 650 +1, -16 +w -2, 40 -2, xdefm.ext_col )
                draw.RoundedBox( 0, 8 +2, 650 +2, -16 +w -4, 40 -4, xdefm.bck_col )
                draw.RoundedBox( 0, 8 +4, 650 +4, ( w-24 )*per, 40 -8, col )
                pan.N_Bing = Lerp( 0.05, pan.N_Bing, pan.B_Hover and 0.25 or 0 )
                draw.RoundedBox( 0, 8 +4, 650 +4, ( w-24 )*per, 40 -8, Color( 255, 255, 255, 255*pan.N_Bing ) )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 7, 163, w -14, h -277, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 7, 163, w -14, h -277, 1 )
                if !pan.B_Hover then local ppp = math.Round( per, 4 )*100
                    draw.TextShadow( { text = language.GetPhrase( "xdefm.Progress" )..": "..ppp.."%", pos = { w/2, 670 },
                    font = "xdefm_Font4", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                else draw.TextShadow( { text = language.GetPhrase( "xdefm.Progress" )..": "..pan.N_Total.."/"..pan.N_All, pos = { w/2, 670 },
                    font = "xdefm_Font4", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                end draw.TextShadow( {
                    text = language.GetPhrase( "xdefm.Collection" ), pos = { w/2, 25 }, font = "xdefm_Font6",
                    xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                draw.TextShadow( { text = language.GetPhrase( "xdefm.Total" )..": "..pan.T_Dats.Num, pos = { 150 +w/2, 145 },
                font = "xdefm_Font5", xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                if pan.T_Dats.PagT > 0 then
                    draw.TextShadow( { text = language.GetPhrase( "xdefm.Page" )..": "..pan.T_Dats.PagO.."/"..pan.T_Dats.PagT, pos = { -150 +w/2, 145 },
                    font = "xdefm_Font5", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                else draw.TextShadow( { text = language.GetPhrase( "xdefm.Page" )..": 0", pos = { -150 +w/2, 145 },
                    font = "xdefm_Font5", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                end end
            local function AddTickButton( x, y, typ ) if !isstring( typ ) then typ = "Useless" end
                local but = pan:Add( "DButton" ) but:SetPos( x, y ) but:SetSize( 160, 32 ) but:SetText( "" )
                but.B_Hover = false  but.N_Ho = 0  but.N_In = 0  pan.T_Buts[ typ ] = but
                function but:Paint( w, h ) local pe3 = 0
                    if but.B_Hover then pe3 = math.Clamp( but.N_Ho -SysTime(), 0, 1 )
                    else pe3 = 1-math.Clamp( but.N_Ho -SysTime(), 0, 1 ) end
                    surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h )
                    if but.N_In > SysTime() then local per = ( 1-math.Clamp( ( but.N_In -SysTime() )/0.4, 0, 1 ) )
                        local pe2 = math.Clamp( per*2, 0, 1 )
                        draw.RoundedBox( 0, 2, 2, ( w -4 )*pe2, ( h -4 )*pe2, Color( 255, 255, 255, 255*(1-per) ) ) end
                    draw.RoundedBox( 0, 2, 2, w -4, h -4, Color( 255, 255, 255, 50*(1-pe3) ) )
                    draw.TextShadow( { text = language.GetPhrase( "xdefm."..typ ), pos = { 32, h/2 },
                    font = "xdefm_Font1", xalign = TEXT_ALIGN_LEFT,
                    yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255*pe3 ) }, 1, 255 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawRect( w -20 -8, 5, 22, 22 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( w -20 -8, 5, 22, 22, 3 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( w -20 -8, 5, 22, 22, 1 )
                    if pan.T_Typs[ typ ] then draw.TextShadow( { text = "●", pos = { w -18, 16 },
                        font = "xdefm_Font2", xalign = TEXT_ALIGN_CENTER,
                        yalign = TEXT_ALIGN_CENTER, color = Color( 0, 255, 0 ) }, 1, 255 ) end end
                function but:OnCursorEntered() but.B_Hover = true  but.N_Ho = SysTime() +0.5 end
                function but:OnCursorExited() but.B_Hover = false  but.N_Ho = SysTime() +0.5 end
                function but:DoClick() pan.T_Typs[ typ ] = !pan.T_Typs[ typ ]  but.N_In = SysTime() +0.4
                if input.IsShiftDown() then local ref = pan.T_Typs[ typ ]
                    for k, v in pairs( pan.T_Typs ) do if k != typ and v != ref then pan.T_Typs[ k ] = ref  pan.T_Buts[ k ].N_In = SysTime() +0.4 end end
                end pan:RefreshDatItems() end
                function but:DoRightClick() local ref = false
                    if pan.T_Typs[ typ ] == false then pan.T_Typs[ typ ] = true  but.N_In = SysTime() +0.4  ref = true end
                    for k, v in pairs( pan.T_Typs ) do if k != typ and v == true then pan.T_Typs[ k ] = false  ref = true
                    if pan.T_Buts[ k ] then pan.T_Buts[ k ].N_In = SysTime() +0.4 end end end
                    if ref then pan:RefreshDatItems() end end
                local ico = xdefm.miscs.Icons[ typ ]  local spr = but:Add( "DImage" ) spr:SetPos( 8, 8 )
                spr:SetSize( 16, 16 ) spr:SetMaterial( ico ) return but end local ba = 30
            AddTickButton( ba, 50, "Useless" ) AddTickButton( ba +175, 50, "Creature" )
            AddTickButton( ba +175*2, 50, "Bait" ) AddTickButton( ba +175*3, 50, "Recipe" ) AddTickButton( ba, 86, "Structure" )
            pan.P_Select = pan:Add( "DPanel" ) local pax = pan.P_Select  pax:SetSize( 734 -6, 420 -6 )
            pax:SetPos( 8 +3, 165 +3 ) local Mat = Material( "gui/center_gradient" )
            function pax:Paint( w, h ) surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h ) end
            pan.P_Items = pax:Add( "DIconLayout" ) local pa2 = pan.P_Items  pa2:Dock( FILL )
            pa2:SetSpaceX( 4.5 ) pa2:SetSpaceY( 4.5 ) function pa2:Paint( w, h ) end
            for i=1, 5 do local but = pan:Add( "DButton" ) but:SetSize( 20, 45 ) but:SetText( "" )  pan.T_But2[ i ] = but
            but:SetPos( 8 +(i-1)*30, 596 ) but:SetToolTip( "#xdefm.T"..i ) function but:Paint( w, h ) local col = xdefm.miscs.Rarity[ i+1 ]
                surface.SetDrawColor( col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Ma2 ) surface.SetDrawColor( col.r*0.5, col.g*0.5, col.b*0.5 ) surface.DrawTexturedRect( 0, 0, w, h )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                if pan.T_Rars[ i ] == true then surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 ) end
            end function but:DoClick() pan.T_Rars[ i ] = !pan.T_Rars[ i ]
            if input.IsShiftDown() then local ref = pan.T_Rars[ i ]
                for k, v in pairs( pan.T_Rars ) do if k != i and v != ref then pan.T_Rars[ k ] = ref end end
            end pan:RefreshDatItems( pag ) end
            function but:DoRightClick() local ref = false
                if pan.T_Rars[ i ] == false then pan.T_Rars[ i ] = true  ref = true end
                for k, v in pairs( pan.T_Rars ) do if k != i and v == true then pan.T_Rars[ k ] = false  ref = true end end
            if ref then pan:RefreshDatItems() end end end
            for i=1, 4 do local but = pan:Add( "DButton" ) but:SetSize( 75, 30 ) but:SetText( "" ) but.B_Hover = false  but.N_Clicked = 0  but.N_Bing = 0
            but:SetPos( 366 +(i-1)*100, 606 ) function but:Paint( w, h ) local col = xdefm.miscs.Rarity[ i+1 ]
                local pgo, pgt = pan.T_Dats.PagO, pan.T_Dats.PagT
                but.N_Bing = Lerp( 0.2, but.N_Bing, but.N_Clicked > CurTime() and -1 or ( but.B_Hover and 1 or 0 ) )
                surface.SetDrawColor( Color( 100 +55*but.N_Bing, 100 +100*but.N_Bing, 100 +100*but.N_Bing ) )
                if pgt <= 0 or ( i == 1 and ( pgo <= 1 or pgt <= 2 ) ) or ( i == 2 and pgo <= 1 ) or ( i == 3 and pgo >= pgt )
                or ( i == 4 and ( pgo >= pgt or pgt <= 2 ) ) then surface.SetDrawColor( Color( 25, 25, 25 ) ) end
                surface.DrawRect( 0, 0, w, h ) surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 ) local txt = ""
                if i == 1 then txt = "A" elseif i == 2 then txt = "B" elseif i == 3 then txt = "C" elseif i == 4 then txt = "D" end
                draw.TextShadow( { text = language.GetPhrase( "xdefm.Page"..txt ), pos = { w/2, h/2 -2 }, font = "xdefm_Font4",
                xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
            end function but:OnCursorEntered() self.B_Hover = true end function but:OnCursorExited() self.B_Hover = false end
            function but:DoClick() if but.N_Clicked > CurTime() or pan.T_Dats.PagT <= 0 then return end but.N_Clicked = CurTime() +0.1
                local pgo, pgt = pan.T_Dats.PagO, pan.T_Dats.PagT
                if ( i == 1 and ( pgo <= 1 or pgt <= 2 ) ) or ( i == 2 and pgo <= 1 ) or ( i == 3 and pgo >= pgt )
                or ( i == 4 and ( pgo >= pgt or pgt <= 2 ) ) then return end
                if i == 1 then pan.T_Dats.PagO = 1 elseif i == 2 then pan.T_Dats.PagO = math.max( pan.T_Dats.PagO -1, 0 )
                elseif i == 3 then pan.T_Dats.PagO = math.min( pan.T_Dats.PagO +1, pgt ) elseif i == 4 then pan.T_Dats.PagO = pgt end pan:RefreshDatItems()
            end end
            pan.P_Prog = pan:Add( "DPanel" ) pan.P_Prog:SetSize( 734, 40 ) pan.P_Prog:SetPos( 8, 650 ) function pan.P_Prog:Paint( w, h ) end
            function pan.P_Prog:OnCursorEntered() pan.B_Hover = true end function pan.P_Prog:OnCursorExited() pan.B_Hover = false end
            function pan:RefreshDatItems() pa2:Clear() local ite = {}
                local ttl = 0  for k, v in pairs( pan.T_Items ) do
                    local tab = xdefm.items[ v ]  if !istable( tab ) or !isstring( tab.Type ) then continue end
                    if !pan.T_Typs[ tab.Type ] or pan.T_Typs[ tab.Type ] != true then continue end
                    if !pan.T_Rars[ tab.Rarity ] or pan.T_Rars[ tab.Rarity ] != true then continue end
                    table.insert( ite, v )  ttl = ttl +1
                end pan.T_Dats.Num = ttl  pan.T_Dats.PagT = math.ceil( ttl/28 )  local pag = pan.T_Dats.PagO
                if pag > pan.T_Dats.PagT then pan.T_Dats.PagO = pan.T_Dats.PagT
                elseif pag <= 0 and ttl > 0 then pan.T_Dats.PagO = 1 end pag = pan.T_Dats.PagO  local st = 1 +(pag-1)*28
                for i=st, st +27 do if !isstring( ite[ i ] ) then break end local cls = ite[ i ]
                    local tab = xdefm.items[ cls ]  if !istable( tab ) or !isstring( tab.Type ) then continue end
                    if !pan.T_Typs[ tab.Type ] or pan.T_Typs[ tab.Type ] != true then continue end
                    if !pan.T_Rars[ tab.Rarity ] or pan.T_Rars[ tab.Rarity ] != true then continue end
                    local slo = xdefm_SlotBox( 0, 0, 100, 100, 0, nil, xdefm.miscs.Icons[ tab.Type ], true )
                    if slo then slo:F_SetupItem( ite[ i ] ) pa2:Add( slo )
                        function slo:DoClick()
                            if !ply:IsSuperAdmin() then return end
                            local it = cls
                            if tab.Type == "Food" then 
                                it = it.."|"..tab.BestCook
                            elseif tab.Type == "Creature" then 
                                it = it.."|"..tab.MaxSize
                            elseif tab.Type == "Recipe" then 
                                it = it.."|"..tab.Durability 
                            end
                            surface.PlaySound( "garrysmod/ui_click.wav" )
                            RunConsoleCommand( "xdefmod_spawn", it )
                        end
                        function slo:DoRightClick() 
                            if !ply:IsSuperAdmin() then return end 
                            local it = cls
                            if tab.Type == "Food" then 
                                it = it.."|"..tab.BestCook
                            elseif tab.Type == "Creature" then 
                                it = it.."|"..tab.MaxSize
                            elseif tab.Type == "Recipe" then 
                                it = it.."|"..tab.Durability 
                            end
                            surface.PlaySound( "garrysmod/ui_return.wav" )
                            RunConsoleCommand( "xdefmod_give", it )
                        end
                    end
                end local cvar = {}
                for k, v in pairs( Typs ) do table.insert( cvar, pan.T_Typs[ v ] == true and 1 or 0 ) end
                for k, v in pairs( pan.T_Rars ) do table.insert( cvar, v == true and 1 or 0 ) end
                table.insert( cvar, pan.T_Dats.PagO )
                RunConsoleCommand( "xdefmod_collection", table.concat( cvar, "" ) )
            end pan:RefreshDatItems()
        elseif typ == 9 then -- 制作
            if IsValid( xdefm.miscs.Menus[ "Craft" ] ) then return end  local MaR = Material( "gui/gradient" )
            local pan = vgui.Create( "DFrame" )  xdefm.miscs.Menus.Craft = pan  pan.T_Data = ply.xdefm_Profile  pan.S_Recipe = "_"
            pan:SetPos( ScrW()/2 -40, ScrH()/2 -550/2 ) pan:SetSize( 600, 550 ) pan:ShowCloseButton( false ) pan:SetAnimationEnabled( false )
            pan:SetVisible( true ) pan:SetScreenLock( true ) pan:SetDraggable( true ) pan:SetTitle( "" ) pan:SetAlpha( 255 ) pan:MakePopup()
            pan:MoveTo( ScrW()/2 -40, ScrH()/2 -500/2, 0.2 )
            function pan:Paint( w, h )
                surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                surface.SetMaterial( Zom ) surface.SetDrawColor( 0, 0, 0, 96 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 0 )
                surface.DrawTexturedRectRotated( w/2, h/2, w, h, 180 )
                surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h, 1 )
                draw.TextShadow( { text = language.GetPhrase( "xdefm.Weapon_Craft" ), pos = { w/2, 25 }, font = "xdefm_Font6",
                xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
            end
            function pan:OnRemove()
                xdefm.miscs.LC = false  local num = 0
                for k, v in pairs( pan.T_Data.Items ) do
                    if v == "_" and k != 21 then num = k break end
                end if num > 0 then xdefm_Command( LocalPlayer(), "MoveCraft", num ) end
            end
            if true then -- 关闭按钮
                pan.P_Close = pan:Add( "DButton" )  local pax = pan.P_Close
                pax:SetText( "" ) pax:SetPos( 560, 8 ) pax:SetSize( 32, 32 )
                pax.B_Hover = false  pax:SetTooltip( "#xdefm.Close" )
                function pax:Paint( w, h ) draw.TextShadow( {
                        text = "×", pos = { w/2, h/2 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER,
                        color = ( pax.B_Hover and Color( 255, 0, 0 ) or Color( 255, 255, 255 ) )
                }, 2, 255 ) end function pax:DoClick() pan:Close() end
                function pax:OnCursorEntered() pax.B_Hover = true end function pax:OnCursorExited() pax.B_Hover = false end end --
            if true then -- 框架
                pan.P_Base = pan:Add( "DPanel" )  local pax = pan.P_Base  pax.N_Type = 0  pan.T_Slots = {}
                pax:SetPos( 8, 50 ) pax:SetSize( 582, 490 ) function pax:Paint( w, h ) end pax.N_Type = typ
                function pax:Paint( w, h ) local rec, slo, dur, yes, col = "xdefm.NeedRecipe", pan.T_Slots[ 1 ], 0, false, Color( 200, 200, 200 )
                    local pro, dum = 0, 0
                    if isstring( pan.T_Slots[ 1 ].S_Item ) and pan.T_Slots[ 1 ].S_Item != "_" then
                        local aa, bb = xdefm_ItemGet( pan.T_Slots[ 1 ].S_Item )
                        if istable( aa ) and istable( bb ) and bb.Type == "Recipe" then
                            rec = bb.Name  dur = aa[ 2 ]  yes = true  col = xdefm.miscs.Rarity[ bb.Rarity +1 ]
                            dum = bb.Durability  pro = #bb.Crafts
                        end
                    end
                    surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, 80 )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, 80, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, 80 )
                    draw.TextShadow( { text = language.GetPhrase( rec ), pos = { 80, 20 }, font = "xdefm_Font1",
                    xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = col }, 1, 255 )
                    if yes and dur and dum then draw.TextShadow( { text = language.GetPhrase( "xdefm.Durability" )..": "..dur.." / "..dum,
                        pos = { 80, 40 }, font = "xdefm_Font2", xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = xdefm.ext_col }, 1, 255 )
                        draw.TextShadow( { text = language.GetPhrase( "xdefm.Product" )..": "..pro,
                        pos = { 80, 60 }, font = "xdefm_Font2", xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = xdefm.ext_col }, 1, 255 )
                    end
                end
                local res = xdefm_SlotBox( 8, 8, 64, 64, 1, "#xdefm.Recipe", nil ) pax:Add( res ) res.S_Type = "Recipe"  pan.P_Slot = res
                function res:DoRightClick( Pnl ) if res.T_Item == nil or res:IsDragging() or !IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then return end
                    if IsValid( pan.P_DMenu ) then pan.P_DMenu:Remove() end pan.P_DMenu = DermaMenu( false, nil )  local dnm = pan.P_DMenu
                    local O_Take = dnm:AddOption( "#xdefm.Take", function() if !res.B_OnMove and IsValid( xdefm.miscs.Menus[ "Inventory" ] ) then
                    local num = 0  for k, v in pairs( LocalPlayer().xdefm_Profile.Items ) do
                        if isstring( v ) and v == "_" and k != 21 then num = k break end
                    end if num > 0 then xdefm_Command( LocalPlayer(), "MoveCraft", num )
                    else xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 ) end end end )
                    O_Take:SetIcon( "icon16/basket_put.png" ) dnm:Open()
                end
                local bck = pax:Add( "DPanel" ) bck:SetSize( 582, 404 ) bck:SetPos( 1, 85 )
                pax.P_Scroll = pax:Add( "DScrollPanel" )
                pax.P_Scroll:SetSize( 582, 394 ) pax.P_Scroll:SetPos( 1, 89 )
                local vba = pax.P_Scroll:GetVBar()  vba:SetHideButtons( true )  vba:SetSize( 0, 0 )
                function vba.btnGrip:Paint( w, h ) end  function vba:Paint( w, h ) end
                function pax.P_Scroll:Paint( w, h ) end
                function bck:Paint( w, h )
                    surface.SetDrawColor( xdefm.bck_col ) surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( xdefm.ext_col ) surface.DrawOutlinedRect( 0, 0, w, h, 2 )
                    surface.SetDrawColor( xdefm.lin_col ) surface.DrawOutlinedRect( 0, 0, w, h )
                end  pan.T_Slots[ 1 ] = res
                pax.P_Hold = pax.P_Scroll:Add( "DIconLayout" )  local pa2 = pax.P_Hold  pa2:SetSize( 582, 1000 )
                pa2:SetSpaceX( 1 ) pa2:SetSpaceY( 0 ) function pa2:Paint( w, h ) end
                function pax:OnCursorEntered() self.B_Hover = true end function pax:OnCursorExited() self.B_Hover = false end
                pax.P_Hold.N_Num = 0
            end
            function pan:XDEFM_Update( id, dt )
                if id == 0 then pan.T_Data = dt end if id != 9 then return end
                pan.P_Slot:F_SetupItem( dt[ 1 ] )  pan.S_Recipe = dt[ 1 ]  local pax = pan.P_Base
                pax.P_Hold:Clear()  local aa, bb = xdefm_ItemGet( dt[ 1 ] )
                if !istable( bb ) or bb.Type != "Recipe" or #bb.Crafts <= 0
                then xdefm.miscs.Craft = nil  xdefm.miscs.Marker = nil return end pax.P_Hold.N_Num = 0
                local function xdefm_AddCraft( tab ) pax.P_Hold.N_Num = pax.P_Hold.N_Num +1
                    local cc = string.Explode( "&", tab ) if !istable( cc ) or #cc < 2 then return end
                    local slo = vgui.Create( "DButton", pax.P_Hold ) slo:SetSize( 50, 80 ) slo:Dock( TOP ) slo:SetText( "" ) slo:SetCursor( "blank" )
                    local aa, bb = xdefm_ItemGet( cc[ #cc ] ) if !istable( aa ) or !istable( bb ) then slo:Remove() return end
                    local col = xdefm.miscs.Rarity[ bb.Rarity +1 ]  local icc = xdefm.miscs.Icons[ bb.Type ]  slo.S_Item = cc[ #cc ]
                    slo.B_Hover = false  slo.N_Num = pax.P_Hold.N_Num  slo.N_Clk = 0  slo.N_Lerp = 0 if icc != nil then
                        pax.P_Sprite = vgui.Create( "DPanel", slo ) local spr = pax.P_Sprite  
                        spr:SetPos( 79, 23 ) spr:SetSize( 16, 16 ) spr:SetMouseInputEnabled( false )
                        function spr:Paint( w, h ) surface.SetMaterial( icc )
                            surface.SetDrawColor( Color( 255, 255, 255, 255 ) ) surface.DrawTexturedRect( 0, 0, w, h )
                        end end slo.T_Craft = cc function slo:Paint( w, h )
                        local coc = ( slo.B_Hover and 0.4 or 0.2 ) local co2 = Color( col.r*coc, col.g*coc, col.b*coc )
                        slo.N_Lerp = Lerp( 0.1, slo.N_Lerp, ( slo.N_Clk <= CurTime() and slo.B_Hover ) and 0 or 1 )
                        local co3 = Color( col.r*coc*2, col.g*coc*2, col.b*coc*2, 55 +slo.N_Lerp*100 ) draw.RoundedBox( 0, 2 +3, 2, w -1 -8, h -2, co2 )
                        surface.SetDrawColor( co3 ) surface.SetMaterial( MaR ) surface.DrawTexturedRect( 2 +5, 2, w -5 -8, h -2 -2 )
                        surface.SetDrawColor( xdefm.ext_col )  surface.DrawOutlinedRect( 2 +3, 2, w -1 -8, h -2, 2 )
                        surface.SetDrawColor( xdefm.lin_col )  surface.DrawOutlinedRect( 2 +3, 2, w -1 -8, h -2 )
                        draw.TextShadow( { text = bb.Name, pos = { 102, 30 }, font = "xdefm_Font5",
                        xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = col }, 1, 255 )
                        draw.TextShadow( { text = language.GetPhrase( "xdefm.Materials" )..": "..tostring( #cc -1 ),
                        pos = { 80, 60 }, font = "xdefm_Font1", xalign = TEXT_ALIGN_LEFT, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
                        draw.TextShadow( { text = "#"..slo.N_Num,
                        pos = { 540, 40 }, font = "xdefm_Font4", xalign = TEXT_ALIGN_RIGHT, yalign = TEXT_ALIGN_CENTER, color = Color( 200, 200, 200 ) }, 1, 255 ) end
                    function slo:OnCursorEntered() slo.B_Hover = true  xdefm.miscs.Craft = cc  pan.P_Select = slo  xdefm.miscs.AimPan = slo
                    xdefm.miscs.Ings = {}  xdefm.miscs.Ing2 = {}  xdefm.miscs.Marker = slo.S_Item  xdefm.miscs.LC = true end
                    function slo:OnCursorExited() slo.B_Hover = false  if xdefm.miscs.AimPan == slo then xdefm.miscs.AimPan = nil end
                    if pan.P_Select == slo then xdefm.miscs.Marker = nil
                    pan.P_Select = nil  xdefm.miscs.Marker = nil end end
                    function slo:DoClick() if slo.N_Clk > CurTime() then return end slo.N_Clk = CurTime() +0.25
                    xdefm_Command( LocalPlayer(), "Craft", tostring( slo.N_Num ) ) end
                    local ico = xdefm_SlotBox( 13, 11, 60, 60, 1 ) slo:Add( ico ) ico:F_SetupItem( cc[ #cc ] )
                    ico.P_Txt:Remove() ico:SetMouseInputEnabled( false )
                end for k, v in pairs( bb.Crafts ) do xdefm_AddCraft( v ) end
            end pan:XDEFM_Update( 9, tab )
        end
    end
end
