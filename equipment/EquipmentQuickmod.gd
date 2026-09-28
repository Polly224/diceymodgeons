extends PanelContainer

onready var EquipAuthorEdit = find_node("EquipAuthorEdit")
onready var EquipCommentEdit = find_node("EquipCommentEdit")

var data_id:String = ""
var data:Dictionary = {}

func set_data(data):
	data_id = Database.get_data_id(data, "Name")
	self.data = data
	
	_setup(EquipAuthorEdit, "Author", "")
	_setup(EquipCommentEdit, "Comment", "")

func _setup(node, key, def):
	if node is LineEdit:
		node.text = data.get(key, def)
		Utils.connect_signal(node, key, "text_changed", self, "_on_LineEdit_text_changed")
	elif node is TextEdit:
		node.text = data.get(key, def)
		Utils.connect_signal(node, key, "text_changed", self, "_on_TextEdit_text_changed")

func _on_LineEdit_text_changed(value, node, key):
	if not data_id: return
	Database.commit(Database.Table.EQUIPMENT, Database.UPDATE, data_id, key, value)

func _on_TextEdit_text_changed(node, key):
	if not data_id: return
	Database.commit(Database.Table.EQUIPMENT, Database.UPDATE, data_id, key, node.text)
