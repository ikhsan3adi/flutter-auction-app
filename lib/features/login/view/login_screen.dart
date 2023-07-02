import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/login/login.dart';
import 'package:flutter_online_auction_app/features/register/view/register_page.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Head(),
              _MessageBlock(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormFieldTitle(text: "Username"),
                  _UsernameField(),
                  FormFieldTitle(text: "Password"),
                  _PasswordField(),
                  _LoginButton(),
                  _RegisterText(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Head extends StatelessWidget {
  const _Head();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 8,
      child: Center(
        child: Text("LOGIN", style: theme.textTheme.headlineLarge),
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
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state.formState.status != FormzSubmissionStatus.success) {
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
            }
          } else {
            return TextHighlight(
              code: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Login successful",
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.formState.username != current.formState.username,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<LoginBloc>().add(UsernameChanged(username: value ?? ''));
            },
            errorText: state.formState.username.displayError?.text,
          );
        },
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.formState.password != current.formState.password,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<LoginBloc>().add(PasswordChanged(password: value ?? ''));
            },
            obscureText: true,
            errorText: state.formState.password.displayError?.text,
          );
        },
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => current.formState.status == FormzSubmissionStatus.success,
        listener: (context, state) {
          if (state.formState.status == FormzSubmissionStatus.success) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: 'Successfully logged in');
          }
        },
        builder: (context, state) {
          String btnText = '';

          switch (state.formState.status) {
            case FormzSubmissionStatus.success:
              btnText = 'Success';
              break;
            case FormzSubmissionStatus.inProgress:
              btnText = 'Processing...';
              break;
            case FormzSubmissionStatus.initial:
            default:
              btnText = 'Login';
          }

          return CustomButton(
            onPressed: () => context.read<LoginBloc>().add(LoginRequested()),
            text: btnText,
            disabled: state.formState.status == FormzSubmissionStatus.success || state.formState.status == FormzSubmissionStatus.inProgress,
          );
        },
      ),
    );
  }
}

class _RegisterText extends StatelessWidget {
  const _RegisterText();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed<LoginFormState?>(RegisterPage.routeName).then((value) {
                if (value != null) {
                  context.read<LoginBloc>().add(UsernameChanged(username: value.username.value));
                  context.read<LoginBloc>().add(PasswordChanged(password: value.password.value));
                }
              });
            },
            style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
            child: const Text("Sign up")),
      ],
    );
  }
}
