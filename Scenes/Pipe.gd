extends Node

class_name Pipe

var position: Vector2
var children: Array
var parent: Pipe

func _init(_position: Vector2, _children=[], _parent=null):
	position = _position
	children = _children
	parent = _parent
