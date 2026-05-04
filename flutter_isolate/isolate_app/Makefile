# Detect OS
ifeq ($(OS),Windows_NT)
  
    MKDIR = if not exist
    TOUCH = type nul >
    RMDIR = rmdir /s /q
    detected_OS := Windows
else
  
    MKDIR = mkdir -p
    TOUCH = touch
    RMDIR = rm -rf
    detected_OS := $(shell uname)
endif

feature:
ifeq ($(OS),Windows_NT)
	@if "$(name)"=="" (echo Usage: make feature name=^<feature_name^> && exit /b 1)
	@if not exist lib\$(name)\data\repo mkdir lib\$(name)\data\repo
	@if not exist lib\$(name)\domain\repo mkdir lib\$(name)\domain\repo
	@if not exist lib\$(name)\domain\models mkdir lib\$(name)\domain\models
	@if not exist lib\$(name)\presentation\bloc mkdir lib\$(name)\presentation\bloc
	@if not exist lib\$(name)\presentation\screens mkdir lib\$(name)\presentation\screens
	@if not exist lib\$(name)\presentation\widgets mkdir lib\$(name)\presentation\widgets
	@type nul > lib\$(name)\data\repo\$(name)_repo_impl.dart
	@type nul > lib\$(name)\domain\repo\$(name)_repo.dart
	@echo ✅ Feature '$(name)' created!
else
	@if [ -z "$(name)" ]; then echo "Usage: make feature name=<feature_name>"; exit 1; fi
	@mkdir -p lib/$(name)/data/repo
	@mkdir -p lib/$(name)/domain/repo
	@mkdir -p lib/$(name)/domain/models
	@mkdir -p lib/$(name)/presentation/bloc
	@mkdir -p lib/$(name)/presentation/screens
	@mkdir -p lib/$(name)/presentation/widgets
	@touch lib/$(name)/data/repo/$(name)_repo_impl.dart
	@touch lib/$(name)/domain/repo/$(name)_repo.dart
	@echo "✅ Feature '$(name)' created!"
endif

# for bloc 

bloc:
	@if [ -z "$(name)" ]; then echo "Usage: make bloc name=<BlocName>"; exit 1; fi
	@echo "Where do you want to create the $(shell echo $(name) | tr '[:upper:]' '[:lower:]') bloc?"
	@echo "Examples: features/auth, modules/user, blocs, etc."
	@read -p "Location (press enter for 'blocs'): " location; \
	if [ -z "$$location" ]; then \
		location="blocs"; \
	fi; \
	full_path="lib/$$location"; \
	folder_name=$(shell echo $(name) | tr '[:upper:]' '[:lower:]'); \
	mkdir -p "$$full_path/$$folder_name"; \
	echo "part of '$${folder_name}_bloc.dart';" > "$$full_path/$$folder_name/$${folder_name}_event.dart"; \
	echo "" >> "$$full_path/$$folder_name/$${folder_name}_event.dart"; \
	echo "abstract class $(name)Event {}" >> "$$full_path/$$folder_name/$${folder_name}_event.dart"; \
	echo "" >> "$$full_path/$$folder_name/$${folder_name}_event.dart"; \
	echo "class Load$(name) extends $(name)Event {}" >> "$$full_path/$$folder_name/$${folder_name}_event.dart"; \
	echo "part of '$${folder_name}_bloc.dart';" > "$$full_path/$$folder_name/$${folder_name}_state.dart"; \
	echo "" >> "$$full_path/$$folder_name/$${folder_name}_state.dart"; \
	echo "abstract class $(name)State {}" >> "$$full_path/$$folder_name/$${folder_name}_state.dart"; \
	echo "" >> "$$full_path/$$folder_name/$${folder_name}_state.dart"; \
	echo "class $(name)Initial extends $(name)State {}" >> "$$full_path/$$folder_name/$${folder_name}_state.dart"; \
	echo "class $(name)Loading extends $(name)State {}" >> "$$full_path/$$folder_name/$${folder_name}_state.dart"; \
	echo "class $(name)Loaded extends $(name)State {}" >> "$$full_path/$$folder_name/$${folder_name}_state.dart"; \
	echo "class $(name)Error extends $(name)State {}" >> "$$full_path/$$folder_name/$${folder_name}_state.dart"; \
	echo "import 'package:flutter_bloc/flutter_bloc.dart';" > "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "import '../../core/base_bloc.dart'; // Adjust path as needed" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "part '$${folder_name}_event.dart';" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "part '$${folder_name}_state.dart';" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "class $(name)Bloc extends BaseBloc<$(name)Event, $(name)State> {" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "  $(name)Bloc() : super($(name)Initial()) {" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "    on<Load$(name)>(_onLoad$(name));" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "  }" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "  void _onLoad$(name)(Load$(name) event, Emitter<$(name)State> emit) {" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "    emit($(name)Loading());" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "    // Add your logic here" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "    emit($(name)Loaded());" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "  }" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo "}" >> "$$full_path/$$folder_name/$${folder_name}_bloc.dart"; \
	echo " Bloc $(name) created at $$full_path/$$folder_name/"