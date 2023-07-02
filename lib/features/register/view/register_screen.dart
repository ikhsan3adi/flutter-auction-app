import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/login/models/login_form_state.dart';
import 'package:flutter_online_auction_app/features/register/register.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
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
              FormFieldTitle(text: "Username"),
              _UsernameField(),
              FormFieldTitle(text: "Password"),
              _PasswordField(),
              FormFieldTitle(text: "Phone number"),
              _PhoneField(),
              _SignUpButton(),
              _LoginText(),
            ],
          ),
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
      child: BlocBuilder<RegisterBloc, RegisterState>(
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
                  "Sign up successful",
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

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.formState.name != current.formState.name,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<RegisterBloc>().add(NameChanged(name: value ?? ''));
            },
            hintText: 'Tempe Goreng',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.formState.email != current.formState.email,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<RegisterBloc>().add(EmailChanged(email: value ?? ''));
            },
            hintText: 'example@email.com',
            errorText: state.formState.email.displayError?.text,
          );
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
      child: BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.formState.username != current.formState.username,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<RegisterBloc>().add(UsernameChanged(username: value ?? ''));
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
      child: BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.formState.password != current.formState.password,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<RegisterBloc>().add(PasswordChanged(password: value ?? ''));
            },
            obscureText: true,
            errorText: state.formState.password.displayError?.text,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.formState.phone != current.formState.phone,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<RegisterBloc>().add(PhoneChanged(phone: value ?? ''));
            },
            hintText: '+62 812345',
            errorText: state.formState.phone.displayError?.text,
            isNumberInput: true,
          );
        },
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listenWhen: (previous, current) => current.formState.status == FormzSubmissionStatus.success,
        listener: (context, state) {
          if (state.formState.status == FormzSubmissionStatus.success) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: 'Successfully registered');
            Navigator.of(context).pop<LoginFormState?>(
              LoginFormState(
                username: state.formState.username,
                password: state.formState.password,
              ),
            );
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
              btnText = 'Sign Up';
          }

          return CustomButton(
            onPressed: () => context.read<RegisterBloc>().add(AttemptRegister()),
            text: btnText,
            disabled: state.formState.status == FormzSubmissionStatus.success || state.formState.status == FormzSubmissionStatus.inProgress,
          );
        },
      ),
    );
  }
}

class _LoginText extends StatelessWidget {
  const _LoginText();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
          child: const Text("Login"),
        ),
      ],
    );
  }
}
