extends PanelContainer

# Hold references to relevant nodes for update
var notebook_selection
var collapse_pane
var document_tree

# Hold references to the currently selected notebook
var current_notebook


signal document_activated


# On _ready() populate the list of notebooks and refresh the document tree
func _ready():
	# Populate node reference variables
	notebook_selection = $DocumentPaneContainer/NotebookBarContainer/NotebookBarLayout/NotebookSelectionButton
	collapse_pane = $DocumentPaneContainer/NotebookBarContainer/NotebookBarLayout/CollapsePaneButton
	document_tree = $DocumentPaneContainer/DocumentTreePanel/DocumentTree
	
	# Populate the notebook selection button
	populate_selector()


func _on_NotebookSelectionButton_item_selected(index):
	if index == 0:
		print("Selected the default item, hide the text editor")
		document_tree.clear()
	else:
		switch_notebook(notebook_selection.get_item_text(index))


func _on_DocumentTree_item_activated():
	print("The document " + str(document_tree.get_selected().get_text(0)) + " has been activated")
	# Get the file that's been selected and push it with the signal to the application
	var file = File.new()
	file.open("user://notebooks/" + current_notebook + "/" + document_tree.get_selected().get_text(0), file.READ_WRITE)
	var document = file.get_as_text()
	file.close()
	
	emit_signal("document_activated", document)

# Function to refresh the notebook selection menu and the document tree
func refresh_pane():
	populate_selector()
	populate_tree()


func populate_selector():
	# Clear out any existing values from the selector for a fresh list
	notebook_selection.clear()
	
	# Add a default item to the selector
	notebook_selection.add_item("Select a notebook...")
	
	# Parse the list of notebooks in the top level folder and add their names
	var dir = Directory.new()
	dir.open("user://notebooks/")
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file and dir.current_is_dir() and not file.begins_with("."):
			notebook_selection.add_item(file)
		elif file == "":
			break

	dir.list_dir_end()


func populate_tree():
	print("Populating the file tree for the notebook " + notebook_selection.get_item_text(notebook_selection.get_selected_id()))
	# Clear the current contents of the tree for a fresh list
	document_tree.clear()
	
	# Loop through all markdown files in the notebooks folder and add to an array
	var documents = []
	
	var dir = Directory.new()
	dir.open("user://notebooks/" + notebook_selection.get_item_text(notebook_selection.get_selected_id()))
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		print("Current document name in notebook: " + file)
		if file and not file.begins_with("."):
			documents.push_front(file)
		elif file == "":
			break

	dir.list_dir_end()
	
	print("Found " + str(documents.size()) + " documents in this notebook")
	
	# Loop through the retrieved document names and add to the tree
	var root = document_tree.create_item()
	for i in range(documents.size()):
		print("Creating tree entry for " + documents[i])
		var current_document = document_tree.create_item(root)
		current_document.set_text(0, documents[i])
		


func switch_notebook(name):
	# TODO: Determine how to handle newly created notebooks that are not on the list yet
	print("Switching notebook display to " + name)
	# Loop through the notebooks on the selectors list
	var notebook_found = false
	for i in range(notebook_selection.get_item_count()):
		if notebook_selection.get_item_text(i) == name:
			notebook_selection.select(i)
			notebook_found = true
			break
	
	# Check to see if we found the notebook and handle appropriately
	if notebook_found:
		print("Found the notebook to switch to, populating the file tree")
		current_notebook = name
		populate_tree()
	else:
		print("Error, no notebook found by this name, show a toast or error report")


func new_document():
	# TODO: Implement the creation of a new document with headers
	pass
