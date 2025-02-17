--=========================--
-- CODE TAKEN FROM M.O.RE. --
--     by  Undeadsewer     --
--=========================--

Hooks:PostHook( BlackMarketGui , "update_info_text" , "RWN_BlackMarketGuiPostUpdateInfoText" , function( self )
	
	local tab_data = self._tabs[ self._selected ]._data
	local identifier = tab_data.identifier
	
	local is_renaming_this = self._renaming_item and not self._data.is_loadout and self._renaming_item.category == self._slot_data.category and self._renaming_item.slot == self._slot_data.slot
	
	if identifier == self.identifiers.melee_weapon and not is_renaming_this then
		self._info_texts[ 2 ]:set_visible( false )
		
		self._info_texts[ 3 ]:set_y( self._info_texts[ 2 ]:y() )
		self._info_texts[ 4 ]:set_y( self._info_texts[ 3 ]:bottom() )
		self._info_texts[ 5 ]:set_y( self._info_texts[ 4 ]:bottom() )
		
		for _ , desc_mini_icon in ipairs( self._desc_mini_icons ) do
			desc_mini_icon[ 1 ]:set_y(self._info_texts[ 1 ] :bottom() )
			desc_mini_icon[ 1 ]:set_world_top( self._info_texts[ desc_mini_icon[ 2 ] ]:world_top() + 1 )
		end
	end
end )

-- Toggle melee weapons description on mouse hover. If the description is too long some strings might be moved on the top
Hooks:PostHook( BlackMarketGui , "mouse_moved" , "RWN_BlackMarketGuiPostMouseMoved" , function( self , o , x , y )

	if not self._selected then return end
	
	local tab_data = self._tabs[ self._selected ]._data
	local identifier = tab_data.identifier
	
	local is_renaming_this = self._renaming_item and not self._data.is_loadout and self._renaming_item.category == self._slot_data.category and self._renaming_item.slot == self._slot_data.slot
	
	if identifier == self.identifiers.melee_weapon and self._weapon_info_panel and self._slot_data and not is_renaming_this then
		if self._weapon_info_panel:inside( x , y ) then
			self._info_texts[ 2 ]:set_visible( true )
			self._info_texts[ 3 ]:set_visible( false )
			self._info_texts[ 4 ]:set_visible( false )
			self._info_texts[ 5 ]:set_visible( false )
			
			for _ , desc_mini_icon in ipairs( self._desc_mini_icons ) do
				desc_mini_icon[ 1 ]:set_visible( false )
			end
		else
			self._info_texts[ 2 ]:set_visible( false )
			self._info_texts[ 3 ]:set_visible( true )
			self._info_texts[ 4 ]:set_visible( true )
			self._info_texts[ 5 ]:set_visible( true )
			
			for _ , desc_mini_icon in ipairs( self._desc_mini_icons ) do
				desc_mini_icon[ 1 ]:set_visible( true )
			end
		end
	end
end )

-- Melee weapons description
Hooks:PostHook( BlackMarketTweakData , "_init_melee_weapons" , "RWN_BlackMarketTweakDataPostInitMeleeWeapons" , function( self , tweak_data )

	for k , v in pairs( self.melee_weapons ) do
		if not v.info_id then
			v.info_id = v.name_id .. "_info"
		end
	end
end )
