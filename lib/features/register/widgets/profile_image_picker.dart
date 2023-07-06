import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/register/register.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:formz/formz.dart';

import 'package:image_picker/image_picker.dart' as picker;

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) => previous.profileImagePath != current.profileImagePath,
          builder: (context, state) {
            bool isset = state.profileImagePath != null && (state.profileImagePath ?? '').isNotEmpty;
            return CustomInkWell(
              onTap: () async {
                if (state.formState.status == FormzSubmissionStatus.inProgress || state.formState.status == FormzSubmissionStatus.success) return;

                picker.ImageSource? imageSource = await _showImageSourceDialog(context);

                if (imageSource == null) return;

                picker.ImagePicker imagePicker = picker.ImagePicker();
                picker.XFile? image = await imagePicker.pickImage(source: imageSource);

                if (image == null) return;

                if (context.mounted) {
                  context.read<RegisterBloc>().add(ProfileImageChanged(imagePath: image.path));
                }
              },
              child: CircleAvatar(
                radius: 100,
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                backgroundImage: isset ? FileImage(File(state.profileImagePath!)) : null,
                child: !isset ? const Center(child: Text('Select profile image')) : null,
              ),
            );
          },
        ),
      ],
    );
  }

  Future<picker.ImageSource?> _showImageSourceDialog(BuildContext context) {
    return showDialog<picker.ImageSource?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInkWell(
                onTap: () => Navigator.of(context).pop<picker.ImageSource>(picker.ImageSource.gallery),
                child: const ListTile(
                  title: Text("Gallery"),
                  leading: CircleAvatar(child: Icon(Icons.photo_library_outlined)),
                ),
              ),
              CustomInkWell(
                onTap: () => Navigator.of(context).pop<picker.ImageSource>(picker.ImageSource.camera),
                child: const ListTile(
                  title: Text("Camera"),
                  leading: CircleAvatar(child: Icon(Icons.camera)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
