extends PanelContainer



# MENU FUNCTIONS
func _on_QuitButton_pressed():
	get_tree().quit()


# DOCUMENT PANE FUNCTIONS
func _on_NewNotebookButton_pressed():
	$PopupControls/NewNotebookDialog.popup()


# TEXT EDITOR PANE FUNCTIONS
