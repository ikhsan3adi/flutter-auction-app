import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_online_auction_app/features/login/login.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginRequested>(_login);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      formState: state.formState.copyWith(username: username),
      isValid: Formz.validate([username, state.formState.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      formState: state.formState.copyWith(password: password),
      isValid: Formz.validate([state.formState.username, password]),
    ));
  }

  Future<void> _login(LoginRequested event, Emitter<LoginState> emit) async {
    // if (!state.isValid || state.formState.isNotValid) return;

    try {
      emit(state.copyWith(
        formState: state.formState.copyWith(status: FormzSubmissionStatus.inProgress),
      ));

      final String? token = await _authenticationRepository.login(
        username: state.formState.username.value,
        password: state.formState.password.value,
      );

      if (token != null) {
        _authenticationRepository.changeAuthStatus(status: Authenticated(accessToken: token));
        return emit(state.copyWith(
          formState: state.formState.copyWith(status: FormzSubmissionStatus.success),
        ));
      }
      return emit(state.copyWith(
        errorMessage: 'Failed to retrieve token',
        formState: state.formState.copyWith(status: FormzSubmissionStatus.failure),
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
        errorMessage: e.errorsMessages[0],
        formState: state.formState.copyWith(status: FormzSubmissionStatus.failure),
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        formState: state.formState.copyWith(status: FormzSubmissionStatus.failure),
      ));
    }
  }
}
