import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: SafeArea(
        child: Material(
          child: ListView(
            children: [
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
                  Text("E-AUCTION", style: textTheme.labelMedium),
                  Text("@2023 v0.0.1", style: textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
