import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:user_repository/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({
    required UserRepository userRepository,
    required TokenRepository tokenRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _userRepository = userRepository,
        _tokenRepository = tokenRepository,
        _authenticationRepository = authenticationRepository,
        super(UserProfileInitial()) {
    on<FetchUserProfile>(_fetchUser);
  }

  final UserRepository _userRepository;
  final TokenRepository _tokenRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _fetchUser(FetchUserProfile event, Emitter<UserProfileState> emit) async {
    try {
      emit(UserProfileLoading());

      final User? decodedUser = _tokenRepository.token?.getUserInfo();

      if (decodedUser == null) return emit(const UserProfileError(message: 'Invalid access token'));

      final User user = await _userRepository.getUser(decodedUser.id);

      emit(UserProfileLoaded(user: user));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      emit(UserProfileError(message: e.errorsMessages[0]));
    } on DioError catch (e) {
      emit(UserProfileError(message: e.errorsMessages[0]));
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }
}
