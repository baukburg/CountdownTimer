display.setDefault("background", 0.0, 0.0, 0.0 )
system.setIdleTimer( false )

local soundEffect = audio.loadSound( "ticktock.mp3" )
audio.setVolume( 1.0 )

-- Keep track of time in seconds
local secondsLeft = 90 * 60   -- 20 minutes * 60 seconds

local clockText = display.newText("90:00", display.contentCenterX, display.contentCenterY, native.systemFontBold, 500)
clockText:setFillColor( 1, 0.3, 0.3 )

local function updateTime()
	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- time is tracked in seconds.  We need to convert it to minutes and seconds
	local minutes = math.floor( secondsLeft / 60 )
	local seconds = secondsLeft % 60

	if (minutes > 0) and ((minutes % 10) == 0) then
		if (seconds == 0) then
			audio.play( soundEffect, { loops = 3 } )
		end
	end

	if (minutes == 0) and (seconds <= 0) then
		local soundEffect = audio.loadSound( "ring.mp3" )
		audio.play (soundEffect, { loops = 9 })
		system.setIdleTimer( true )
	end

	-- make it a string using string format.
	local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
	if (((minutes + 1) % 10) == 0) and (seconds >= 48) then
		if seconds % 2 == 0 then
			display.setDefault("background", 0,0,0)
		else
			display.setDefault("background", 1,1,1)
		end
	end

	clockText.text = timeDisplay
end

-- run them timer
local countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
