extends Node

var makeIndex = 0
var carma = 0


var hints = ["res://Textures/GIVEhint.png",\
"res://Textures/PRICEhint.png",\
"res://Textures/BUYhint.png",\
"res://Textures/FREEhint.png",\
"res://Textures/THINKhint.png",\
"res://Textures/DEALhint.png",\
"res://Textures/JUSThint.png",\
"res://Textures/TAKEhint.png",\
"res://Textures/RUNhint.png",\
"res://Textures/BUSYhint.png",\
"res://Textures/CLIENThint.png",\
"res://Textures/PROFIThint.png",\
"res://Textures/COINhint.png",\
"res://Textures/MONEYhint.png",\
]
var makeScene = [preload("res://Scenes/LevelTypes/GIVE.tscn"),\
preload("res://Scenes/LevelTypes/PRICES.tscn"),\
preload("res://Scenes/LevelTypes/BUY.tscn"),\
preload("res://Scenes/LevelTypes/FREE.tscn"),\
preload("res://Scenes/LevelTypes/THINK.tscn"),\
preload("res://Scenes/LevelTypes/DEAL.tscn"),\
preload("res://Scenes/LevelTypes/JUST.tscn"),\
preload("res://Scenes/LevelTypes/TAKE.tscn"),\
preload("res://Scenes/LevelTypes/RUN.tscn"),\
preload("res://Scenes/LevelTypes/BUSY.tscn"),\
preload("res://Scenes/LevelTypes/CLIENT.tscn"),\
preload("res://Scenes/LevelTypes/PROFIT.tscn"),\
preload("res://Scenes/LevelTypes/COIN.tscn"),\
preload("res://Scenes/LevelTypes/MONEY.tscn"),\
]
