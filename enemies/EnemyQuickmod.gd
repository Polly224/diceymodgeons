extends PanelContainer

onready var AuthorEdit = find_node("AuthorEdit")
onready var CommentEdit = find_node("CommentEdit")

var data_id:String = ""
var data:Dictionary = {}

func set_data(data):
	data_id = Database.get_data_id(data, "ID")
	self.data = data
	
	_setup(AuthorEdit, "Author", "")
	_setup(CommentEdit, "Comment", "")

func _setup(node, key, def):
	print(node)
	if node is LineEdit:
		node.text = data.get(key, def)
		Utils.connect_signal(node, key, "text_changed", self, "_on_LineEdit_text_changed")
	elif node is TextEdit:
		node.text = data.get(key, def)
		Utils.connect_signal(node, key, "text_changed", self, "_on_TextEdit_text_changed")

func _on_LineEdit_text_changed(value, node, key):
	if not data_id: return
	Database.commit(Database.Table.FIGHTERS, Database.UPDATE, data_id, key, value)

func _on_TextEdit_text_changed(node, key):
	if not data_id: return
	Database.commit(Database.Table.FIGHTERS, Database.UPDATE, data_id, key, node.text)
