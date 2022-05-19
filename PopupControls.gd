extends Control


# Hold references to all relevant nodes
var new_notebook_dialog


# Ready function to gather references to all relevant nodes
func _ready():
	new_notebook_dialog = $NewNotebookDialog


# New Notebook Dialog functions
func _on_NewNotebookAddButton_pressed():
	print("Adding new notebook with the name " + $NewNotebookDialog/NewNotebookPanel/NewNotebookDialogLayout/NewNotebookNameText.text)
	pass # Replace with function body.


func _on_NewNotebookCancelButton_pressed():
	show_new_notebook_dialog(false)
	
	
func show_new_notebook_dialog(show):
	new_notebook_dialog.visible = show

