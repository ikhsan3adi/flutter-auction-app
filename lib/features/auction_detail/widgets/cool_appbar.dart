import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoolAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoolAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AppbarCubit, AppbarState>(
      builder: (context, state) {
        if (state is AppbarChanged) {
          return AppBar(
            title: Text(
              "Detail",
              style: textTheme.headlineMedium?.copyWith(
                color: state.foregroundColor,
                shadows: [
                  Shadow(
                    blurRadius: 1,
                    offset: const Offset(1, 1),
                    color: state.shadowText,
                  ),
                ],
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: state.foregroundColor,
              ),
            ),
            centerTitle: false,
            backgroundColor: state.backgroundColor,
            elevation: state.elevation,
          );
        } else {
          return AppBar(
            title: Text("Detail", style: textTheme.labelLarge?.copyWith(color: Colors.black87)),
            centerTitle: false,
            elevation: 0,
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
