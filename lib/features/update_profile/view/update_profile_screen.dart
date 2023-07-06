import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/update_profile/update_profile.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
        listenWhen: (p, c) => p is UpdateProfileLoaded && c is UpdateProfileLoaded && p.formState.status != c.formState.status,
        listener: (context, state) {
          if (state is UpdateProfileLoaded) {
            Fluttertoast.cancel();
            if (state.formState.status == FormzSubmissionStatus.success) {
              Fluttertoast.showToast(msg: 'Update successful');
              Navigator.of(context).pop(true);
            } else if (state.formState.status == FormzSubmissionStatus.failure) {
              Fluttertoast.showToast(msg: 'Update failed');
            }
          }
        },
        buildWhen: (p, c) => p.runtimeType != c.runtimeType,
        builder: (context, state) {
          if (state is UpdateProfileError) return _errorWidget(state.message, context);

          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MessageBlock(),
              ProfileImagePicker(),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormFieldTitle(text: "Full name"),
                  _NameField(),
                  FormFieldTitle(text: "Email"),
                  _EmailField(),
                  FormFieldTitle(text: "Phone number"),
                  _PhoneField(),
                  _Button(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _errorWidget(String message, BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ErrorCommon(message: message),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => context.read<UpdateProfileBloc>().add(FetchUserData(user: user)),
            icon: const Icon(Icons.refresh),
            label: const Text('Reload'),
          )
        ],
      ),
    );
  }
}

class _MessageBlock extends StatelessWidget {
  const _MessageBlock();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 16),
      child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
        builder: (context, state) {
          if (state is UpdateProfileLoaded) {
            bool isSuccess = state.formState.status == FormzSubmissionStatus.success;
            if (state.errorMessage != null) {
              return TextHighlight(
                code: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Error: ${state.errorMessage!}",
                    style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              );
            } else if (isSuccess) {
              return TextHighlight(
                code: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Update item successful",
                    style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
        listenWhen: (p, c) => p is UpdateProfileLoading && c is UpdateProfileLoaded,
        listener: (context, state) {
          if (state is UpdateProfileLoaded) controller.value = TextEditingValue(text: state.formState.name.value);
        },
        buildWhen: (p, c) {
          if (p is UpdateProfileLoaded && c is UpdateProfileLoaded) return p.formState.name != c.formState.name;

          return p.runtimeType != c.runtimeType;
        },
        builder: (_, state) {
          if (state is UpdateProfileLoading || state is UpdateProfileInitial) {
            return const ShimmerBasic(child: CustomTextFormField());
          }

          state as UpdateProfileLoaded;

          return CustomTextFormField(
            controller: controller,
            onChanged: (value) {
              context.read<UpdateProfileBloc>().add(NameChanged(name: value ?? ''));
            },
            errorText: state.formState.name.displayError?.text,
          );
        },
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
        listenWhen: (p, c) => p is UpdateProfileLoading && c is UpdateProfileLoaded,
        listener: (context, state) {
          if (state is UpdateProfileLoaded) controller.value = TextEditingValue(text: state.formState.email.value);
        },
        buildWhen: (p, c) {
          if (p is UpdateProfileLoaded && c is UpdateProfileLoaded) return p.formState.email != c.formState.email;

          return p.runtimeType != c.runtimeType;
        },
        builder: (_, state) {
          if (state is UpdateProfileLoading || state is UpdateProfileInitial) {
            return const ShimmerBasic(child: CustomTextFormField());
          }

          state as UpdateProfileLoaded;

          return CustomTextFormField(
            controller: controller,
            onChanged: (value) {
              context.read<UpdateProfileBloc>().add(EmailChanged(email: value ?? ''));
            },
            errorText: state.formState.email.displayError?.text,
          );
        },
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
        listenWhen: (p, c) => p is UpdateProfileLoading && c is UpdateProfileLoaded,
        listener: (context, state) {
          if (state is UpdateProfileLoaded) controller.value = TextEditingValue(text: state.formState.phone.value);
        },
        buildWhen: (p, c) {
          if (p is UpdateProfileLoaded && c is UpdateProfileLoaded) return p.formState.phone != c.formState.phone;

          return p.runtimeType != c.runtimeType;
        },
        builder: (_, state) {
          if (state is UpdateProfileLoading || state is UpdateProfileInitial) {
            return const ShimmerBasic(child: CustomTextFormField());
          }

          state as UpdateProfileLoaded;

          return CustomTextFormField(
            controller: controller,
            onChanged: (value) {
              context.read<UpdateProfileBloc>().add(PhoneChanged(phone: value ?? ''));
            },
            errorText: state.formState.phone.displayError?.text,
          );
        },
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
        builder: (context, state) {
          String btnText = 'Save';

          if (state is UpdateProfileLoaded) {
            switch (state.formState.status) {
              case FormzSubmissionStatus.success:
                btnText = 'Success';
                break;
              case FormzSubmissionStatus.inProgress:
                btnText = 'Processing...';
                break;
              case FormzSubmissionStatus.initial:
              default:
                btnText = 'Save';
            }
          }

          return CustomButton(
            onPressed: () {
              if (state is UpdateProfileLoaded) {
                context.read<UpdateProfileBloc>().add(SubmitChanges());
              }
            },
            text: btnText,
            disabled: state is! UpdateProfileLoaded ||
                state.formState.status == FormzSubmissionStatus.success ||
                state.formState.status == FormzSubmissionStatus.inProgress,
          );
        },
      ),
    );
  }
}
