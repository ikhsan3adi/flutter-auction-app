import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/login/login.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _Head(),
          FormFieldTitle(text: "Username"),
          _UsernameField(),
          FormFieldTitle(text: "Password"),
          _PasswordField(),
          _LoginButton(),
          _RegisterText(),
        ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text("LOGIN", style: theme.textTheme.headlineLarge),
              ),
              SizedBox(
                height: 36,
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state.formState.status == FormzSubmissionStatus.failure) {
                      return Text(
                        state.errorMessage ?? 'Unknown error',
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ],
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
              // TODO : goto register page
            },
            style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
            child: const Text("Sign up")),
      ],
    );
  }
}
