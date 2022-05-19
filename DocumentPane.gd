extends PanelContainer

# Hold references to relevant nodes for update
var notebook_selection
var collapse_pane


# On _ready() populate the list of notebooks and refresh the document tree
func _ready():
	# Populate node reference variables
	notebook_selection = $DocumentPaneContainer/NotebookBarContainer/NotebookBarLayout/NotebookSelectionButton
	collapse_pane = $DocumentPaneContainer/NotebookBarContainer/NotebookBarLayout/CollapsePaneButton
	
	# Parse the list of notebooks in the top level folder and add their names
	var files = []
	var dir = Directory.new()
	dir.open("user://notebooks/")
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file and dir.current_is_dir() and not file.begins_with("."):
			print("Found a directory named " + file)
			notebook_selection.add_item(file)
		elif file == "":
			break

	dir.list_dir_end()
	
	print("Found " + str(notebook_selection.get_item_count()) + " notebooks")


func _on_NotebookSelectionButton_item_selected(index):
	print("Received signal to switch to notebook " + str(notebook_selection.get_item_text(index)))


# Function to refresh the notebook selection menu and the document tree
func refresh_pane():
	pass


func switch_notebook(name):
	print("Switching notebook display to " + name)

