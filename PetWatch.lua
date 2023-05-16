--[[
Copyright © 2022, TakeItCheesy
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of EasyNuke nor the
names of its contributors may be used to endorse or promote products
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Nyarlko, or it's members, BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'PetWatch'
_addon.author = 'TakeItCheesy'
_addon.version = '0.1.0'
_addon.command = 'pw'
_addon.commands = {'reset'}

config = require ('config')
texts  = require('texts')
packets = require('packets')
require('tables')
require('sets')

function init()
	PetName = nil
	PetIndex = nil
	CurrentHP = 0
	MaxHP = 0
	CurrentMP = 0
	MaxMP = 0
	HPP = 0
	MPP = 0
	TP = 0
	PetActive = false

	Defaults = T{	
	pos = { 
		x = windower.get_windower_settings().x_res*2/3
		y = windower.get_windower_settings().y_res-20
	},
	padding = 5,
	text = { size=12, font='Impact' }
	}	
	
	Settings = config.load('data\\settings.xml', Defaults)	
	
	PetWatch = texts.new()
	PetWatch:bg_alpha(150)	
	PetWatch:font(Settings.text.font)
	PetWatch:size(Settings.text.size)
	PetWatch:pos(Settings.pos.x, Settings.pos.y)
	PetWatch:pad(Settings.padding)
end

function show()
	PetActive = true
    PetWatch:show()
end

function hide()
	PetActive = false
	PetName = nil
	PetIndex = nil
	CurrentHP = 0
	MaxHP = 0
	CurrentMP = 0
	MaxMP = 0
	HPP = 0
	MPP = 0
	TP = 0
    PetWatch:hide()
end

function update()
	if not S{9, 14, 15, 18, 21}:contains(windower.ffxi.get_player()['main_job_id']) then 
		hide()
		return 
	end
	
	local pet = windower.ffxi.get_mob_by_target('pet') or nil
	
	if pet then
		PetActive = true
		PetName = pet.name
		PetIndex = pet.index
		HPP = pet.hpp
		MPP = pet.mpp
		TP = pet.tp		
	end
	
	    -- if HPP > 74 then
            -- color = {128, 255, 0}
			-- flavor = 'feelin good (^_^)'
        -- elseif HPP > 49 then
            -- color = {255, 255, 0}
			-- flavor = 'taking hits (._.)'
        -- elseif HPP > 24 then
            -- color = {255, 150, 0}
			-- flavor = 'halp! (@_@)'
        -- elseif HPP > 0 then
            -- color = {255, 0, 0}
			-- flavor = 'healz plx! (>.<)'
		-- else
			-- color = {150, 0, 0}
			-- flavor = 'ded! (x.x)'
        -- end
end

handle_commands = function(...)
	local args = T{...}		
    if args ~= nil then
        local cmd = table.remove(args,1):lower()
		if cmd == 'reset' then
			
		end
		if cmd == 'pos' then
		
		end
	end
end

windower.register_event('addon command', handle_commands)

windower.register_event('load', init)

windower.register_event('unload', hide)

windower.register_event('logout', hide)

windower.register_event('job change', hide)

windower.register_event('prerender', function()

end)