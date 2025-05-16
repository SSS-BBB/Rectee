class_name LanguageOptionButton extends OptionButton

func _ready():
	match GameManager.language:
		GameManager.Language.en:
			select(0)
		GameManager.Language.th:
			select(1)
		_:
			push_warning("No supported language in the language option button")
			select(0)
