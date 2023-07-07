import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const ChangePasswordState()) {
    on<OldPasswordChanged>(_oldPasswordChanged);
    on<NewPasswordChanged>(_newPasswordChanged);
    on<ConfirmPasswordChanged>(_confirmPasswordChanged);
    on<SubmitChanges>(_submit);
  }

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  void _oldPasswordChanged(OldPasswordChanged event, Emitter<ChangePasswordState> emit) {
    final oldPassword = Password.dirty(event.oldPassword);
    emit(state.copyWith(
      oldPassword: oldPassword,
      isValid: Formz.validate([oldPassword, state.newPassword, state.confirmPassword]),
    ));
  }

  void _newPasswordChanged(NewPasswordChanged event, Emitter<ChangePasswordState> emit) {
    final newPassword = Password.dirty(event.newPassword);
    bool isMatch = event.newPassword == state.confirmPassword.value;
    emit(state.copyWith(
      newPassword: newPassword,
      isValid: Formz.validate([state.oldPassword, newPassword, state.confirmPassword]),
      isPasswordMatch: isMatch,
    ));
  }

  void _confirmPasswordChanged(ConfirmPasswordChanged event, Emitter<ChangePasswordState> emit) {
    final confirmPassword = Password.dirty(event.confirmPassword);
    bool isMatch = event.confirmPassword == state.newPassword.value;
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      isValid: Formz.validate([state.oldPassword, state.newPassword, confirmPassword]),
      isPasswordMatch: isMatch,
    ));
  }

  Future<void> _submit(SubmitChanges event, Emitter<ChangePasswordState> emit) async {
    if (!state.isValid || !state.isPasswordMatch) return;

    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      await _userRepository.changePassword(
        oldPassword: state.oldPassword.value,
        newPassword: state.newPassword.value,
      );

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.errorsMessages[0],
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.errorsMessages[0],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
