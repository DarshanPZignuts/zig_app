import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';

class CommonWidgets {
  static getTextInputField(
      {required TextEditingController controller,
      required String? Function(String?) validator,
      required String lable,
      required bool isEnable,
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
        decoration:
            loyaltyCardTextInputDecoration(lable: lable, isEnable: isEnable),
      ),
    );
  }

  static Widget commonMatrialButton({
    required BuildContext context,
    required Function() onTap,
    required String buttonText,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorManager.primary),
        fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  static getDropDownFormField({
    String? selectedvendor,
    required List list,
    required Function(dynamic) onChanged,
    required bool isEnable,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: DropdownButtonFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == "" || !list.contains(value)) {
            return "Remaining to select vendor";
          }
          return null;
        },
        style: TextStyle(color: ColorManager.darkGrey, fontSize: 16),
        decoration: loyaltyCardTextInputDecoration(
            lable: "Select vendor", isEnable: isEnable),
        value: selectedvendor != "" ? selectedvendor : null,
        items: list.map<DropdownMenuItem>((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: isEnable ? onChanged : null,
      ),
    );
  }

  static InputDecoration loyaltyCardTextInputDecoration(
      {required String lable,
      bool isVendorField = false,
      required bool isEnable}) {
    return InputDecoration(
        enabled: isEnable,
        alignLabelWithHint: true,
        floatingLabelStyle: TextStyle(color: ColorManager.secondary),
        labelStyle: const TextStyle(color: ColorManager.grey),
        suffixIconColor: ColorManager.secondary,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            borderSide: const BorderSide(color: ColorManager.grey)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.secondary)));
  }

  static showSnakbar(BuildContext snackbarContext, String content) {
    return ScaffoldMessenger.of(snackbarContext)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  static Widget chooseImageCard(
      {XFile? imageFile,
      required String tittle,
      String? url,
      required String imgHolder}) {
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
                          File(imageFile.path),
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

  static Widget advertisement(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: CarouselSlider(
        items: [AssetsManager.drinkImage, AssetsManager.fruitImage].map((e) {
          return Builder(builder: ((context) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset(
                  e,
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

  static Widget commonTextInputField(
      {required String label,
      required bool isPassword,
      required TextEditingController controller,
      required bool obscureText,
      Function()? suffixAction,
      required bool showPassword,
      required bool showConfirmPassword,
      required String? Function(String? s) validate,
      bool? isLastField,
      bool? isConfirmPassword}) {
    return SizedBox(
        height: 80,
        width: 320,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validate,
            cursorColor: ColorManager.primary,
            cursorHeight: 20,
            style: TextStyle(color: ColorManager.primary),
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorManager.primary),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: suffixAction,
                      icon: Icon(
                          isConfirmPassword == null
                              ? showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility
                              : showConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                          color: Colors.grey.shade500))
                  : null,
              label: Text(
                label,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
              ),
            ),
            textInputAction: isLastField == null
                ? TextInputAction.next
                : TextInputAction.done,
          ),
        ));
  }
}
