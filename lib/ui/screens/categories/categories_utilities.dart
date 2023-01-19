import 'package:flutter/material.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/resources/value_manager.dart';
import 'package:zig_project/ui/widgets/common_widgets.dart';

class Categoriesutilities {
  static Widget selectVendor(
      {required Function(dynamic) onChanged,
      required String hintText,
      required String? selectedValue,
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
          value: selectedValue,
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
      child: SizedBox(
        height: 110,
        width: 80,
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber,
            ),
            height: 80,
            width: 80,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.asset(imgPath, fit: BoxFit.cover)),
          ),
          const SizedBox(
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

  static Widget filterBar({
    required Function() onFavorite,
    required Function() onAllCategory,
    required Function() onListView,
    required Function() onGridView,
    required bool isFavoriteCategory,
    required bool isListView,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            InkWell(
              onTap: onFavorite,
              child: Container(
                decoration: BoxDecoration(
                    color: isFavoriteCategory
                        ? ColorManager.primary
                        : ColorManager.lightGreen,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular((15)))),
                width: 130,
                height: 40,
                child: Center(
                  child: Text(StringManager.yourFavoriteText,
                      style: getRegularStyle(
                          color: isFavoriteCategory
                              ? ColorManager.white
                              : ColorManager.primary,
                          fontSize: AppSize.s16)),
                ),
              ),
            ),
            InkWell(
              onTap: onAllCategory,
              child: Container(
                  decoration: BoxDecoration(
                      color: isFavoriteCategory
                          ? ColorManager.lightGreen
                          : ColorManager.primary,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular((15)))),
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      StringManager.allCategoryText,
                      style: getRegularStyle(
                          color: isFavoriteCategory
                              ? ColorManager.primary
                              : ColorManager.white,
                          fontSize: AppSize.s16),
                    ),
                  )),
            ),
          ],
        ),
        InkWell(
          onTap: onListView,
          child: Container(
              decoration: BoxDecoration(
                  color: isListView ? ColorManager.black : ColorManager.white,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppSize.s4)),
                  border: Border.all(
                      color:
                          isListView ? ColorManager.black : ColorManager.grey,
                      width: 1.5)),
              child: Icon(
                Icons.list,
                size: 30,
                color: isListView ? ColorManager.white : ColorManager.grey,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: AppPadding.p18),
          child: InkWell(
            onTap: onGridView,
            child: Container(
                decoration: BoxDecoration(
                    color: isListView ? ColorManager.white : ColorManager.black,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s4)),
                    border: Border.all(
                        color:
                            isListView ? ColorManager.grey : ColorManager.black,
                        width: 1.5)),
                child: Icon(
                  size: 30,
                  Icons.grid_view_rounded,
                  color: isListView ? ColorManager.grey : ColorManager.white,
                )),
          ),
        ),
      ],
    );
  }

  static Widget customTile(String tittle, String image) {
    return Container(
      height: 50,
      width: 335,
      decoration: const BoxDecoration(
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
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
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

  static Widget listView(List categoryList, ScrollController scrollController) {
    return ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: categoryList.length,
        itemBuilder: ((context, index) {
          if (index == 4) {
            return CommonWidgets.advertisement(context);
          } else {
            return Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppPadding.p20, 5, AppPadding.p20, 5),
                child: Categoriesutilities.customTile(
                    categoryList[index], AssetsManager.fruitImage));
          }
        }));
  }

  static Widget gridView(
      {required List categoryList,
      required List subCategoryList,
      required List imageList,
      required ScrollController scrollController}) {
    return ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: categoryList.length,
        itemBuilder: ((context, index) {
          if (index == 4) {
            return CommonWidgets.advertisement(context);
          } else {
            return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: customGrid(
                    tittle: categoryList[index],
                    context: context,
                    imageList: imageList,
                    subCategoryList: subCategoryList));
          }
        }));
  }

  static Widget customGrid(
      {required String tittle,
      required BuildContext context,
      required List imageList,
      required List subCategoryList}) {
    return Column(children: [
      Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p20, right: AppPadding.p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tittle,
              style: TextStyle(
                  fontSize: AppSize.s18,
                  color: ColorManager.primary,
                  fontWeight: FontWeight.bold),
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
                      right: AppPadding.p8, left: AppPadding.p8),
                  child: Icon(
                    Icons.favorite,
                    color: ColorManager.secondary,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 135,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: subCategoryList.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == subCategoryList.length) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 25),
                  height: 110,
                  width: 80,
                  child: Center(
                      child: Text(
                    "More>>",
                    style: TextStyle(
                        color: ColorManager.primary,
                        fontWeight: FontWeightManager.bold,
                        fontSize: FontSize.s18),
                  )),
                );
              }
              return Categoriesutilities.subCategoryCard(
                  tittle: subCategoryList[index], imgPath: imageList[index]);
            }),
      ),
    ]);
  }
}
