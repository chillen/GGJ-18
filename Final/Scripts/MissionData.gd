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

func _ready():
    pass

func next_day():
    current_day += 1
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