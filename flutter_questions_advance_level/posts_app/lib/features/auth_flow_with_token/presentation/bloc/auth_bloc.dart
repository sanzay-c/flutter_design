import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/core/storage/secure_storage.dart';
import 'package:posts_app/features/auth_flow_with_token/domain/entity/auth_entity.dart';
import 'package:posts_app/features/auth_flow_with_token/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;

  AuthBloc({required this.authUsecase}) : super(AuthInitial()) {
    on<AppStartedEvent>(_onAppStartedEvent);
    on<LoginRequestedEvent>(_onLoginRequestedEvent);
    on<LogOutRequestedEvent>(_onLogOutRequestedEvent);
  }

  FutureOr<void> _onLoginRequestedEvent(
    LoginRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());
      final auth = await authUsecase(event.usernmae, event.password);
      await SecureStorage.saveToken(auth.accessToken);
      emit(AuthenticatedSate(auth));
    } catch (e) {
      emit(AuthFailureState(error: "ERROR: $e"));
    }
  }

  FutureOr<void> _onLogOutRequestedEvent(
    LogOutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await SecureStorage.clear();
    emit(UnauthenticatedState());
  }

  FutureOr<void> _onAppStartedEvent(
    AppStartedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final token = await SecureStorage.getToken();
    if (token != null) {
      emit(AuthenticatedSate(AuthEntity(accessToken: token, refreshToken: '')));
    } else {
      emit(UnauthenticatedState());
    }
  }
}
