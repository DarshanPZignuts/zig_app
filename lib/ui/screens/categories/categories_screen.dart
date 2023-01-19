import 'package:flutter/material.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/value_manager.dart';
import 'package:zig_project/ui/screens/categories/categories_utilities.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isFavoriteCategory = true;
  bool isListView = true;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  List categoryList = [
    "Home & Kitchen",
    "Drinks",
    "Home & Kitchen",
    "Drinks",
    "Add",
    "Home & Kitchen",
    "Drinks",
    "Home & Kitchen",
    "Drinks",
  ];
  List subCategoryList = [
    "Drinks",
    "Fruits & Vegetables",
    "Meat products",
    "Fizzi drinks",
    "Drinks",
    "Fruits & Vegetables",
    "Meat products",
    "Fizzi drinks",
  ];
  List imageList = [
    AssetsManager.drinkImage,
    AssetsManager.vegetableImage,
    AssetsManager.meatImage,
    AssetsManager.fizzyDrinkImage,
    AssetsManager.drinkImage,
    AssetsManager.vegetableImage,
    AssetsManager.meatImage,
    AssetsManager.fizzyDrinkImage,
  ];
  List vendorList = [
    "Vendor 1",
    "Vendor 2",
    "Vendor 3",
    "Vendor 4",
    "Vendor 5",
  ];
  var selectedValue = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        foregroundColor: ColorManager.darkGrey,
        leading: const Padding(
          padding: EdgeInsets.only(left: AppPadding.p20, right: AppPadding.p14),
          child: Icon(Icons.arrow_back),
        ),
        leadingWidth: 40,
        title: const SizedBox(
          child: Text(StringManager.categoryPageTittle,
              style: TextStyle(
                  color: ColorManager.black, fontWeight: FontWeight.w800)),
        ),
        actions: const [
          Padding(
            padding:
                EdgeInsets.only(right: AppPadding.p10, left: AppPadding.p10),
            child: Icon(Icons.search),
          ),
          Padding(
            padding:
                EdgeInsets.only(right: AppPadding.p20, left: AppPadding.p10),
            child: Icon(Icons.qr_code),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Categoriesutilities.filterBar(
              isFavoriteCategory: isFavoriteCategory,
              isListView: isListView,
              onFavorite: () {
                setState(() {
                  if (isFavoriteCategory) {
                  } else {
                    isFavoriteCategory = true;
                  }
                });
              },
              onAllCategory: () {
                setState(() {
                  if (isFavoriteCategory) isFavoriteCategory = false;
                });
              },
              onListView: () {
                setState(() {
                  if (isListView) {
                  } else {
                    isListView = true;
                  }
                });
              },
              onGridView: () {
                setState(() {
                  if (isListView) {
                    isListView = false;
                  } else {}
                });
              },
            ),
            Categoriesutilities.selectVendor(
                selectedValue: selectedValue,
                hintText: "Select Vendor",
                onChanged: (p0) {
                  setState(() {
                    selectedValue = p0;
                  });
                },
                vendorList: vendorList),
            isListView
                ? Categoriesutilities.listView(categoryList, _scrollController)
                : Categoriesutilities.gridView(
                    scrollController: _scrollController2,
                    categoryList: categoryList,
                    subCategoryList: subCategoryList,
                    imageList: imageList)
          ],
        ),
      ),
    );
  }
}
