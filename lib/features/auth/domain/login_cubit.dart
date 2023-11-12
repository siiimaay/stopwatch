import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/core/injection/locator.dart';

import 'login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  late final LoginService _loginService;

  LoginCubit() : super(LoginState(InitialEvent())) {
    _loginService = getIt<LoginService>();
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      emit(state.copyWith(loginEvent: LoadingEvent()));
      await _loginService.signIn(email, password);
      emit(state.copyWith(loginEvent: SuccessfulLoginEvent()));
    } catch (e) {
      emit(state.copyWith(loginEvent: FailedLoginEvent()));
    }
  }
}

abstract class LoginEvent {}

class InitialEvent extends LoginEvent {}

class SuccessfulLoginEvent extends LoginEvent {}

class LoadingEvent extends LoginEvent {}

class FailedLoginEvent extends LoginEvent {}

class LoginState {
  final LoginEvent loginEvent;

  LoginState(this.loginEvent);

  LoginState copyWith({
    bool? hasError,
    LoginEvent? loginEvent,
  }) {
    return LoginState(loginEvent ?? this.loginEvent);
  }
}
