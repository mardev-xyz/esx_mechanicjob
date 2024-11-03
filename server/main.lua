local PlayersHarvesting, PlayersHarvesting2, PlayersHarvesting3, PlayersCrafting, PlayersCrafting2, PlayersCrafting3  = {}, {}, {}, {}, {}, {}

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'mechanic', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'mechanic', TranslateCap('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'private'})

local function Harvest(source)
	SetTimeout(4000, function()

		if PlayersHarvesting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

			if GazBottleQuantity >= 5 then
				TriggerClientEvent('esx:showNotification', source, TranslateCap('you_do_not_room'))
                return
            end
 
            xPlayer.addInventoryItem('gazbottle', 1)
            Harvest(source)
		end

	end)
end

RegisterNetEvent('esx_mechanicjob:startHarvest', function()
	local source = source
	PlayersHarvesting[source] = true
	TriggerClientEvent('esx:showNotification', source, TranslateCap('recovery_gas_can'))
	Harvest(source)
end)

RegisterNetEvent('esx_mechanicjob:stopHarvest', function()
	local source = source
	PlayersHarvesting[source] = false
end)

local function Harvest2(source)
	SetTimeout(4000, function()

		if PlayersHarvesting2[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local FixToolQuantity = xPlayer.getInventoryItem('fixtool').count

			if FixToolQuantity >= 5 then
				TriggerClientEvent('esx:showNotification', source, TranslateCap('you_do_not_room'))
                return
            end
 
            xPlayer.addInventoryItem('fixtool', 1)
            Harvest2(source)
		end

	end)
end

RegisterNetEvent('esx_mechanicjob:startHarvest2', function()
	local source = source
	PlayersHarvesting2[source] = true
	TriggerClientEvent('esx:showNotification', source, TranslateCap('recovery_repair_tools'))
	Harvest2(source)
end)

RegisterNetEvent('esx_mechanicjob:stopHarvest2', function()
	local source = source
	PlayersHarvesting2[source] = false
end)

local function Harvest3(source)
	SetTimeout(4000, function()

		if PlayersHarvesting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local CaroToolQuantity = xPlayer.getInventoryItem('carotool').count
			if CaroToolQuantity >= 5 then
				TriggerClientEvent('esx:showNotification', source, TranslateCap('you_do_not_room'))
                return
            end
 
            xPlayer.addInventoryItem('carotool', 1)
            Harvest3(source)
		end

	end)
end

RegisterNetEvent('esx_mechanicjob:startHarvest3', function()
	local source = source
	PlayersHarvesting3[source] = true
	TriggerClientEvent('esx:showNotification', source, TranslateCap('recovery_body_tools'))
	Harvest3(source)
end)

RegisterNetEvent('esx_mechanicjob:stopHarvest3', function()
	local source = source
	PlayersHarvesting3[source] = false
end)

local function Craft(source)
	SetTimeout(4000, function()

		if PlayersCrafting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

			if GazBottleQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, TranslateCap('not_enough_gas_can'))
                return
            end

            xPlayer.removeInventoryItem('gazbottle', 1)
            xPlayer.addInventoryItem('blowpipe', 1)
            Craft(source)
		end

	end)
end

RegisterNetEvent('esx_mechanicjob:startCraft', function()
	local source = source
	PlayersCrafting[source] = true
	TriggerClientEvent('esx:showNotification', source, TranslateCap('assembling_blowtorch'))
	Craft(source)
end)

RegisterServerEvent('esx_mechanicjob:stopCraft')
AddEventHandler('esx_mechanicjob:stopCraft', function()
	local source = source
	PlayersCrafting[source] = false
end)

local function Craft2(source)
	SetTimeout(4000, function()

		if PlayersCrafting2[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local FixToolQuantity = xPlayer.getInventoryItem('fixtool').count

			if FixToolQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, TranslateCap('not_enough_repair_tools'))
                return
            end
            
            xPlayer.removeInventoryItem('fixtool', 1)
            xPlayer.addInventoryItem('fixkit', 1)
            Craft2(source)
		end

	end)
end

RegisterServerEvent('esx_mechanicjob:startCraft2')
AddEventHandler('esx_mechanicjob:startCraft2', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'mechanic' then
		print(('[^3WARNING^7] Player ^1%s^7 is cheating (tried to trigger `esx_mechanicjob:startCraft2`)'):format(source))
		return
	end

	PlayersCrafting2[source] = true
	TriggerClientEvent('esx:showNotification', source, TranslateCap('assembling_repair_kit'))
	Craft2(source)
end)

RegisterServerEvent('esx_mechanicjob:stopCraft2')
AddEventHandler('esx_mechanicjob:stopCraft2', function()
	local source = source
	PlayersCrafting2[source] = false
end)

local function Craft3(source)
	SetTimeout(4000, function()
		if PlayersCrafting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local CaroToolQuantity = xPlayer.getInventoryItem('carotool').count

			if CaroToolQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, TranslateCap('not_enough_body_tools'))
                return
            end
            
            xPlayer.removeInventoryItem('carotool', 1)
            xPlayer.addInventoryItem('carokit', 1)
            Craft3(source)
		end
	end)
end

RegisterNetEvent('esx_mechanicjob:startCraft3', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'mechanic' then
		print(('[^3WARNING^7] Player ^1%s^7 is cheating (tried to trigger `esx_mechanicjob:startCraft3`)'):format(source))
		return
	end
	
	PlayersCrafting3[source] = true
	TriggerClientEvent('esx:showNotification', source, TranslateCap('assembling_body_kit'))
	Craft3(source)
end)

RegisterServerEvent('esx_mechanicjob:stopCraft3')
AddEventHandler('esx_mechanicjob:stopCraft3', function()
	local source = source
	PlayersCrafting3[source] = false
end)

RegisterNetEvent('esx_mechanicjob:onNPCJobMissionCompleted', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

	if xPlayer.job.name ~= 'mechanic' then
		print(('[^3WARNING^7] Player ^1%s^7 is cheating (tried to trigger `esx_mechanicjob:onNPCJobMissionCompleted`)'):format(source))
		return
	end

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(total)
	end)

	TriggerClientEvent("esx:showNotification", source, TranslateCap('your_comp_earned').. total)
end)

ESX.RegisterUsableItem('blowpipe', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('blowpipe', 1)

	TriggerClientEvent('esx_mechanicjob:onHijack', source)
	TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_blowtorch'))
end)

ESX.RegisterUsableItem('fixkit', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fixkit', 1)

	TriggerClientEvent('esx_mechanicjob:onFixkit', source)
	TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_repair_kit'))
end)

ESX.RegisterUsableItem('carokit', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('carokit', 1)

	TriggerClientEvent('esx_mechanicjob:onCarokit', source)
	TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_body_kit'))
end)

RegisterNetEvent('esx_mechanicjob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.job.name ~= 'mechanic' then
		print(('[^3WARNING^7] Player ^1%s^7 is cheating (tried to trigger `esx_mechanicjob:getStockItem`)'):format(source))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		local item = inventory.getItem(itemName)

        if count < 0 and item.count <= count then
            xPlayer.showNotification(TranslateCap('invalid_quantity'))
            return
        end

        if not xPlayer.canCarryItem(itemName, count) then
            xPlayer.showNotification(TranslateCap('player_cannot_hold'))
            return
        end

        inventory.removeItem(itemName, count)
        xPlayer.addInventoryItem(itemName, count)
        xPlayer.showNotification(TranslateCap('have_withdrawn', count, item.label))
	end)
end)

ESX.RegisterServerCallback('esx_mechanicjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('esx_mechanicjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'mechanic' then
		print(('[^3WARNING^7] Player ^1%s^7 is cheating (tried to trigger `esx_mechanicjob:putStockItems`)'):format(source))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count
        
        if item.count <= 0 and count >= playerItemCount then
            xPlayer.showNotification(TranslateCap('invalid_quantity'))
            return
        end
        
        xPlayer.removeInventoryItem(itemName, count)
        inventory.addItem(itemName, count)

		xPlayer.showNotification(TranslateCap('have_deposited', count, item.label))
	end)
end)

ESX.RegisterServerCallback('esx_mechanicjob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)
