part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileLoaded extends UpdateProfileState {
  const UpdateProfileLoaded({
    this.oldProfileImageUrl,
    this.profileImagePath,
    this.formState = const UpdateProfileFormState(
      name: Name.pure(),
      email: Email.pure(),
      phone: Phone.pure(),
    ),
    this.isValid = false,
    this.errorMessage,
  });

  final String? oldProfileImageUrl;
  final String? profileImagePath;
  final UpdateProfileFormState formState;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object> get props => [oldProfileImageUrl ?? String, profileImagePath ?? String, formState, isValid, errorMessage ?? ''];

  UpdateProfileLoaded copyWith({
    String? oldProfileImageUrl,
    String? profileImagePath,
    UpdateProfileFormState? formState,
    bool? isValid,
    String? errorMessage,
  }) {
    return UpdateProfileLoaded(
      oldProfileImageUrl: oldProfileImageUrl ?? this.oldProfileImageUrl,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      formState: formState ?? this.formState,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UpdateProfileError extends UpdateProfileState {
  const UpdateProfileError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
