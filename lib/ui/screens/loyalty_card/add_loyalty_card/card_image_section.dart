import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/ui/widgets/common_widgets.dart';

class ImageSection extends StatefulWidget {
  Function(File) backImgSelect;
  Function(File) frontImgSelect;
  String? frontURL;
  String? backURL;
  bool isEnable;

  ImageSection({
    Key? key,
    required this.backImgSelect,
    required this.frontImgSelect,
    required this.backURL,
    required this.frontURL,
    required this.isEnable,
  }) : super(key: key);

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  final ImagePicker _picker = ImagePicker();
  XFile? frontCardId;
  XFile? backCardId;
  String? frontURL;
  String? backURL;
  @override
  void initState() {
    setState(() {
      frontURL = widget.frontURL;
      backURL = widget.backURL;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        InkWell(
            onTap: widget.isEnable
                ? () async {
                    final img = await _picker.pickImage(
                        source: ImageSource.camera,
                        preferredCameraDevice: CameraDevice.rear);
                    setState(() {
                      frontURL = "";
                      frontCardId = img;
                      widget.frontImgSelect(File(frontCardId!.path));
                    });
                  }
                : null,
            child: CommonWidgets.chooseImageCard(
                imgHolder: AssetsManager.frontIdIcon,
                tittle: StringManager.chooseCardFront,
                imageFile: frontCardId,
                url: frontURL)),
        InkWell(
          onTap: widget.isEnable
              ? () async {
                  final img = await _picker.pickImage(
                      source: ImageSource.camera,
                      preferredCameraDevice: CameraDevice.rear);
                  setState(() {
                    backURL = "";
                    backCardId = img;
                    widget.backImgSelect(File(backCardId!.path));
                  });
                }
              : null,
          child: CommonWidgets.chooseImageCard(
              imgHolder: AssetsManager.backIdIcon,
              tittle: StringManager.chooseCardBack,
              imageFile: backCardId,
              url: backURL),
        )
      ]),
    );
  }
}
