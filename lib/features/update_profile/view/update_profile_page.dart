import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/update_profile/update_profile.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:user_repository/user_repository.dart';

class UpdateProfilePage extends StatelessWidget {
  /// '/update_profile'
  static const String routeName = '/update_profile';

  const UpdateProfilePage({super.key, required this.user});

  static Route<void> route({required User user}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => UpdateProfilePage(user: user),
    );
  }

  final User user;

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = context.read<UserRepository>();
    final TokenRepository tokenRepository = context.read<TokenRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return Scaffold(
      appBar: const MyCustomAppbar(title: "Update Profile"),
      body: BlocProvider(
        create: (context) => UpdateProfileBloc(
          authenticationRepository: authenticationRepository,
          tokenRepository: tokenRepository,
          userRepository: userRepository,
        )..add(FetchUserData(user: user)),
        child: UpdateProfileScreen(user: user),
      ),
    );
  }
}
