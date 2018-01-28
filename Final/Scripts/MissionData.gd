extends Node

var day_missions = [[
    {'x': -10, 'y': -395,
    'icon': preload('res://Assets/FountainIcon.png')
    },
    {'x': 0, 'y': 0,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    }],

    [
    {'x': 0, 'y': 0,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    },
    {'x': 0, 'y': 0,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    }]
]

var completed_missions = []

var night_texts = [
[
    {'header': 'TERROR', 'text': 'sometext'},
    {'header': 'TERROR', 'text': 'sometext'},
    {'header': 'TERROR', 'text': 'sometext'}
],

[
    {'header': 'TERROR', 'text': 'sometext'},
    {'header': 'TERROR', 'text': 'sometext'},
    {'header': 'TERROR', 'text': 'sometext'}
]
]

var current_day = 1
var ending_started = false
var ending = 'neither'

func _ready():
    pass

func next_day():
	current_day += 1
	if current_day > len(night_texts) or current_day > len(day_missions):
		var total_missions = 0
		for day in day_missions:
			total_missions += len(day)
		if len(completed_missions) < total_missions:
			ending = 'blue'
		else:
			ending = 'red'
		GameController.game_over()
		return current_day - 1
	return current_day

func get_todays_missions():
    return day_missions[current_day - 1]

func get_tonights_papers():
    return night_texts[current_day - 1]

func run_day():
    pass

func day_one():
    pass

func day_two():
    pass
	
func start_blue_ending():
	pass
	
func blue_ending():
	return
	
func start_red_ending():
	pass
	
func red_ending():
	return
	
func end():
	if ending_started:
		if ending == 'blue':
			blue_ending()
		if ending == 'red':
			red_ending()
			
	else:
		ending_started = true
		var total_missions = 0
		for day in day_missions:
			total_missions += len(day)
		if len(completed_missions) < total_missions:
			start_red_ending()
		else:
			start_blue_ending()