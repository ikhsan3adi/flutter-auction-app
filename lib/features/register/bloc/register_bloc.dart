// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/register/register.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    on<ProfileImageChanged>(_onProfileImageChanged);

    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PhoneChanged>(_onPhoneChanged);

    on<AttemptRegister>(_registerUser);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onProfileImageChanged(ProfileImageChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(profileImagePath: event.imagePath));
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<RegisterState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      formState: state.formState.copyWith(username: username),
      isValid: Formz.validate([
        username,
        state.formState.password,
        state.formState.name,
        state.formState.email,
        state.formState.phone,
      ]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      formState: state.formState.copyWith(password: password),
      isValid: Formz.validate([
        state.formState.username,
        password,
        state.formState.name,
        state.formState.email,
        state.formState.phone,
      ]),
    ));
  }

  void _onNameChanged(NameChanged event, Emitter<RegisterState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      formState: state.formState.copyWith(name: name),
      isValid: Formz.validate([
        state.formState.username,
        state.formState.password,
        name,
        state.formState.email,
        state.formState.phone,
      ]),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      formState: state.formState.copyWith(email: email),
      isValid: Formz.validate([
        state.formState.username,
        state.formState.password,
        state.formState.name,
        email,
        state.formState.phone,
      ]),
    ));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<RegisterState> emit) {
    final phone = Phone.dirty(event.phone);
    emit(state.copyWith(
      formState: state.formState.copyWith(phone: phone),
      isValid: Formz.validate([
        state.formState.username,
        state.formState.password,
        state.formState.name,
        state.formState.email,
        phone,
      ]),
    ));
  }

  Future<void> _registerUser(AttemptRegister event, Emitter<RegisterState> emit) async {
    if (!state.isValid || state.formState.isNotValid) return;

    try {
      emit(state.copyWith(
        formState: state.formState.copyWith(status: FormzSubmissionStatus.inProgress),
      ));

      final User newUser = User(
        username: state.formState.username.value,
        name: state.formState.name.value,
        email: state.formState.email.value,
        phone: state.formState.phone.value,
        profileImageUrl: state.profileImagePath,
      );

      await _authenticationRepository.register(user: newUser, password: state.formState.password.value);

      return emit(state.copyWith(
        formState: state.formState.copyWith(status: FormzSubmissionStatus.success),
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
