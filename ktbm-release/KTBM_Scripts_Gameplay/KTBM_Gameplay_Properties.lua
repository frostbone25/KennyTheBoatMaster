--[[
    This script is here to store the main gameplay properties used by all of the gameplay scripts.
    In here these parameters can be tweaked to adjust values within the game and how it works.
]]--

--Explanation of why this variable exists is below...
--This will offset the entire game world upwards or downwards depending on the value (visually, this will have no impact on the game)
KTBM_Gameplay_EnvironmentHeightOffset = 0;

--[[
    So this was implemented to mostly get around a bug that I couldn't unfortunately find a good fix for...
    When spawning "props" that already have animations on them (i.e. the zombies that spawn in the game)
    Animations they have forces them to be at world origin, and you cannot change this, not instantly anyway.

    1. I have tried to set a predefined position and rotation when spawning them, but that doesn't work.
    2. I have tried to hide the agent right after spawning them but you can still see them appear on the frame that they spawn
    3. I have tried to kill the animations/controllers on the agent right after spawning them but that doesn't work.
    4. I have also tried to get the prop file and hide the runtime visiblity before feeding it into AgentCreate and spawning it, doesn't work.

    So unfortunately, the only fix that I could think of to get around it...
    was to simply hide it so you don't ever see the frame in which the zombie spawns into the scene.

    So... how do you hide agents, that upon spawning them in have animations on them, and also are forcibly set to world origin?
    The answer I came up with was to shift the world origin upwards so that you never see the frame in which zombies are spawned in.
    The downside is that I need to add this offset to every position calculations I do throughout the project...
    Which if you've already looked through it, that is why you see that appear alot.
]]

--||||||||||||||||||||||||||||||| ENVIORMENT SCROLLING PROPERTIES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| ENVIORMENT SCROLLING PROPERTIES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| ENVIORMENT SCROLLING PROPERTIES |||||||||||||||||||||||||||||||
--These properties are responsible for handling the enviorment scrolling

--The speed at which the world will scroll.
--This controls the speed for EVERYTHING in the world.
--(Lower Value = Slower | Higher Value = Faster)
KTBM_Gameplay_DefaultEnvironmentMovementSpeed = 25;

KTBM_Gameplay_EnvironmentMovementSpeed = KTBM_Gameplay_DefaultEnvironmentMovementSpeed;

--(Lower Value = Closer | Higher Value = Farther)
KTBM_Gameplay_EnvironmentHorizontalBoundarySize = 275;

KTBM_Gameplay_EnvironmentDistanceSpawn = 850;

KTBM_Gameplay_EnvironmentMinimumDistance = -450;

KTBM_Gameplay_EnvironmentSpawnHeight = -2.5;

--||||||||||||||||||||||||||||||| PLAYER BOAT PROPERTIES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| PLAYER BOAT PROPERTIES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| PLAYER BOAT PROPERTIES |||||||||||||||||||||||||||||||
--These properties are responsible for handling the player boat.

--Controls how far from side to side the player can move the boat
--(Lower Value = Smaller | Higher Value = Bigger)
KTBM_Gameplay_BoatHorizontalBoundarySize = 25;

--Controls the speed at which the boat can move from side to side.
--(Lower Value = Slower | Higher Value = Faster)
KTBM_Gameplay_BoatMovementSpeed = 20;

--Controls the angle at which the boat will take when moving from side to side
--(Less than 0 = Max Angle In Opposite Direction | 0 = Straight | More than 0 = Max Angle)
KTBM_Gameplay_BoatMaxRotationAngle = 25;

--||||||||||||||||||||||||||||||| ROCK SPAWNING PROPERTIES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| ROCK SPAWNING PROPERTIES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| ROCK SPAWNING PROPERTIES |||||||||||||||||||||||||||||||
--These properties are responsible for handling the procedual spawning properties of the rocks.

--Controls how far out from side to side can we spawn the rocks
--(Lower Value = Smaller | Higher Value = Bigger)
KTBM_Gameplay_RocksHorizontalBoundarySize = 25;

--Controls the interval rate of when rocks are spawned
--(Lower Value = Faster | Higher Value = Slower)
KTBM_Gameplay_RocksSpawnInterval = 0.5;

--Controls the distance at which the rocks are spawned from the player
--(Lower Value = Closer To Camera | Higher Value = Farther From Camera)
KTBM_Gameplay_RocksStartingDistance = 250;

--Controls the distance at which the rocks are destroyed/removed 
--(Lower Value = Closer To Camera | Higher Value = Farther From Camera)
KTBM_Gameplay_RocksMinimumDistance = -20;

--These properties arent critical and mostly serve a visual purpose.
--As rocks are spawned in they will slowly rise from below the water to the surface as a way to natrually spawn in objects
--(As opposed to just popping them magically in the distance)

--Controls the height at which the rocks spawn at.
--(Lower Value = Closer To Camera | Higher Value = Farther From Camera)
KTBM_Gameplay_RocksStartingHeight = -10;

--Controls the speed at which the rocks will rise to
--(Lower Value = Slower | Higher Value = Faster)
KTBM_Gameplay_RocksHeightRiseSpeed = 15;

--||||||||||||||||||||||||||||||| ZOMBIE SPAWNING PROPERTIES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| ZOMBIE SPAWNING PROPERTIES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| ZOMBIE SPAWNING PROPERTIES |||||||||||||||||||||||||||||||
--These properties are responsible for handling the procedual spawning properties of the zombies.

--Controls how far out from side to side can we spawn the zombies
--(Lower Value = Smaller | Higher Value = Bigger)
KTBM_Gameplay_ZombiesHorizontalBoundarySize = 25;

--Controls the interval rate of when zombies are spawned
--(Lower Value = Faster | Higher Value = Slower)
KTBM_Gameplay_ZombiesSpawnInterval = 0.5;

--Controls the distance at which the zombies are spawned from the player
--(Lower Value = Closer To Camera | Higher Value = Farther From Camera)
KTBM_Gameplay_ZombiesStartingDistance = 250;

--Controls the distance at which the zombies are destroyed/removed 
--(Lower Value = Closer To Camera | Higher Value = Farther From Camera)
KTBM_Gameplay_ZombiesMinimumDistance = -20;

--These properties arent critical and mostly serve a visual purpose.
--As zombies are spawned in they will slowly rise from below the water to the surface as a way to natrually spawn in objects
--(As opposed to just popping them magically in the distance)

--Controls the height at which the zombies spawn at.
--(Lower Value = Closer To Camera | Higher Value = Farther From Camera)
KTBM_Gameplay_ZombiesStartingHeight = -10;

--Controls the speed at which the zombies will rise to
--(Lower Value = Slower | Higher Value = Faster)
KTBM_Gameplay_ZombiesHeightRiseSpeed = 15;

--||||||||||||||||||||||||||||||| GAMEPLAY STATES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| GAMEPLAY STATES |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| GAMEPLAY STATES |||||||||||||||||||||||||||||||
--THESE VARIABLES SHOULD NOT BE TOUCHED as these are changed in-game to reflect what is currently happening in the game

--Has the player crashed into a rock yet?
KTBM_Gameplay_State_HasCrashed = false;

--Has the player paused the game?
KTBM_Gameplay_State_Paused = false;

--||||||||||||||||||||||||||||||| GAMEPLAY STATISTICS TRACKING |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| GAMEPLAY STATISTICS TRACKING |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| GAMEPLAY STATISTICS TRACKING |||||||||||||||||||||||||||||||
--THESE VARIABLES SHOULD NOT BE TOUCHED as these are changed in-game to reflect what is currently happening in the game

--How many zombies has the player killed?
KTBM_Gameplay_Stats_ZombiesKilled = 0;

--How far has the player traveled before crashing?
KTBM_Gameplay_Stats_DistanceTraveled = 0;

--The game time when the game starts
KTBM_Gameplay_Stats_StartTime = 0;

--The game time when the game ends
KTBM_Gameplay_Stats_EndTime = 0;

--The total time of the run.
--This is calculated simply with (KTBM_Gameplay_Stats_EndTime - KTBM_Gameplay_Stats_EndTime)
KTBM_Gameplay_Stats_TotalTime = 0;