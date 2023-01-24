import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:zig_project/resources/colors_manager.dart';

class SelectImageCard extends StatelessWidget {
  XFile? imageFile;
  String tittle;
  String? url;
  String imgHolder;
  SelectImageCard(
      {super.key,
      this.imageFile,
      required this.tittle,
      this.url,
      required this.imgHolder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: 124,
      child: Column(children: [
        Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 65,
            width: double.infinity,
            child: url != ""
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url!,
                      fit: BoxFit.cover,
                    ))
                : imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(imageFile!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : DottedBorder(
                        color: ColorManager.grey,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        child: Center(child: Image.asset(imgHolder)))),
        const SizedBox(
          height: 3,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.add,
            color: ColorManager.primary,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            tittle,
            style: TextStyle(color: ColorManager.primary, fontSize: 14),
          )
        ])
      ]),
    );
  }
}
