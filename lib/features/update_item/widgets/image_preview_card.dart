import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/update_item/bloc/update_item_bloc.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    this.imagePath,
    required this.index,
    this.image,
  });

  final String? imagePath;
  final int index;
  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      alignment: Alignment.topRight,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: image ?? FileImage(File(imagePath ?? '')),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: IconButton.filled(
            onPressed: () => context.read<UpdateItemBloc>().add(ItemImageDelete(index: index)),
            icon: const Icon(Icons.delete),
            style: IconButton.styleFrom(backgroundColor: theme.colorScheme.error),
          ),
        ),
      ],
    );
  }
}
