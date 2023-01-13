import 'package:flutter/material.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/resources/value_manager.dart';

class Categoriesutilities {
  static Widget selectVendor(
      {required Function(dynamic) onChanged,
      required String hintText,
      required List vendorList}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: AppPadding.p20),
        child: DropdownButton(
          hint: Text(
            hintText,
            style: getRegularStyle(
                color: ColorManager.primary, fontSize: AppPadding.p16),
          ),
          disabledHint: Text(hintText),
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          // value: selectedValue,
          icon: Icon(
            Icons.arrow_drop_down,
            color: ColorManager.primary,
          ),
          onChanged: onChanged,
          items: vendorList.map<DropdownMenuItem>((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  static Widget subCategoryCard(
      {required String imgPath, required String tittle}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 80,
        child: Column(children: [
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(imgPath, fit: BoxFit.cover)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber,
            ),
            height: 80,
            width: 80,
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Text(tittle,
                style: getRegularStyle(
                    color: ColorManager.darkGrey, fontSize: 14)),
          ),
        ]),
      ),
    );
  }

  static Widget customTile(String tittle, String image) {
    return Container(
      height: 50,
      width: 335,
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: ColorManager.grey,
            )
          ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: AppSize.s14,
            ),
            Text(
              tittle,
              style: TextStyle(fontSize: 16, color: ColorManager.primary),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: AppPadding.p8, left: AppPadding.p8),
              child: Image.asset(AssetsManager.percentTag),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p8, right: AppPadding.p8),
              child: Icon(
                Icons.favorite,
                color: ColorManager.secondary,
              ),
            )
          ],
        )
      ]),
    );
  }
}
