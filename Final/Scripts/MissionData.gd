extends Node

var day_missions = [[
#Day 1
    {'x': -1170, 'y': 0,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    }],
#Day 2
	[{'x': -600, 'y': -530,
    'icon': preload('res://Assets/FountainIcon.png')
    },
	{'x': -55, 'y': -763,
    'icon': preload('res://Assets/FountainIcon.png')
    }],
#Day 3
    [
    {'x': -450, 'y': 300,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    },
    {'x': 270, 'y': 700,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    }],
#Day 4
 	[
    {'x': 150, 'y': 0,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    },
    {'x': 1500, 'y': 0,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    },
    {'x': 1500, 'y': -600,
    'icon': preload('res://Assets/ParkBenchIcon.png')
    }]
]

var completed_missions = []

var night_texts = [
[
    {'header': 'BORDER TENSIONS DROPPING', 'text': 'As stocks grow, local corporations offer aid and support to our neighbours in the north west. Surely this wouldn\t have been possible if not for the support of big company ....'},
    {'header': 'NEW BRIDGE FUELING THE ECONOMY', 'text': 'After years of wasting fuel, time, and employee wages making our way around the canal, the new bridge is a marketing marvel, connecting villages in western...'}
],

[
    {'header': 'SOUTHWEST WATERFRONT PROPERTY PRICES SOAR', 'text': 'The beauty of the south east coral has attracted high class business people from all around. If we weren\'t supposed to drain it dry, why would it be so prett..'},
    {'header': 'FOUNTAIN SHOWS THE POWER OF MONEY', 'text': '[REDACTED] has wowed us all, spending 0.01% of his fortune on a wonderful golden fountain. While normally a gathering place of flying rats, [REDACTED] has taken measures to...'}
],
[
    {'header': 'WHY ALL THE BIRDS?', 'text': 'Recent increases in uniformly cooing birds frightening specialists. They fear the gatherings of likeminded feather rodents meeting at what they dub, "The Neck of the Sparrow" in the north east of our grea...'},
    {'header': 'STRIKING OIL!', 'text': 'Oil found north of the newly dubbed, "Lake Barren", formally a disgusting overgrowth of expensive coral. Found by island visitors from the northern islands of ...'},
    {'header': 'DEMOCRATIC PARTY LEADER TO GIVE STATE OF THE UNION ADDRESS', 'text': 'Democratic party leader to give state of the union address from her resort at the [REDACTED] islands, west of Lake Barren'}
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