import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zig_project/main.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/resources/value_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isFavoriteCategory = true;
  bool isListView = true;
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
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
  List list = [
    "Vendor 1",
    "Vendor 2",
    "Vendor 3",
    "Vendor 4",
    "Vendor 5",
  ];
  var selectedValue = "Vendor 1";
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
            SizedBox(
              height: 10,
            ),
            _buildWidget1(),
            _selectVendor(),
            isListView ? _listView() : _gridView()
          ],
        ),
      ),
    );
  }

  Widget _buildWidget1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (isFavoriteCategory)
                    ;
                  else
                    isFavoriteCategory = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: isFavoriteCategory
                        ? ColorManager.primary
                        : ColorManager.lightGreen,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular((15)))),
                width: 130,
                height: 30,
                child: Center(
                  child: Text("Your Favorite",
                      style: getRegularStyle(
                          color: isFavoriteCategory
                              ? ColorManager.white
                              : ColorManager.primary,
                          fontSize: AppSize.s16)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (isFavoriteCategory) isFavoriteCategory = false;
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: isFavoriteCategory
                          ? ColorManager.lightGreen
                          : ColorManager.primary,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular((15)))),
                  width: 130,
                  height: 30,
                  child: Center(
                    child: Text(
                      "All Categories",
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
          onTap: () {
            setState(() {
              if (isListView)
                ;
              else
                isListView = true;
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: isListView ? ColorManager.black : ColorManager.white,
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s4)),
                  border: Border.all(
                      color:
                          isListView ? ColorManager.black : ColorManager.grey,
                      width: 1.5)),
              child: Icon(
                Icons.list,
                color: isListView ? ColorManager.white : ColorManager.grey,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: AppPadding.p18),
          child: InkWell(
            onTap: () {
              setState(() {
                if (isListView)
                  isListView = false;
                else
                  ;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: isListView ? ColorManager.white : ColorManager.black,
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s4)),
                    border: Border.all(
                        color:
                            isListView ? ColorManager.grey : ColorManager.black,
                        width: 1.5)),
                child: Icon(
                  Icons.grid_view_rounded,
                  color: isListView ? ColorManager.grey : ColorManager.white,
                )),
          ),
        ),
      ],
    );
  }

  Widget _selectVendor() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: AppPadding.p20),
        child: DropdownButton(
          hint: Text(
            "Select Vendors",
            style: getRegularStyle(
                color: ColorManager.primary, fontSize: AppPadding.p16),
          ),
          disabledHint: Text("Select Vendors"),
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          // value: selectedValue,
          icon: Icon(
            Icons.arrow_drop_down,
            color: ColorManager.primary,
          ),
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
          items: list.map<DropdownMenuItem>((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _listView() {
    return Container(
      child: ListView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: _scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: categoryList.length,
          itemBuilder: ((context, index) {
            if (index == 4) {
              return Column(
                children: [
                  _advertisement(),
                ],
              );
            } else {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppPadding.p20, 5, AppPadding.p20, 5),
                  child: _customTile(
                      categoryList[index], AssetsManager.fruitImage));
            }
          })),
    );
  }

  Widget _gridView() {
    return Container(
      child: ListView.builder(
          controller: _scrollController2,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: categoryList.length,
          itemBuilder: ((context, index) {
            if (index == 4) {
              return _advertisement();
            } else {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: _customGrid(categoryList[index]));
            }
          })),
    );
  }

  Widget _customTile(String tittle, String image) {
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

  Widget _customGrid(String tittle) {
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p20, right: AppPadding.p20),
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
        Container(
          width: MediaQuery.of(context).size.width,
          height: 135,
          child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: subCategoryList.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == subCategoryList.length) {
                  return Container(
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
                return _grid(subCategoryList[index], imageList[index]);
              }),
        ),
      ]),
    );
  }

  Widget _grid(String tittle, String imgPath) {
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

  Widget _advertisement() {
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
