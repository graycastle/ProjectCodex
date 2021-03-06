extends PanelContainer

# Declare constants
const NOTEBOOKS_BASE_PATH = "user://notebooks/"

# Hold references to relevant nodes for easier use
var document_pane
var text_editor_pane

func _ready():
	# Populate the node reference variables
	document_pane = $ApplicationContainer/MainContainer/ApplicationPanes/DocumentPane
	text_editor_pane = $ApplicationContainer/MainContainer/ApplicationPanes/TextEditorPane
	
	# Check the user directory for the notebooks folder, create if missing
	var dir = Directory.new()
	
	var error = dir.open(NOTEBOOKS_BASE_PATH)
	if error != OK:
		print("The notebook folder does not exist, create it now")
		dir.make_dir(NOTEBOOKS_BASE_PATH)


# MENU FUNCTIONS
func _on_QuitButton_pressed():
	get_tree().quit()


# DOCUMENT PANE FUNCTIONS

# Open the New Notebook dialog when the new button has been pressed
func _on_NewNotebookButton_pressed():
	$PopupControls/NewNotebookDialog.popup()


# Create a new Notebook and refresh the document tree
func _on_new_notebook(name):
	new_notebook(name)


# Open an activated document
func _on_DocumentPane_document_activated(document):
	# TODO: Hand this behavior off to the TextEditorContainer for handling
	text_editor_pane.load_document(document)


func new_notebook(name):
	print("Creating a new notebook with the name " + name)
	var dir = Directory.new()
	
	var error = dir.open(NOTEBOOKS_BASE_PATH + name)
	if error != OK:
		print("This notebook does not exist, create its folder now")
		dir.make_dir(NOTEBOOKS_BASE_PATH + name)
		
		# Switch the document tree to this notebook
		print("Switching document tree to new notebook")
		document_pane.refresh_pane()
		document_pane.switch_notebook(name)
	else:
		print("This notebook exists already, fire an error toast and change to display it")
		document_pane.refresh_pane()
		document_pane.switch_notebook(name)


# TEXT EDITOR PANE FUNCTIONS

