extends Control


# Hold references to all relevant nodes
var new_notebook_dialog


# Create signals for firing functions further up the tree
signal new_notebook


# Ready function to gather references to all relevant nodes
func _ready():
	new_notebook_dialog = $NewNotebookDialog


# New Notebook Dialog functions
func _on_NewNotebookAddButton_pressed():
	# Get the name the user entered
	var new_notebook_name = $NewNotebookDialog/NewNotebookPanel/NewNotebookDialogLayout/NewNotebookNameText.text
	
	# Emit a signal for application-level handling
	emit_signal("new_notebook", new_notebook_name)
	
	# Close the New Notebook dialog once the signals is emitted
	show_new_notebook_dialog(false)


func _on_NewNotebookCancelButton_pressed():
	show_new_notebook_dialog(false)
	
	
func show_new_notebook_dialog(show):
	new_notebook_dialog.visible = show

