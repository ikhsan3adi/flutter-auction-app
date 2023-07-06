import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';
import 'package:flutter_online_auction_app/features/user_profile/user_profile.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_repository/user_repository.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    User? user = context.watch<TokenRepository>().token?.userData;

    return Drawer(
      child: SafeArea(
        child: Material(
          child: ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 32,
                  backgroundImage: user?.profileImageUrl != null ? NetworkImage(user?.profileImageUrl ?? '') : null,
                  child: user?.profileImageUrl == null ? Text(user?.name.split('')[0] ?? 'U') : null,
                ),
                title: Text(user?.name ?? 'Unknown user', style: textTheme.headlineSmall),
                subtitle: Text(user?.username ?? ''),
                onTap: () {
                  Navigator.of(context).pushNamed(UserProfilePage.routeName);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text("Dark theme"),
                trailing: BlocBuilder<AppThemeCubit, AppThemeState>(
                  builder: (context, state) {
                    return Switch.adaptive(
                      value: state.themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        context.read<AppThemeCubit>().themeChanged(value ? ThemeMode.dark : ThemeMode.light);
                      },
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) => const ConfirmDialog(),
                  ).then((logout) {
                    if (logout ?? false) {
                      Fluttertoast.showToast(msg: 'Processing...');
                      context.read<AuthBloc>().add(AuthLogoutRequestedEvent());
                    }
                  });
                },
              ),
              const Divider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("E-AUCTION by @ikhsan3adi", style: textTheme.labelMedium),
                  Text("@2023", style: textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
