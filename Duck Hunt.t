%Intro Screen
%Code Cleanup
%Finish Sounds

var winID : int
winID := Window.Open ("graphics:803;600,offscreenonly")
colorback (black)
cls
var chars : array char of boolean
var font, font2, textcol, n, game_round, respawn, hits, misses, multi_birdDelay, hunter_round_wins, duck_round_wins : int
var mainmenu_exit, closeval, campaign_TF,
    mainmenu_TF, campaign_exit, multiplayer_TF,
    multiplayer_exit, options_TF, options_exit,
    menusystem_exit, playSound, soloPlay, gamePause,
    carnageReport_exit, superSpeed, pauseExit, rumbleOnOff : boolean := false
n := 1
mainmenu_TF := true
textcol := 42
font := Font.New ("ArcadeClassic:25")
font2 := Font.New ("ArcadeClassic:14")
game_round := 1
playSound := true
hits := 0
misses := 0
multi_birdDelay := 75
var shot, shot2 : int := 0
var creditsDuckBlocker : boolean := false
var creditsX, creditsY : int := 0
var carnageSoundBlock : boolean := false

%Variables
var title : int := Pic.FileNew ("Pictures/Duck Hunt Title.bmp")

%Dog Variables
var DOG_LAUGH : array 1 .. 2 of int
DOG_LAUGH (1) := Pic.FileNew ("Pictures/laugh1.bmp")
DOG_LAUGH (2) := Pic.FileNew ("Pictures/laugh2.bmp")

var DOG_INTRO : array 1 .. 4 of int
DOG_INTRO (1) := Pic.FileNew ("Pictures/walk1.bmp")
DOG_INTRO (2) := Pic.FileNew ("Pictures/walk3.bmp")
DOG_INTRO (3) := Pic.FileNew ("Pictures/walk4.bmp")
DOG_INTRO (4) := Pic.FileNew ("Pictures/sniff.bmp")

var DOG_JUMP : array 1 .. 3 of int
DOG_JUMP (1) := Pic.FileNew ("Pictures/jump1.bmp")
DOG_JUMP (2) := Pic.FileNew ("Pictures/jump2.bmp")
DOG_JUMP (3) := Pic.FileNew ("Pictures/jump3.bmp")

var DOG_BIRD : int
DOG_BIRD := Pic.FileNew ("Pictures/1bird.bmp")

%Bird Variables

var BIRD_PIC : array 1 .. 35 of int
BIRD_PIC (33) := Pic.FileNew ("Pictures/shot.bmp")

BIRD_PIC (34) := Pic.FileNew ("Pictures/falling1.bmp")
BIRD_PIC (35) := Pic.FileNew ("Pictures/falling2.bmp")

BIRD_PIC (25) := Pic.FileNew ("Pictures/flying up 1.bmp")
BIRD_PIC (26) := Pic.FileNew ("Pictures/flying up 2.bmp")
BIRD_PIC (27) := Pic.FileNew ("Pictures/flying up 3.bmp")
BIRD_PIC (28) := Pic.FileNew ("Pictures/flying up 2.bmp")

BIRD_PIC (29) := Pic.FileNew ("Pictures/flying down 1.bmp")
BIRD_PIC (30) := Pic.FileNew ("Pictures/flying down 2.bmp")
BIRD_PIC (31) := Pic.FileNew ("Pictures/flying down 3.bmp")
BIRD_PIC (32) := Pic.FileNew ("Pictures/flying down 2.bmp")

BIRD_PIC (17) := Pic.FileNew ("Pictures/flying left 1.bmp")
BIRD_PIC (18) := Pic.FileNew ("Pictures/flying left 2.bmp")
BIRD_PIC (19) := Pic.FileNew ("Pictures/flying left 3.bmp")
BIRD_PIC (20) := Pic.FileNew ("Pictures/flying left 2.bmp")

BIRD_PIC (21) := Pic.FileNew ("Pictures/flying right 1.bmp")
BIRD_PIC (22) := Pic.FileNew ("Pictures/flying right 2.bmp")
BIRD_PIC (23) := Pic.FileNew ("Pictures/flying right 3.bmp")
BIRD_PIC (24) := Pic.FileNew ("Pictures/flying right 2.bmp")

BIRD_PIC (5) := Pic.FileNew ("Pictures/flying downleft 1.bmp")
BIRD_PIC (6) := Pic.FileNew ("Pictures/flying downleft 2.bmp")
BIRD_PIC (7) := Pic.FileNew ("Pictures/flying downleft 3.bmp")
BIRD_PIC (8) := Pic.FileNew ("Pictures/flying downleft 2.bmp")

BIRD_PIC (13) := Pic.FileNew ("Pictures/flying downright 1.bmp")
BIRD_PIC (14) := Pic.FileNew ("Pictures/flying downright 2.bmp")
BIRD_PIC (15) := Pic.FileNew ("Pictures/flying downright 3.bmp")
BIRD_PIC (16) := Pic.FileNew ("Pictures/flying downright 2.bmp")

BIRD_PIC (1) := Pic.FileNew ("Pictures/flying upleft 1.bmp")
BIRD_PIC (2) := Pic.FileNew ("Pictures/flying upleft 2.bmp")
BIRD_PIC (3) := Pic.FileNew ("Pictures/flying upleft 3.bmp")
BIRD_PIC (4) := Pic.FileNew ("Pictures/flying upleft 2.bmp")

BIRD_PIC (9) := Pic.FileNew ("Pictures/flying upright 1.bmp")
BIRD_PIC (10) := Pic.FileNew ("Pictures/flying upright 2.bmp")
BIRD_PIC (11) := Pic.FileNew ("Pictures/flying upright 3.bmp")
BIRD_PIC (12) := Pic.FileNew ("Pictures/flying upright 2.bmp")

var INSTRUCTION_PIC : array 1 .. 10 of int
INSTRUCTION_PIC (1) := Pic.FileNew ("Pictures/arrowleft.bmp")
INSTRUCTION_PIC (2) := Pic.FileNew ("Pictures/arrowright.bmp")
INSTRUCTION_PIC (3) := Pic.FileNew ("Pictures/arrowup.bmp")
INSTRUCTION_PIC (4) := Pic.FileNew ("Pictures/arrowdown.bmp")
INSTRUCTION_PIC (5) := Pic.FileNew ("Pictures/upleft.bmp")
INSTRUCTION_PIC (6) := Pic.FileNew ("Pictures/upright.bmp")
INSTRUCTION_PIC (7) := Pic.FileNew ("Pictures/downleft.bmp")
INSTRUCTION_PIC (8) := Pic.FileNew ("Pictures/downright.bmp")
INSTRUCTION_PIC (9) := Pic.FileNew ("Pictures/button.bmp")
INSTRUCTION_PIC (10) := Pic.FileNew ("Pictures/wii.bmp")

var birdX : int := Rand.Int (-75, 775)
var birdY : int := Rand.Int (225, 575)
var picChoice : int := 1
var button, crossHairX, crossHairY, clr, hunter_points, duck_points : int := 0
var duck_points_str, duck_round_str : string
var hunter_points_str, hunter_round_str : string
var game_round_string : string
var hits_str, misses_str : string
var picDetermin : int := 21
var garbageX, garbageY : int
var boundary : boolean := true
var BACKGROUND : int
var shotCounter : int := 3
var shotCounterString : string
var birdDelay : int
var sequence : int := Rand.Int (1, 3)

const NORMAL_SPEED : int := 75
const BOOST_SPEED : int := 35
var delaySolo : array 1 .. 10 of int
delaySolo (1) := 75
delaySolo (2) := 65
delaySolo (3) := 55
delaySolo (4) := 45
delaySolo (5) := 35
delaySolo (6) := 25
delaySolo (7) := 20
delaySolo (8) := 15
delaySolo (9) := 10
delaySolo (10) := 5

var dogX : int := -200
var soloBirdPicChoice : int := 0
var step : int := 1



BACKGROUND := Pic.FileNew ("Pictures/background.bmp")

procedure dogWalk
    loop
	for i : 1 .. 3
	    cls
	    Pic.Draw (BACKGROUND, 0, 0, picCopy)
	    Pic.Draw (DOG_INTRO (i), dogX, 100, picMerge)
	    View.Update
	    dogX := dogX + 15
	    delay (150)
	end for
	if dogX > 100 then
	    cls
	    exit
	end if
    end loop
    for : 1 .. 2
	for i : 3 .. 4
	    cls
	    Pic.Draw (BACKGROUND, 0, 0, picCopy)
	    Pic.Draw (DOG_INTRO (i), dogX, 100, picMerge)
	    View.Update
	    delay (400)
	end for
    end for
    cls
    Pic.Draw (BACKGROUND, 0, 0, picCopy)
    Pic.Draw (DOG_JUMP (1), dogX, 100, picMerge)
    View.Update
    delay (1000)
    cls
    Pic.Draw (BACKGROUND, 0, 0, picCopy)
    Pic.Draw (DOG_JUMP (2), dogX + 50, 100 + 100, picMerge)
    View.Update
    delay (700)
    cls
    if playSound = true then
	Music.PlayFile ("Sounds/Dog Bark Sound Effect.mp3")
	Music.PlayFileReturn ("Sounds/Dog Bark Sound Effect.mp3")
    end if
    Pic.Draw (BACKGROUND, 0, 0, picCopy)
    Pic.Draw (DOG_JUMP (3), dogX + 100, 100 + 60, picMerge)
    View.Update
    delay (700)
    dogX := -200
end dogWalk


procedure birdChoice
    Input.KeyDown (chars)
    if (chars (KEY_LEFT_ARROW) and chars (KEY_UP_ARROW)) then

	if picDetermin = 1 then
	    picDetermin := 2
	elsif picDetermin = 2 then
	    picDetermin := 3
	elsif picDetermin = 3 then
	    picDetermin := 4
	else
	    picDetermin := 1
	end if
	if birdX <= -75 and not birdY >= 575 then
	    birdY := birdY + 25
	    boundary := false
	elsif birdY >= 575 and not birdX <= -75 then
	    birdX := birdX - 25
	elsif birdX <= -75 and birdY >= 575 then
	    birdX := birdX + 0
	    birdY := birdY + 0
	else
	    birdX := birdX - 25
	    birdY := birdY + 25
	    boundary := true
	end if
	picChoice := picDetermin

    elsif (chars (KEY_LEFT_ARROW) and chars (KEY_DOWN_ARROW)) then

	if picDetermin = 5 then
	    picDetermin := 6
	elsif picDetermin = 6 then
	    picDetermin := 7
	elsif picDetermin = 7 then
	    picDetermin := 8
	else
	    picDetermin := 5
	end if
	if birdX <= -75 and not birdY <= 225 then
	    birdY := birdY - 25
	    boundary := false
	elsif birdY <= 225 and not birdX <= -75 then
	    birdX := birdX - 25
	    boundary := false
	elsif birdY <= 225 and birdX <= -75 then
	    boundary := false
	else
	    birdX := birdX - 25
	    birdY := birdY - 25
	    boundary := true
	end if
	picChoice := picDetermin

    elsif (chars (KEY_RIGHT_ARROW) and chars (KEY_UP_ARROW)) then

	if picDetermin = 9 then
	    picDetermin := 10
	elsif picDetermin = 10 then
	    picDetermin := 11
	elsif picDetermin = 11 then
	    picDetermin := 12
	else
	    picDetermin := 9
	end if
	if birdX >= 775 and not birdY >= 575 then
	    birdY := birdY + 25
	    boundary := false
	elsif birdY >= 575 and not birdX >= 775 then
	    birdX := birdX + 25
	    boundary := false
	elsif birdY >= 575 and birdX >= 775 then
	    boundary := false
	else
	    birdX := birdX + 25
	    birdY := birdY + 25
	    boundary := true
	end if
	picChoice := picDetermin

    elsif (chars (KEY_RIGHT_ARROW) and chars (KEY_DOWN_ARROW)) then

	if picDetermin = 13 then
	    picDetermin := 14
	elsif picDetermin = 14 then
	    picDetermin := 15
	elsif picDetermin = 15 then
	    picDetermin := 16
	else
	    picDetermin := 13
	end if
	if birdX >= 775 and not birdY <= 225 then
	    birdY := birdY - 25
	    boundary := false
	elsif birdY <= 225 and not birdX >= 775 then
	    birdX := birdX + 25
	    boundary := false
	elsif birdY <= 225 and birdX >= 775 then
	    boundary := false
	else
	    birdX := birdX + 25
	    birdY := birdY - 25
	    boundary := true
	end if
	picChoice := picDetermin

    elsif (chars (KEY_LEFT_ARROW) and not chars (KEY_RIGHT_ARROW)) then

	if picDetermin = 17 then
	    picDetermin := 18
	elsif picDetermin = 18 then
	    picDetermin := 19
	elsif picDetermin = 19 then
	    picDetermin := 20
	else
	    picDetermin := 17
	end if
	if birdX <= -75 then
	    birdX := birdX + 0
	    birdY := birdY + 0
	    boundary := false
	else
	    birdX := birdX - 25
	    boundary := true
	end if
	picChoice := picDetermin

    elsif (chars (KEY_RIGHT_ARROW) and not chars (KEY_LEFT_ARROW)) then

	if picDetermin = 21 then
	    picDetermin := 22
	elsif picDetermin = 22 then
	    picDetermin := 23
	elsif picDetermin = 23 then
	    picDetermin := 24
	else
	    picDetermin := 21
	end if
	if birdX >= 775 then
	    birdX := birdX + 0
	    birdY := birdY + 0
	    boundary := false
	else
	    birdX := birdX + 25
	    boundary := true
	end if
	picChoice := picDetermin

    elsif (chars (KEY_UP_ARROW) and not chars (KEY_DOWN_ARROW)) then

	if picDetermin = 25 then
	    picDetermin := 26
	elsif picDetermin = 26 then
	    picDetermin := 27
	elsif picDetermin = 27 then
	    picDetermin := 28
	else
	    picDetermin := 25
	end if
	if birdY >= 575 then
	    birdX := birdX + 0
	    birdY := birdY + 0
	    boundary := false
	else
	    birdY := birdY + 25
	    boundary := true
	end if
	picChoice := picDetermin

    elsif (chars (KEY_DOWN_ARROW) and not chars (KEY_UP_ARROW)) then
	if picDetermin = 29 then
	    picDetermin := 30
	elsif picDetermin = 30 then
	    picDetermin := 31
	elsif picDetermin = 31 then
	    picDetermin := 32
	else
	    picDetermin := 29
	end if
	if birdY <= 225 then
	    birdX := birdX + 0
	    birdY := birdY + 0
	    boundary := false
	else
	    birdY := birdY - 25
	    boundary := true
	end if
	picChoice := picDetermin

    else

	if (picDetermin >= 1 and picDetermin <= 8) or (picDetermin >= 25 and picDetermin <= 28) then
	    picDetermin := 20
	elsif (picDetermin >= 9 and picDetermin <= 15) or (picDetermin >= 31 and picDetermin <= 34) then
	    picDetermin := 24

	elsif picDetermin = 20 or picDetermin = 24 then
	    picDetermin := picDetermin - 3
	else
	    picDetermin := picDetermin + 1
	end if
	picChoice := picDetermin
    end if
end birdChoice


procedure birdSequencePath
    if sequence = 1 then
	if step = 1 then
	    soloBirdPicChoice := 4
	    if birdX = 300 then
		step := 2
	    end if
	elsif step = 2 then
	    soloBirdPicChoice := 6
	    if birdX = 600 then
		step := 3
	    end if
	elsif step = 3 then
	    soloBirdPicChoice := 3
	    if birdX = 900 then
		step := 4
	    end if
	elsif step = 4 then
	    soloBirdPicChoice := 8
	    if birdY = 225 then
		step := 5
	    end if
	elsif step = 5 then
	    soloBirdPicChoice := 1
	    if birdX = 600 then
		step := 6
	    end if
	elsif step = 6 then
	    soloBirdPicChoice := 2
	    if birdX = 350 then
		step := 7
	    end if
	elsif step = 7 then
	    soloBirdPicChoice := 7
	    if birdY = 500 then
		step := 8
	    end if
	elsif step = 8 then
	    soloBirdPicChoice := 2
	    if birdX = 150 then
		step := 9
	    end if
	elsif step = 9 then
	    soloBirdPicChoice := 1
	    if birdX = -100 then
		birdX := -100
		birdY := 700
		step := 1
	    end if
	end if
    elsif sequence = 2 then
	if step = 1 then
	    soloBirdPicChoice := 8
	    if birdY = 350 then
		step := 2
	    end if
	elsif step = 2 then
	    soloBirdPicChoice := 5
	    if birdX = 100 then
		step := 3
	    end if
	elsif step = 3 then
	    soloBirdPicChoice := 2
	    if birdY = 225 then
		step := 4
	    end if
	elsif step = 4 then
	    soloBirdPicChoice := 6
	    if birdX = 350 then
		step := 5
	    end if
	elsif step = 5 then
	    soloBirdPicChoice := 3
	    if birdY = 500 then
		step := 6
	    end if
	elsif step = 6 then
	    soloBirdPicChoice := 4
	    if birdY = 225 then
		step := 7
	    end if
	elsif step = 7 then
	    soloBirdPicChoice := 6
	    if birdX > 900 then
		step := 8
	    end if
	elsif step = 8 then
	    soloBirdPicChoice := 1
	    if birdY = 500 then
		step := 9
	    end if
	elsif step = 9 then
	    soloBirdPicChoice := 2
	    if birdY = 225 then
		step := 10
	    end if
	elsif step = 10 then
	    soloBirdPicChoice := 7
	    if birdY = 700 then
		birdX := 400
		birdY := 700
		step := 1
	    end if
	end if
    elsif sequence = 3 then
	if step = 1 then
	    soloBirdPicChoice := 5
	    if birdX = 500 then
		step := 2
	    end if
	elsif step = 2 then
	    soloBirdPicChoice := 2
	    if birdX = 450 then
		step := 3
	    end if
	elsif step = 3 then
	    soloBirdPicChoice := 5
	    if birdX = 400 then
		step := 4
	    end if
	elsif step = 4 then
	    soloBirdPicChoice := 4
	    if birdX = 450 then
		step := 5
	    end if
	elsif step = 5 then
	    soloBirdPicChoice := 8
	    if birdY = 225 then
		step := 6
	    end if
	elsif step = 6 then
	    soloBirdPicChoice := 6
	    if birdX = 900 then
		birdX := -100
		birdY := 225
		step := 7
	    end if
	elsif step = 7 then
	    soloBirdPicChoice := 6
	    if birdX = 100 then
		step := 8
	    end if
	elsif step = 8 then
	    soloBirdPicChoice := 7
	    if birdY = 400 then
		step := 9
	    end if
	elsif step = 9 then
	    soloBirdPicChoice := 3
	    if birdX = 450 then
		step := 10
	    end if
	elsif step = 10 then
	    soloBirdPicChoice := 5
	    if birdX = 100 then
		step := 11
	    end if
	elsif step = 11 then
	    soloBirdPicChoice := 1
	    if birdX = 50 then
		step := 12
	    end if
	elsif step = 12 then
	    soloBirdPicChoice := 5
	    if birdX = -100 then
		birdX := 400
		birdY := 700
		step := 13
	    end if
	elsif step = 13 then
	    soloBirdPicChoice := 8
	    if birdY = 500 then
		step := 14
	    end if
	elsif step = 14 then
	    soloBirdPicChoice := 3
	    if birdY = 700 then
		birdX := 900
		birdY := 500
		step := 1
	    end if
	end if
    end if
end birdSequencePath



procedure birdChoiceSolo
    birdSequencePath
    if soloBirdPicChoice = 1 then

	if picDetermin = 1 then
	    picDetermin := 2
	elsif picDetermin = 2 then
	    picDetermin := 3
	elsif picDetermin = 3 then
	    picDetermin := 4
	else
	    picDetermin := 1
	end if

	birdX := birdX - 25
	birdY := birdY + 25

	picChoice := picDetermin

    elsif soloBirdPicChoice = 2 then

	if picDetermin = 5 then
	    picDetermin := 6
	elsif picDetermin = 6 then
	    picDetermin := 7
	elsif picDetermin = 7 then
	    picDetermin := 8
	else
	    picDetermin := 5
	end if
	birdX := birdX - 25
	birdY := birdY - 25

	picChoice := picDetermin

    elsif soloBirdPicChoice = 3 then

	if picDetermin = 9 then
	    picDetermin := 10
	elsif picDetermin = 10 then
	    picDetermin := 11
	elsif picDetermin = 11 then
	    picDetermin := 12
	else
	    picDetermin := 9
	end if
	birdX := birdX + 25
	birdY := birdY + 25
	picChoice := picDetermin

    elsif soloBirdPicChoice = 4 then

	if picDetermin = 13 then
	    picDetermin := 14
	elsif picDetermin = 14 then
	    picDetermin := 15
	elsif picDetermin = 15 then
	    picDetermin := 16
	else
	    picDetermin := 13
	end if

	birdX := birdX + 25
	birdY := birdY - 25
	boundary := true
	picChoice := picDetermin

    elsif soloBirdPicChoice = 5 then

	if picDetermin = 17 then
	    picDetermin := 18
	elsif picDetermin = 18 then
	    picDetermin := 19
	elsif picDetermin = 19 then
	    picDetermin := 20
	else
	    picDetermin := 17
	end if
	birdX := birdX - 25

	picChoice := picDetermin

    elsif soloBirdPicChoice = 6 then

	if picDetermin = 21 then
	    picDetermin := 22
	elsif picDetermin = 22 then
	    picDetermin := 23
	elsif picDetermin = 23 then
	    picDetermin := 24
	else
	    picDetermin := 21
	end if
	birdX := birdX + 25

	picChoice := picDetermin

    elsif soloBirdPicChoice = 7 then

	if picDetermin = 25 then
	    picDetermin := 26
	elsif picDetermin = 26 then
	    picDetermin := 27
	elsif picDetermin = 27 then
	    picDetermin := 28
	else
	    picDetermin := 25
	end if
	birdY := birdY + 25
	picChoice := picDetermin

    elsif soloBirdPicChoice = 8 then
	if picDetermin = 29 then
	    picDetermin := 30
	elsif picDetermin = 30 then
	    picDetermin := 31
	elsif picDetermin = 31 then
	    picDetermin := 32
	else
	    picDetermin := 29
	end if
	birdY := birdY - 25

	picChoice := picDetermin

    else

	if (picDetermin >= 1 and picDetermin <= 8) or (picDetermin >= 25 and picDetermin <= 28) then
	    picDetermin := 20
	elsif (picDetermin >= 9 and picDetermin <= 15) or (picDetermin >= 31 and picDetermin <= 34) then
	    picDetermin := 24

	elsif picDetermin = 20 or picDetermin = 24 then
	    picDetermin := picDetermin - 3
	else
	    picDetermin := picDetermin + 1
	end if
	picChoice := picDetermin
    end if
end birdChoiceSolo


procedure crossHair
    mousewhere (crossHairX, crossHairY, button)
    if button = 0 then
	shot := 0
    elsif button = 1 then
	shot := shot + 1
    end if
    if shot > 1 then
	button := 0
    end if
end crossHair



procedure values
    drawfillbox (55, 65, 163, 10, yellow)
    drawfillbox (58, 62, 160, 13, black)
    drawfillbox (195, 65, 303, 10, yellow)
    drawfillbox (198, 62, 300, 13, black)
    if soloPlay = false then
	drawfillbox (330, 65, 525, 10, yellow)
	drawfillbox (333, 62, 522, 13, black)
	Draw.Text ("Duck  Score:", 340, 40, font, textcol)
	duck_points_str := intstr (duck_points, 3)
	Draw.Text (duck_points_str, 410, 20, font, textcol)
    end if
    textcol := 0
    if soloPlay = false then
	drawfillbox (543, 65, 767, 10, yellow)
	drawfillbox (546, 62, 764, 13, black)
	Draw.Text ("Hunter  Score:", 550, 40, font, textcol)
	hunter_points_str := intstr (hunter_points, 3)
	Draw.Text (hunter_points_str, 640, 20, font, textcol)
    else
	drawfillbox (653, 65, 767, 10, yellow)
	drawfillbox (656, 62, 764, 13, black)
	Draw.Text ("Score:", 663, 40, font, textcol)
	hunter_points_str := intstr (hunter_points, 3)
	Draw.Text (hunter_points_str, 690, 20, font, textcol)
    end if
    if soloPlay = false then
	Draw.Text ("Round:", 200, 40, font, textcol)
    else
	Draw.Text ("Level:", 200, 40, font, textcol)
    end if
    game_round_string := intstr (game_round)
    Draw.Text (game_round_string, 240, 20, font, white)
    shotCounterString := intstr (shotCounter)
    Draw.Text ("Shots:", 60, 40, font, textcol)
    Draw.Text (shotCounterString, 95, 20, font, white)
end values

procedure dogLaughing
    if playSound = true then
	Music.PlayFileReturn ("sounds/Dog Laugh Sound Effect.mp3")
    end if
    for : 1 .. 5
	for i : 1 .. 2
	    delay (200)
	    Pic.Draw (BACKGROUND, 0, 0, picCopy)
	    values
	    Pic.Draw (DOG_LAUGH (i), 350, 200, picMerge)
	    View.Update
	end for
    end for
end dogLaughing

procedure dogHoldingBird
    Pic.Draw (BACKGROUND, 0, 0, picCopy)
    values
    Pic.Draw (DOG_BIRD, 350, 200, picMerge)
    View.Update
    delay (1000)
end dogHoldingBird

procedure draw
    %Draws Background
    Pic.Draw (BACKGROUND, 0, 0, picCopy)
    values

    %Draws Bird
    Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)

    %Draws crosshair
    if button = 1 then
	clr := 12
    else
	clr := 255
    end if
    Draw.Oval (crossHairX, crossHairY, 10, 10, clr)
    Draw.Oval (crossHairX, crossHairY, 25, 25, clr)
    Draw.Line (crossHairX - 50, crossHairY, crossHairX + 50, crossHairY, clr)
    Draw.Line (crossHairX, crossHairY - 50, crossHairX, crossHairY + 50, clr)
end draw



procedure pause_userchoice
    Input.KeyDown (chars)
    if (chars (KEY_UP_ARROW) and n = 1 and not chars (KEY_DOWN_ARROW)) then
	n := 1
    elsif (chars (KEY_UP_ARROW) and n = 2 and not chars (KEY_DOWN_ARROW)) then
	n := 1
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 2 and not chars (KEY_UP_ARROW)) then
	n := 2

    elsif (chars (KEY_DOWN_ARROW) and n = 1 and not chars (KEY_UP_ARROW)) then
	n := 2
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    end if
end pause_userchoice

procedure pause_text

    if n = 1 then
	textcol := 0
	Draw.Text ("Resume  Game", 320, 300, font, textcol)
	drawfillbox (280, 316, 290, 306, 43)
	textcol := 0
	Draw.Text ("Quit  Game", 320, 260, font, textcol)
    elsif n = 2 then
	textcol := 0
	Draw.Text ("Quit  Game", 320, 260, font, textcol)
	drawfillbox (280, 276, 290, 266, 43)
	textcol := 0
	Draw.Text ("Resume  Game", 320, 300, font, textcol)
    end if
end pause_text

procedure pause_declare
    color (white)
    if (chars (KEY_ENTER) and n = 1) then
	gamePause := false
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if
    elsif (chars (KEY_ENTER) and n = 2) then
	gamePause := false
	pauseExit := true
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/blockbreak.mp3")
	end if
    end if
end pause_declare

procedure game_Pause
    gamePause := true
    textcol := 0
    if playSound = true then
	Music.PlayFileReturn ("Sounds/blockbreak.mp3")
    end if
    loop
	Input.KeyDown (chars)
	cls
	draw
	drawfillbox (265, 385, 528, 237, yellow)
	drawfillbox (268, 382, 525, 240, black)
	Draw.Text ("Game Paused", 300, 350, font, textcol)
	pause_userchoice
	pause_text
	pause_declare
	exit when gamePause = false
	View.Update
    end loop
end game_Pause

procedure fall
    loop
	for i : 34 .. 35
	    delay (50)
	    picChoice := i
	    draw
	    View.Update
	    birdY := birdY - 25
	    exit when birdY < 180
	end for
	exit when birdY < 200
    end loop
    if playSound = true then
	Music.PlayFileReturn ("Sounds/Duck Hitting the Ground.mp3")
    end if
    cls
    Pic.Draw (BACKGROUND, 0, 0, picCopy)
    values
    Draw.Oval (crossHairX, crossHairY, 10, 10, clr)
    Draw.Oval (crossHairX, crossHairY, 25, 25, clr)
    Draw.Line (crossHairX - 50, crossHairY, crossHairX + 50, crossHairY, clr)
    Draw.Line (crossHairX, crossHairY - 50, crossHairX, crossHairY + 50, clr)
    View.Update
    delay (1000)
end fall




procedure bird_respawn
    if playSound = true and creditsDuckBlocker = false and carnageSoundBlock = false then
	Music.PlayFileReturn ("Sounds/Duck Release.mp3")
    end if
    if carnageSoundBlock = true then
	carnageSoundBlock := false
    end if
    if soloPlay = false then
	respawn := Rand.Int (1, 10)
	if respawn = 1 then
	    birdX := -75
	    birdY := 225
	elsif respawn = 2 then
	    birdX := -75
	    birdY := 575
	elsif respawn = 3 then
	    birdX := 775
	    birdY := 575
	elsif respawn = 4 then
	    birdX := 775
	    birdY := 225
	elsif respawn >= 5 and respawn <= 10 then
	    birdX := Rand.Int (-75, 775)
	    birdY := Rand.Int (225, 575)
	end if
    else
	sequence := Rand.Int (1, 3)
	if sequence = 1 then
	    birdX := -100
	    birdY := 700
	elsif sequence = 2 then
	    birdX := 400
	    birdY := 700
	elsif sequence = 3 then
	    birdX := 900
	    birdY := 500
	end if
	step := 1
    end if

end bird_respawn



procedure credits
    if playSound = true then
	Music.PlayFileLoop ("Sounds/Super Mario World Music - Ending & Credits.mp3")
    end if
    creditsDuckBlocker := true
    creditsX := -200
    creditsY := 500
    soloPlay := true
    bird_respawn
    loop
	cls
	Draw.Text ("Credits", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsX := creditsX + 10
	birdChoiceSolo
	delay (75)
	exit when creditsX = 300
    end loop
    delay (1000)
    loop
	cls
	Draw.Text ("Credits", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsX := creditsX + 10
	birdChoiceSolo
	delay (75)
	exit when creditsX = 900
    end loop
    creditsX := 200
    creditsY := -100
    loop
	cls
	Draw.Text ("By  Shahzaib  Bhatti", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsY := creditsY + 10
	birdChoiceSolo
	delay (75)
	exit when creditsY = 400
    end loop
    delay (1000)
    loop
	cls
	Draw.Text ("By  Shahzaib  Bhatti", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsY := creditsY + 10
	birdChoiceSolo
	delay (75)
	exit when creditsY = 700
    end loop
    creditsX := -600
    creditsY := 200
    loop
	cls
	Draw.Text ("and  Sameid  Usmani", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsX := creditsX + 10
	birdChoiceSolo
	delay (75)
	exit when creditsX = 100
    end loop
    delay (1000)
    loop
	cls
	Draw.Text ("and  Sameid  Usmani", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsX := creditsX + 10
	birdChoiceSolo
	delay (75)
	exit when creditsX = 900
    end loop
    creditsX := 100
    creditsY := 800
    loop
	cls
	Draw.Text ("For  Grade  11  Engineering  Class", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsY := creditsY - 10
	birdChoiceSolo
	delay (75)
	exit when creditsY = 300
    end loop
    delay (1000)
    loop
	cls
	Draw.Text ("For  Grade  11  Engineering  Class", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsY := creditsY - 10
	birdChoiceSolo
	delay (75)
	exit when creditsY = -100
    end loop
    creditsX := 900
    creditsY := 300
    loop
	cls
	Draw.Text ("Special  Thanks  to:  Justin  Sodia, Jairus  Gabbison,  The  Duck,  The  Dog,  and  Mr.  Sayed", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsX := creditsX - 10
	birdChoiceSolo
	delay (75)
	exit when creditsX = -1200
    end loop
    creditsX := 250
    creditsY := -100
    loop
	cls
	Draw.Text ("Thanks for Playing", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsY := creditsY + 10
	birdChoiceSolo
	delay (75)
	exit when creditsY = 300
    end loop
    delay (1000)
    loop
	cls
	Draw.Text ("Thanks for Playing", creditsX, creditsY, font, textcol)
	Pic.Draw (BIRD_PIC (picChoice), birdX, birdY, picMerge)
	View.Update
	creditsY := creditsY + 10
	birdChoiceSolo
	delay (75)
	exit when creditsY = 700
    end loop
    delay (1000)
    creditsDuckBlocker := false
    Music.PlayFileStop
end credits

procedure multiInstructions
    textcol := 68
    Draw.Text ("Instructions:", 150, 560, font, textcol)
    Draw.Text ("Duck  Instructions:", 20, 520, font, textcol)
    Draw.Text ("Use  the  joystick  to  move.", 20, 500, font, textcol)
    Draw.Text ("Avoid  the  hunter's  crosshair.", 20, 480, font, textcol)
    Draw.Text ("When  losing,  use  button  for  speed  boost.", 20, 460, font, textcol)
    Draw.Text ("10  points  for  dodge,  -5  for  hit.", 20, 440, font, textcol)
    Draw.Text ("Hunter  Instructions:", 20, 400, font, textcol)
    Draw.Text ("Use  Wii  Remote  to  move  crosshair.", 20, 380, font, textcol)
    Draw.Text ("Press  B  trigger  to  fire.", 20, 360, font, textcol)
    Draw.Text ("Try  to  hit  the  duck.", 20, 340, font, textcol)
    Draw.Text ("You  have  3  shots  per  duck.", 20, 320, font, textcol)
    Draw.Text ("20  points  for  hit,  -10  for  dodge.", 20, 300, font, textcol)
end multiInstructions

procedure campaignInstructions
    textcol := 68
    Draw.Text ("Instructions:", 150, 560, font, textcol)
    Draw.Text ("Solo  Instructions:", 20, 520, font, textcol)
    Draw.Text ("Point  Wii  Remote  to  move  crosshair.", 20, 500, font, textcol)
    Draw.Text ("Press  B  trigger  to  fire.", 20, 480, font, textcol)
    Draw.Text ("You  have  3  shots  per  duck.", 20, 460, font, textcol)
    Draw.Text ("20  points  for  hit,  -10  for  dodge.", 20, 440, font, textcol)
end campaignInstructions

procedure carnage_report
    textcol := 68
    carnageReport_exit := false
    duck_round_str := intstr (duck_round_wins, 3)
    hunter_round_str := intstr (hunter_round_wins, 3)
    duck_points_str := intstr (duck_points, 3)
    hunter_points_str := intstr (hunter_points, 3)
    hits_str := intstr (hits, 3)
    misses_str := intstr (misses, 3)
    loop
	Input.KeyDown (chars)
	cls
	if (chars (KEY_ENTER)) then
	    carnageReport_exit := true
	end if
	if soloPlay = false then
	    Draw.Text ("Carnage  Report:  (Press  A  To  Continue)", 75, 550, font, textcol)
	    Draw.Text ("Duck  Report:", 100, 475, font, textcol)
	    Draw.Text ("Score:    " + duck_points_str, 50, 400, font, textcol)
	    Draw.Text ("Dodges:    " + misses_str, 50, 360, font, textcol)
	    Draw.Text ("Deaths:    " + hits_str, 50, 320, font, textcol)
	    Draw.Text ("Hunter  Report:", 500, 475, font, textcol)
	    Draw.Text ("Score:    " + hunter_points_str, 450, 400, font, textcol)
	    Draw.Text ("Kills:    " + hits_str, 450, 360, font, textcol)
	    Draw.Text ("Misses:    " + misses_str, 450, 320, font, textcol)
	    Draw.ThickLine (-100, 515, 900, 515, 3, 68)
	    Draw.ThickLine (-100, 450, 900, 450, 3, 68)
	    Draw.ThickLine (400, 515, 400, 0, 3, 68)
	    if hunter_points > duck_points then
		Draw.Text ("Winner!", 540, 200, font, textcol)
		Draw.Text ("Loser...", 140, 200, font, textcol)
		Pic.Draw (DOG_BIRD, 525, -20, picMerge)
	    elsif duck_points > hunter_points then
		Draw.Text ("Loser...", 540, 200, font, textcol)
		Draw.Text ("Winner", 140, 200, font, textcol)
		Pic.Draw (DOG_LAUGH (1), 135, -25, picMerge)
	    end if
	else
	    Draw.Text ("Carnage  Report:  (Press  Enter  To  Continue)", 75, 550, font, textcol)
	    Draw.Text ("Hunter  Report:", 280, 475, font, textcol)
	    Draw.Text ("Score:        " + hunter_points_str, 200, 400, font, textcol)
	    Draw.Text ("Kills:        " + hits_str, 200, 360, font, textcol)
	    Draw.Text ("Misses:        " + misses_str, 200, 320, font, textcol)
	    Draw.ThickLine (-100, 515, 900, 515, 3, 68)
	    Draw.ThickLine (-100, 450, 900, 450, 3, 68)
	    Pic.Draw (DOG_LAUGH (1), 380, -25, picMerge)
	end if
	View.Update
	exit when carnageReport_exit = true
    end loop
    soloPlay := false
end carnage_report


procedure multiplayermode

    pauseExit := false
    misses := 0
    hits := 0
    hunter_points := 0
    hunter_round_wins := 0
    duck_round_wins := 0
    duck_points := 0
    game_round := 1
    sequence := Rand.Int (1, 3)
    if playSound = true then
	Music.PlayFileReturn ("Sounds/Round Introduction.mp3")
    end if
    dogWalk
    mousewhere (garbageX, garbageY, button)
    bird_respawn
    loop
	Input.KeyDown (chars)
	if chars (KEY_ENTER) then
	    delay (200)
	    game_Pause
	end if
	if button = 1 then
	    if crossHairX > birdX and crossHairX < birdX + 100 and crossHairY > birdY and crossHairY < birdY + 100 then
		picChoice := 33
		hunter_points := hunter_points + 20
		duck_points := duck_points - 10
		hits := hits + 1
		draw
		View.Update
		Music.PlayFileStop
		if rumbleOnOff = true then
		    %parallelput (1)
		end if
		delay (1000)
		fall
		if rumbleOnOff = true then
		    %parallelput (0)
		end if
		dogHoldingBird
		bird_respawn
		game_round := game_round + 1
		hunter_round_wins := hunter_round_wins + 1
		shotCounter := 3
	    elsif crossHairX > birdX + 100 or crossHairX < birdX or crossHairY > birdY + 100 or crossHairY < birdY then
		hunter_points := hunter_points - 10
		duck_points := duck_points + 10
		shotCounter := shotCounter - 1
		misses := misses + 1

		if shotCounter = 0 then
		    Music.PlayFileStop
		    delay (1000)
		    dogLaughing
		    bird_respawn
		    if soloPlay = false then
			game_round := game_round + 1
			duck_round_wins := duck_round_wins + 1
		    end if
		    shotCounter := 3
		end if
	    end if
	    cls
	    if game_round = 11 then
		carnageSoundBlock := true
		exit
	    end if
	end if
	if soloPlay = false then
	    birdChoice
	else
	    birdChoiceSolo
	end if
	crossHair
	draw
	View.Update
	if soloPlay = false then
	    if superSpeed = false then
		if (chars ('z')) then
		    if duck_points < hunter_points then
			multi_birdDelay := BOOST_SPEED
			if rumbleOnOff = true then
			    parallelput (1)
			end if
		    end if
		else
		    multi_birdDelay := NORMAL_SPEED
		    if rumbleOnOff = true then
			parallelput (0)
		    end if
		end if
		delay (multi_birdDelay)
	    elsif superSpeed = true then
		delay (multi_birdDelay)
	    end if

	else
	    birdDelay := delaySolo (game_round)
	    delay (birdDelay)
	end if
	exit when pauseExit = true
    end loop
    multiplayer_exit := false
    carnage_report
end multiplayermode



procedure mainmenu_userchoice
    Pic.Draw (title, 200, 275, picCopy)
    Input.KeyDown (chars)

    if (chars (KEY_UP_ARROW) and n = 1 and not chars (KEY_DOWN_ARROW)) then
	n := 1

    elsif (chars (KEY_UP_ARROW) and n = 2 and not chars (KEY_DOWN_ARROW)) then
	n := 1
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_UP_ARROW) and n = 3 and not chars (KEY_DOWN_ARROW)) then
	n := 2
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_UP_ARROW) and n = 4 and not chars (KEY_DOWN_ARROW)) then
	n := 3
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 1 and not chars (KEY_UP_ARROW)) then
	n := 2
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 2 and not chars (KEY_UP_ARROW)) then
	n := 3
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 3 and not chars (KEY_UP_ARROW)) then
	n := 4
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 4 and not chars (KEY_UP_ARROW)) then
	n := 4
    end if
end mainmenu_userchoice

procedure main_text
    if n = 1 then
	textcol := 43
	Draw.Text ("Campaign", 320, 240, font, textcol)
	drawfillbox (280, 256, 290, 246, 43)
	textcol := 42
	Draw.Text ("Multiplayer", 320, 200, font, textcol)
	Draw.Text ("Options ", 320, 160, font, textcol)
	Draw.Text ("Quit Game", 320, 120, font, textcol)
    elsif n = 2 then
	textcol := 43
	Draw.Text ("Multiplayer", 320, 200, font, textcol)
	drawfillbox (280, 216, 290, 206, 43)
	textcol := 42
	Draw.Text ("Campaign", 320, 240, font, textcol)
	Draw.Text ("Options ", 320, 160, font, textcol)
	Draw.Text ("Quit Game", 320, 120, font, textcol)
    elsif n = 3 then
	textcol := 43
	Draw.Text ("Options ", 320, 160, font, textcol)
	drawfillbox (280, 176, 290, 166, 43)
	textcol := 42
	Draw.Text ("Campaign", 320, 240, font, textcol)
	Draw.Text ("Multiplayer", 320, 200, font, textcol)
	Draw.Text ("Quit Game", 320, 120, font, textcol)
    elsif n = 4 then
	textcol := 43
	Draw.Text ("Quit Game", 320, 120, font, textcol)
	drawfillbox (280, 135, 290, 125, 43)
	textcol := 42
	Draw.Text ("Campaign", 320, 240, font, textcol)
	Draw.Text ("Multiplayer", 320, 200, font, textcol)
	Draw.Text ("Options ", 320, 160, font, textcol)
    end if
end main_text

procedure mainmenu_declare
    color (white)
    if (chars (KEY_ENTER)) and n = 1 then
	n := 1
	campaign_TF := true
	mainmenu_TF := false
	mainmenu_exit := true
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if
    elsif (chars (KEY_ENTER) and n = 2) then
	n := 1
	multiplayer_TF := true
	mainmenu_TF := false
	mainmenu_exit := true
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if
    elsif (chars (KEY_ENTER) and n = 3) then
	n := 1
	options_TF := true
	mainmenu_TF := false
	mainmenu_exit := true
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if
    elsif (chars (KEY_ENTER) and n = 4) then
	Window.Close (winID)
	quit
    end if
end mainmenu_declare


procedure mainmenu
    loop
	cls
	mainmenu_userchoice
	main_text
	mainmenu_declare
	View.Update
	delay (100)
	exit when mainmenu_exit = true
    end loop
end mainmenu


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


procedure campaign_userchoice
    Input.KeyDown (chars)
    if (chars (KEY_UP_ARROW) and n = 1 and not chars (KEY_DOWN_ARROW)) then
	n := 1
    elsif (chars (KEY_UP_ARROW) and n = 2 and not chars (KEY_DOWN_ARROW)) then
	n := 1
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 1 and not chars (KEY_UP_ARROW)) then
	n := 2
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 2 and not chars (KEY_UP_ARROW)) then
	n := 2
    end if
end campaign_userchoice

procedure campaign_text
    if n = 1 then
	textcol := 43
	Draw.Text ("Play  Solo", 320, 240, font, textcol)
	drawfillbox (280, 256, 290, 246, 43)
	textcol := 42
	Draw.Text ("Back  to  Main  Menu", 320, 200, font, textcol)
    elsif n = 2 then
	textcol := 43
	Draw.Text ("Back  to  Main  Menu", 320, 200, font, textcol)
	drawfillbox (280, 216, 290, 206, 43)
	textcol := 42
	Draw.Text ("Play  Solo", 320, 240, font, textcol)
    end if
end campaign_text

procedure campaign_declare
    color (white)
    if (chars (KEY_ENTER) and n = 1) then
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if
	soloPlay := true
	multiplayermode
    elsif (chars (KEY_ENTER) and n = 2) then
	n := 1
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/blockbreak.mp3")
	end if
	mainmenu_TF := true
	campaign_TF := false
	campaign_exit := true
    end if
end campaign_declare

procedure campaign
    loop
	cls
	campaignInstructions
	campaign_userchoice
	campaign_text
	campaign_declare
	View.Update
	delay (100)
	exit when campaign_exit = true
    end loop
end campaign

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


procedure multi_userchoice
    Input.KeyDown (chars)
    if (chars (KEY_UP_ARROW) and n = 1 and not chars (KEY_DOWN_ARROW)) then
	n := 1
    elsif (chars (KEY_UP_ARROW) and n = 2 and not chars (KEY_DOWN_ARROW)) then
	n := 1
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 2 and not chars (KEY_UP_ARROW)) then
	n := 2

    elsif (chars (KEY_DOWN_ARROW) and n = 1 and not chars (KEY_UP_ARROW)) then
	n := 2
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    end if
end multi_userchoice

procedure multi_text

    if n = 1 then
	textcol := 43
	Draw.Text ("Play  Multiplayer", 320, 240, font, textcol)
	drawfillbox (280, 256, 290, 246, 43)
	textcol := 42
	Draw.Text ("Back  To  Main  Menu", 320, 200, font, textcol)
    elsif n = 2 then
	textcol := 43
	Draw.Text ("Back  To  Main  Menu", 320, 200, font, textcol)
	drawfillbox (280, 216, 290, 206, 43)
	textcol := 42
	Draw.Text ("Play  Multiplayer", 320, 240, font, textcol)
    end if
end multi_text

procedure multi_declare
    color (white)
    if (chars (KEY_ENTER) and n = 1) then
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if
	soloPlay := false
	game_round := 1
	duck_points := 0
	hunter_points := 0
	birdDelay := NORMAL_SPEED
	multiplayermode
    elsif (chars (KEY_ENTER) and n = 2) then
	n := 2
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/blockbreak.mp3")
	end if
	mainmenu_TF := true
	multiplayer_TF := false
	multiplayer_exit := true
    end if
end multi_declare

procedure multiplayer
    loop
	cls
	multiInstructions
	multi_userchoice
	multi_text
	multi_declare
	View.Update
	delay (100)
	exit when multiplayer_exit = true
    end loop
end multiplayer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


procedure options_userchoice
    Input.KeyDown (chars)
    if (chars (KEY_UP_ARROW) and n = 1 and not chars (KEY_DOWN_ARROW)) then
	n := 1
    elsif (chars (KEY_UP_ARROW) and n = 2 and not chars (KEY_DOWN_ARROW)) then
	n := 1
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_UP_ARROW) and n = 3 and not chars (KEY_DOWN_ARROW)) then
	n := 2
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_UP_ARROW) and n = 4 and not chars (KEY_DOWN_ARROW)) then
	n := 3
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_UP_ARROW) and n = 5 and not chars (KEY_DOWN_ARROW)) then
	n := 4
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 1 and not chars (KEY_UP_ARROW)) then
	n := 2
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 2 and not chars (KEY_UP_ARROW)) then
	n := 3
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 3 and not chars (KEY_UP_ARROW)) then
	n := 4
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 4 and not chars (KEY_UP_ARROW)) then
	n := 5
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/fireball.wav")
	end if
    elsif (chars (KEY_DOWN_ARROW) and n = 5 and not chars (KEY_UP_ARROW)) then
	n := 5
    end if
end options_userchoice

procedure options_text
    if n = 1 then
	textcol := 43
	drawfillbox (280, 296, 290, 286, 43)
	if rumbleOnOff = true then
	    Draw.Text ("Rumble     ON", 320, 280, font, textcol)
	elsif rumbleOnOff = false then
	    Draw.Text ("Rumble     OFF", 320, 280, font, textcol)
	end if
	textcol := 42
	Draw.Text ("Sound", 320, 240, font, textcol)
	Draw.Text ("Super  Speed", 320, 200, font, textcol)
	Draw.Text ("Credits", 320, 160, font, textcol)
	Draw.Text ("Back  to  main  menu", 320, 120, font, textcol)
    elsif n = 2 then
	textcol := 43
	drawfillbox (280, 256, 290, 246, 43)
	if playSound = true then
	    Draw.Text ("Sound     ON", 320, 240, font, textcol)
	elsif playSound = false then
	    Draw.Text ("Sound     OFF", 320, 240, font, textcol)
	end if
	textcol := 42
	Draw.Text ("Rumble", 320, 280, font, textcol)
	Draw.Text ("Super  Speed", 320, 200, font, textcol)
	Draw.Text ("Credits", 320, 160, font, textcol)
	Draw.Text ("Back  to  main  menu", 320, 120, font, textcol)
    elsif n = 3 then
	textcol := 43
	if superSpeed = true then
	    Draw.Text ("Super  Speed     ON", 320, 200, font, textcol)
	elsif superSpeed = false then
	    Draw.Text ("Super  Speed     OFF", 320, 200, font, textcol)
	end if
	drawfillbox (280, 216, 290, 206, 43)
	textcol := 42
	Draw.Text ("Rumble", 320, 280, font, textcol)
	Draw.Text ("Sound", 320, 240, font, textcol)
	Draw.Text ("Credits", 320, 160, font, textcol)
	Draw.Text ("Back  to  main  menu", 320, 120, font, textcol)
    elsif n = 4 then
	textcol := 43
	Draw.Text ("Credits", 320, 160, font, textcol)
	drawfillbox (280, 164, 290, 174, 43)
	textcol := 42
	Draw.Text ("Rumble", 320, 280, font, textcol)
	Draw.Text ("Sound", 320, 240, font, textcol)
	Draw.Text ("Super  Speed", 320, 200, font, textcol)
	Draw.Text ("Back  to  main  menu", 320, 120, font, textcol)
    elsif n = 5 then
	textcol := 43
	Draw.Text ("Back  to  main  menu", 320, 120, font, textcol)
	drawfillbox (280, 125, 290, 135, 43)
	textcol := 42
	Draw.Text ("Rumble", 320, 280, font, textcol)
	Draw.Text ("Sound", 320, 240, font, textcol)
	Draw.Text ("Super  Speed", 320, 200, font, textcol)
	Draw.Text ("Credits", 320, 160, font, textcol)
    end if
end options_text

procedure options_declare
    color (white)
    if (chars (KEY_ENTER) and n = 1) then
	if rumbleOnOff = true then
	    rumbleOnOff := false
	    Music.PlayFileReturn ("Sounds/coin.wav")
	elsif rumbleOnOff = false then
	    rumbleOnOff := true
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if

    elsif (chars (KEY_ENTER) and n = 2) then
	if playSound = true then
	    playSound := false
	elsif playSound = false then
	    playSound := true
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if

    elsif (chars (KEY_ENTER) and n = 3) then
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if
	if superSpeed = true then
	    superSpeed := false
	    multi_birdDelay := 75
	elsif superSpeed = false then
	    superSpeed := true
	    multi_birdDelay := 1
	end if
    elsif (chars (KEY_ENTER) and n = 4) then
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/coin.wav")
	end if
	credits
    elsif (chars (KEY_ENTER) and n = 5) then
	n := 3
	if playSound = true then
	    Music.PlayFileReturn ("Sounds/blockbreak.mp3")
	end if
	mainmenu_TF := true
	options_TF := false
	options_exit := true
    end if
end options_declare

procedure options
    loop
	cls
	options_userchoice
	options_text
	options_declare
	View.Update
	delay (100)
	exit when options_exit = true
    end loop
end options

if playSound = true then
    Music.PlayFileReturn ("Sounds/Duck Hunt Theme Song.mp3")
end if
loop
    if mainmenu_TF = true and campaign_TF = false and multiplayer_TF = false and options_TF = false then
	mainmenu
    elsif campaign_TF = true and mainmenu_TF = false and multiplayer_TF = false and options_TF = false then
	campaign
    elsif multiplayer_TF = true and campaign_TF = false and mainmenu_TF = false and options_TF = false then
	multiplayer
    elsif options_TF = true and multiplayer_TF = false and campaign_TF = false and mainmenu_TF = false then
	options
    end if
    exit when menusystem_exit = true
end loop
