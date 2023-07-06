import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/user_profile/user_profile.dart';
import 'package:flutter_online_auction_app/shared/widgets/appbar.dart';
import 'package:user_repository/user_repository.dart';

class UserProfilePage extends StatelessWidget {
  /// '/user_profile'
  static const String routeName = '/user_profile';

  const UserProfilePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const UserProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = context.read<UserRepository>();
    final TokenRepository tokenRepository = context.read<TokenRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return Scaffold(
      appBar: const MyCustomAppbar(title: "User Profile"),
      body: BlocProvider(
        create: (context) => UserProfileBloc(
          userRepository: userRepository,
          tokenRepository: tokenRepository,
          authenticationRepository: authenticationRepository,
        )..add(FetchUserProfile()),
        child: const UserProfileScreen(),
      ),
    );
  }
}
