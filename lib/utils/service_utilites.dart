import 'package:flutter/material.dart';

import 'package:zig_project/model/response/language.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/user_preferences/global_variables.dart';

import '../bloc/api_constants.dart';

class ServiceUtils {
  static printLog(String msg) {
    if (APIConstants.isDebug) {
      print(msg);
    }
  }

  static showErrorMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: getRegularStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade600,
      elevation: 0,
      duration: const Duration(seconds: 2),
    ));
  }

  // languageList for Localization
  static List<Language> languageList = [
    Language(
        name: 'English',
        langCode: 'en',
        image: AssetsManager.backIdIcon,
        isChecked: true),
    Language(
        name: 'Arabic',
        langCode: 'ar',
        image: AssetsManager.backIdIcon,
        isChecked: false)
  ];

  getHeaderWithBackArrowAndTitle(BuildContext context, String title,
      void Function() onBackClick, String lngCode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onBackClick,
          child: SizedBox(
            height: 21,
            width: 21,
            child: Image.asset(
              lngCode == LanguageCode.languageCodeArabic
                  ? AssetsManager.backIdIcon
                  : AssetsManager.backIdIcon,
              fit: BoxFit.fitHeight,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: getSemiBoldStyle(fontSize: 18, color: ColorManager.black),
        ),
      ],
    );
  }
}
