part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserData extends UpdateProfileEvent {
  const FetchUserData({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class ProfileImageChanged extends UpdateProfileEvent {
  const ProfileImageChanged({required this.imagePath});

  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

class UsernameChanged extends UpdateProfileEvent {
  const UsernameChanged({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class NameChanged extends UpdateProfileEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class EmailChanged extends UpdateProfileEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PhoneChanged extends UpdateProfileEvent {
  const PhoneChanged({required this.phone});

  final String phone;

  @override
  List<Object> get props => [phone];
}

class SubmitChanges extends UpdateProfileEvent {}
