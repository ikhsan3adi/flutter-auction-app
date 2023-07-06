import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/update_profile/update_profile.dart';
import 'package:flutter_online_auction_app/features/user_profile/user_profile.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => context.read<UserProfileBloc>().add(FetchUserProfile()),
      child: const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProfileImage(),
            SizedBox(height: 16),
            _UserData(),
            SizedBox(height: 16),
            _EditButton(),
            SizedBox(height: 8),
            _ChangePasswordButton(),
          ],
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileError) {
          return const CircleAvatar(radius: 100, child: ErrorCommon(message: "Error"));
        } else if (state is! UserProfileLoaded) {
          return const ShimmerBasic(child: CircleAvatar(radius: 100));
        }

        bool isset = state.user.profileImageUrl != null && state.user.profileImageUrl!.isNotEmpty;

        return CircleAvatar(
          radius: 100,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          backgroundImage: isset ? NetworkImage(state.user.profileImageUrl!) : null,
          child: !isset ? const Center(child: Text('No profile image')) : null,
        );
      },
    );
  }
}

class _UserData extends StatelessWidget {
  const _UserData();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileError) {
            return SizedBox(
              height: 400,
              child: Center(child: ErrorCommon(message: state.message)),
            );
          }

          bool isLoaded = state is UserProfileLoaded;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const FormFieldTitle(text: "Full name"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: isLoaded ? Text(state.user.name, style: textTheme.bodyLarge) : _textShimmer(),
              ),
              const FormFieldTitle(text: "Email"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: isLoaded ? Text(state.user.email, style: textTheme.bodyLarge) : _textShimmer(),
              ),
              const FormFieldTitle(text: "Username"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: isLoaded ? Text(state.user.username, style: textTheme.bodyLarge) : _textShimmer(),
              ),
              const FormFieldTitle(text: "Password"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: isLoaded ? Text("********", style: textTheme.bodyLarge) : _textShimmer(),
              ),
              const FormFieldTitle(text: "Phone number"),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: isLoaded ? Text(state.user.phone ?? '-', style: textTheme.bodyLarge) : _textShimmer(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _textShimmer() {
    return Builder(builder: (context) {
      TextTheme textTheme = Theme.of(context).textTheme;
      return ShimmerBasic(child: Text("Loading...", style: textTheme.bodyLarge));
    });
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (_, state) {
          if (state is UserProfileError) return const SizedBox();

          return CustomIconButton(
            text: "Edit profile",
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (state is! UserProfileLoaded) return;

              Navigator.of(context).pushNamed(UpdateProfilePage.routeName, arguments: state.user).then((_) {
                context.read<UserProfileBloc>().add(FetchUserProfile());
              });
            },
            disabled: state is! UserProfileLoaded,
          );
        },
      ),
    );
  }
}

class _ChangePasswordButton extends StatelessWidget {
  const _ChangePasswordButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileError) return const SizedBox();

          return CustomIconButton(
            text: "Change password",
            icon: const Icon(Icons.key),
            backgroundColor: ColorPalettes.amberHighlight,
            onPressed: () {
              if (state is! UserProfileLoaded) return;
            },
            disabled: state is! UserProfileLoaded,
          );
        },
      ),
    );
  }
}
