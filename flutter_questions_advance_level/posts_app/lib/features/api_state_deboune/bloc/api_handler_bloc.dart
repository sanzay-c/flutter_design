import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:posts_app/features/api_state_deboune/api_services.dart';
import 'package:posts_app/features/api_state_handler/model.dart';

part 'api_handler_event.dart';
part 'api_handler_state.dart';

class ApiHandlerBlocDebounce
    extends Bloc<ApiHandlerEvent, ApiHandlerState> {

  final ApiServiceDebounce apiService;

  ApiHandlerBlocDebounce({required this.apiService})
      : super(ApiHandlerInitial()) {
    on<SearchTextChanged>(
      _onSearchTextChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<ApiHandlerState> emit,
  ) async {
    try {
      emit(ApiLoading());
      final apiData = await apiService.fetchData(event.query);
      emit(ApiSuccess(apiData: apiData));
    } catch (e) {
      emit(ApiError(errorMessage: e.toString()));
    }
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) =>
        events.debounceTime(duration).switchMap(mapper);
  }
}
