import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/features/api_state_handler/api_service.dart';
import 'package:posts_app/features/api_state_handler/model.dart';

part 'api_handler_event.dart';
part 'api_handler_state.dart';

class ApiHandlerBloc extends Bloc<ApiHandlerEvent, ApiHandlerState> {
  final ApiService apiService;
  ApiHandlerBloc(this.apiService) : super(ApiHandlerInitial()) {
    on<FetchData>(_onFetchData);
    on<RetryFetch>(_onRetryFetch);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<ApiHandlerState> emit) async {
    try {
      emit(ApiLoading());
      final data = await apiService.fetchData();
      emit(ApiLoaded(apiData: data));
    } catch (e) {
      emit(ApiError(errorMessage: "Error: ${e}"));
    }
  }

  FutureOr<void> _onRetryFetch(RetryFetch event, Emitter<ApiHandlerState> emit) async {

  }
}
