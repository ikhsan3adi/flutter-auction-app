import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/update_item/bloc/update_item_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart' as picker;

class AddImageCard extends StatelessWidget {
  const AddImageCard({super.key, this.text = "Select images"});

  final String text;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1,
      child: CustomInkWell(
        onTap: () async {
          UpdateItemLoaded state = context.read<UpdateItemBloc>().state as UpdateItemLoaded;

          if (state.formerImages.length + state.newImagesPath.length >= 10) {
            return Fluttertoast.showToast(msg: 'Maximum number of images is 10').ignore();
          }

          picker.ImagePicker imagePicker = picker.ImagePicker();
          List<picker.XFile?> images = await imagePicker.pickMultiImage();

          if (images.isEmpty) return;

          if (context.mounted) {
            context.read<UpdateItemBloc>().add(ItemImagesChanged(
                  imagesPath: images.map((e) => e!.path).toList(),
                ));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image, size: 48, color: theme.colorScheme.onPrimary),
                Text(
                  text,
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
