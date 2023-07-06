import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/features/update_profile/update_profile.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc({
    required AuthenticationRepository authenticationRepository,
    required TokenRepository tokenRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _tokenRepository = tokenRepository,
        _userRepository = userRepository,
        super(UpdateProfileInitial()) {
    on<FetchUserData>(_fetchUser);
    on<ProfileImageChanged>(_onProfileImageChanged);

    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PhoneChanged>(_onPhoneChanged);

    on<SubmitChanges>(_submit);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final TokenRepository _tokenRepository;

  Future<void> _fetchUser(FetchUserData event, Emitter<UpdateProfileState> emit) async {
    emit(UpdateProfileLoading());

    try {
      final User user = await _userRepository.getUser(event.user.id);

      emit(UpdateProfileLoaded(
        oldProfileImageUrl: user.profileImageUrl,
        formState: UpdateProfileFormState(
          name: Name.dirty(user.name),
          email: Email.dirty(user.email),
          phone: Phone.dirty(user.phone ?? ''),
        ),
        isValid: true,
      ));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
    } on DioError catch (e) {
      emit(UpdateProfileError(message: e.errorsMessages[0]));
    } catch (e) {
      emit(UpdateProfileError(message: e.toString()));
    }
  }

  void _onProfileImageChanged(ProfileImageChanged event, Emitter<UpdateProfileState> emit) {
    final currentState = state as UpdateProfileLoaded;
    emit(currentState.copyWith(profileImagePath: event.imagePath));
  }

  void _onNameChanged(NameChanged event, Emitter<UpdateProfileState> emit) {
    final currentState = state as UpdateProfileLoaded;
    final name = Name.dirty(event.name);
    emit(currentState.copyWith(
      formState: currentState.formState.copyWith(name: name),
      isValid: Formz.validate([
        name,
        currentState.formState.email,
        currentState.formState.phone,
      ]),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<UpdateProfileState> emit) {
    final currentState = state as UpdateProfileLoaded;
    final email = Email.dirty(event.email);
    emit(currentState.copyWith(
      formState: currentState.formState.copyWith(email: email),
      isValid: Formz.validate([
        currentState.formState.name,
        email,
        currentState.formState.phone,
      ]),
    ));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<UpdateProfileState> emit) {
    final currentState = state as UpdateProfileLoaded;
    final phone = Phone.dirty(event.phone);
    emit(currentState.copyWith(
      formState: currentState.formState.copyWith(phone: phone),
      isValid: Formz.validate([
        currentState.formState.name,
        currentState.formState.email,
        phone,
      ]),
    ));
  }

  Future<void> _submit(SubmitChanges event, Emitter<UpdateProfileState> emit) async {
    final currentState = state as UpdateProfileLoaded;
    if (!currentState.isValid || currentState.formState.isNotValid) return;

    try {
      emit(currentState.copyWith(
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.inProgress),
      ));

      final User updatedUser = User(
        username: 'ligma',
        name: currentState.formState.name.value,
        email: currentState.formState.email.value,
        phone: currentState.formState.phone.value,
        profileImageUrl: currentState.profileImagePath,
      );

      await _userRepository.updateUser(updatedUser);

      await _tokenRepository.updateUserData(user: updatedUser);

      return emit(currentState.copyWith(
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.success),
      ));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      emit(currentState.copyWith(
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.failure),
        errorMessage: e.errorsMessages[0],
      ));
    } on DioError catch (e) {
      emit(currentState.copyWith(
        errorMessage: e.errorsMessages[0],
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.failure),
      ));
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: e.toString(),
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.failure),
      ));
    }
  }
}
