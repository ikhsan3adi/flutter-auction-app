import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

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
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {},
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
