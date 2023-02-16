import 'package:aplikasi_lelang_online/features/auction_detail/auction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoolAppBar extends StatelessWidget with PreferredSizeWidget {
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
              style: textTheme.labelLarge?.copyWith(
                color: state.foregroundColor,
                shadows: [
                  Shadow(
                    blurRadius: 1,
                    offset: const Offset(2, 2),
                    color: state.shadowText,
                  ),
                ],
              ),
            ),
            centerTitle: false,
            foregroundColor: state.foregroundColor,
            backgroundColor: state.backgroundColor,
            elevation: state.elevation,
          );
        } else {
          return AppBar(
            title: Text("Detail", style: textTheme.labelLarge?.copyWith(color: Colors.black87)),
            centerTitle: false,
            foregroundColor: Colors.black87,
            backgroundColor: Colors.white,
            elevation: 0,
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
