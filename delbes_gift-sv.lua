ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('goldengaming:verificarrecebeu', function (source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchScalar('SELECT recebeu_prenda_natal FROM users WHERE identifier=@identifier', {
		['@identifier']   = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

RegisterServerEvent('goldengaming:receberprenda')
AddEventHandler('goldengaming:receberprenda', function (matricularecebida)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchScalar('SELECT recebeu_prenda_natal FROM users WHERE identifier=@identifier', {
		['@identifier']   = xPlayer.identifier
	}, function(resultadorecebeu)
		if resultadorecebeu == 0 then
			local matriculazinha = matricularecebida

			MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = matriculazinha}, 
			function (result)
				if result[1] == nil then
					MySQL.Async.execute('INSERT INTO owned_vehicles (owner, state, plate, vehicle, x, y, z, h) VALUES (@owner, @state, @plate, @vehicle, -63.625, -1101.770, 25.692, 69.059)',
						{
							['@owner']   = xPlayer.identifier,
							['@state']   = 1,
							['@plate']   = matriculazinha,
							['@vehicle'] = '{"modTank":-1,"windowTint":-1,"modSpoilers":-1,"modShifterLeavers":-1,"modRoof":-1,"modBackWheels":-1,"modWindows":-1,"modSuspension":-1,"modArmor":-1,"modSeats":-1,"dirtLevel":9.0000133514404,"color2":0,"modHood":-1,"plateIndex":0,"modVanityPlate":-1,"modOrnaments":-1,"pearlescentColor":2,"extras":[],"wheels":6,"modTrimA":-1,"neonEnabled":[false,false,false,false],"modEngineBlock":-1,"modXenon":false,"modTransmission":-1,"modHydrolic":-1,"modDial":-1,"modFrontBumper":-1,"modAerials":-1,"modExhaust":-1,"modRearBumper":-1,"modFrontWheels":-1,"modFender":-1,"plate":"'.. matriculazinha ..'","modTrunk":-1,"modTrimB":-1,"modLivery":-1,"tyreSmokeColor":[255,255,255],"modEngine":-1,"modFrame":-1,"model":-1842748181,"modBrakes":-1,"modAPlate":-1,"health":1000,"modDashboard":-1,"modSmokeEnabled":false,"modArchCover":-1,"modSideSkirt":-1,"color1":42,"wheelColor":1,"modTurbo":false,"neonColor":[255,0,255],"modStruts":-1,"modSpeakers":-1,"modAirFilter":-1,"modDoorSpeaker":-1,"modRightFender":-1,"modPlateHolder":-1,"modSteeringWheel":-1,"modHorns":-1,"modGrille":-1}'
						}
					)
					MySQL.Sync.execute("UPDATE users SET recebeu_prenda_natal=1 WHERE identifier=@identifier", 
						{
							['@identifier']   = xPlayer.identifier,
						}
					)
				end
			end)
		end
	end)

end)


-------------------------------------------
-------------------------------------------
--BELOW IS THE CODE TO GENERATE THE PLATE--
---------CREDITS TO ESX_VEHICLESHOP--------
-------------------------------------------

ESX.RegisterServerCallback('esx_vehicleshop_delbes:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)