import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/change_password/bloc/change_password_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MessageBlock(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormFieldTitle(text: "Old password"),
                  _OldPasswordField(),
                  FormFieldTitle(text: "New password"),
                  _NewPasswordField(),
                  FormFieldTitle(text: "Confirm new password"),
                  _ConfirmPasswordField(),
                  _SubmitButton(),
                ],
              ),
            ],
          ),
        ),
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
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          if (state.status != FormzSubmissionStatus.success) {
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
                  "Password changed",
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

class _OldPasswordField extends StatelessWidget {
  const _OldPasswordField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        buildWhen: (previous, current) => previous.oldPassword != current.oldPassword,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<ChangePasswordBloc>().add(OldPasswordChanged(oldPassword: value ?? ''));
            },
            obscureText: true,
            errorText: state.oldPassword.displayError?.text,
          );
        },
      ),
    );
  }
}

class _NewPasswordField extends StatelessWidget {
  const _NewPasswordField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        buildWhen: (previous, current) => previous.newPassword != current.newPassword,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<ChangePasswordBloc>().add(NewPasswordChanged(newPassword: value ?? ''));
            },
            obscureText: true,
            errorText: state.newPassword.displayError?.text,
          );
        },
      ),
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        buildWhen: (p, c) => p.confirmPassword != c.confirmPassword || p.isPasswordMatch != c.isPasswordMatch,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<ChangePasswordBloc>().add(ConfirmPasswordChanged(confirmPassword: value ?? ''));
            },
            obscureText: true,
            errorText: state.confirmPassword.displayError?.text ?? (!state.isPasswordMatch ? 'Password does not match' : null),
          );
        },
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listenWhen: (previous, current) => current.status == FormzSubmissionStatus.success,
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.success) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: 'Password changed');
            Navigator.of(context).pop(true);
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          String btnText = '';

          switch (state.status) {
            case FormzSubmissionStatus.success:
              btnText = 'Success';
              break;
            case FormzSubmissionStatus.inProgress:
              btnText = 'Processing...';
              break;
            case FormzSubmissionStatus.initial:
            default:
              btnText = 'Submit';
          }

          return CustomButton(
            onPressed: () => context.read<ChangePasswordBloc>().add(SubmitChanges()),
            text: btnText,
            disabled: state.status == FormzSubmissionStatus.success || state.status == FormzSubmissionStatus.inProgress,
          );
        },
      ),
    );
  }
}
