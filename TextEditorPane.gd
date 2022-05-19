extends PanelContainer


# Hold references to relevant nodes
var current_filename
var text_editor


func _ready():
	# Populate the references to relevant nodes
	current_filename = $TextEditorContainer/FilenameContainer/FilenameLabel
	text_editor = $TextEditorContainer/TextEditorPanel/TextEditor


func load_document(document):
	# Clear the contents of the text editor
	text_editor.text = ""
	text_editor.text = document
	
	# TODO: Parse the in-document headers for the incoming document
	
