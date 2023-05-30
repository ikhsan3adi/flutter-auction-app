// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:user_repository/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(RegisterInitial()) {
    on<AttemptRegister>(_registerUser);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _registerUser(AttemptRegister event, Emitter<RegisterState> emit) async {
    try {
      emit(RegisterLoading());
      await _authenticationRepository.register(user: event.newUser);
      emit(RegisterSuccess());
    } on DioError catch (e) {
      emit(RegisterFailure(errors: e.errorsMessages));
    } catch (e) {
      emit(RegisterFailure(errors: [e.toString()]));
    }
  }
}
