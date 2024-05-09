import 'dart:io';

import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectAvatarSourceButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function(File? file) onSelect;
  final bool fromGallery;
  const SelectAvatarSourceButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onSelect,
    this.fromGallery = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final image = await ImagePickerUtil.pick(
          fromGallery ? ImageSource.gallery : ImageSource.camera,
        );
        onSelect(image);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(
                width: context.w * 0.02,
              ),
              CustomText(
                text: label,
                textColor: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
