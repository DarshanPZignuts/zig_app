import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';

class CommonWidgets {
  static getTextInputField(
      {required TextEditingController controller,
      required String? Function(String?) validator,
      required String lable,
      int maxLine = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        maxLines: maxLine,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        textInputAction: TextInputAction.next,
        cursorColor: ColorManager.secondary,
        decoration: loyaltyCardTextInputDecoration(lable: lable),
      ),
    );
  }

  static getDropDownFormField(
      {required List list,
      required Function(dynamic) onChanged,
      required String hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: DropdownButtonFormField(
        hint: Text(hint),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == "" || list.indexOf(value) == -1) {
            return "Remaining to select vendor";
          }
        },
        focusNode: FocusNode(descendantsAreTraversable: true),
        style: TextStyle(color: ColorManager.darkGrey, fontSize: 16),
        decoration: loyaltyCardTextInputDecoration(lable: "Select vendor"),
        items: list.map<DropdownMenuItem>((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  static InputDecoration loyaltyCardTextInputDecoration(
      {required String lable, bool isVendorField = false}) {
    return InputDecoration(
        alignLabelWithHint: true,
        floatingLabelStyle: TextStyle(color: ColorManager.secondary),
        labelStyle: TextStyle(color: ColorManager.grey),
        suffixIconColor: ColorManager.secondary,
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        label: Text(
          lable,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.secondary)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.grey)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.secondary)));
  }

  static Widget chooseImageCard({XFile? imageFile, required String tittle}) {
    return Container(
      height: 96,
      width: 124,
      child: Column(children: [
        DottedBorder(
          color: ColorManager.grey,
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 65,
              width: double.infinity,
              child: imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(imageFile.path),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(AssetsManager.frontIdIcon)),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.add,
              color: ColorManager.primary,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              tittle,
              style: TextStyle(color: ColorManager.primary, fontSize: 14),
            )
          ]),
        )
      ]),
    );
  }

  static Widget advertisement(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: CarouselSlider(
        items: [AssetsManager.drinkImage, AssetsManager.fruitImage].map((e) {
          return Builder(builder: ((context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset(
                  '$e',
                  fit: BoxFit.cover,
                ));
          }));
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
        ),
      ),
    );
  }
}
