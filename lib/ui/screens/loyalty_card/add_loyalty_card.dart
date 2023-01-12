import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/services/storage_service.dart';

bool isLoading = false;

class AddLoyaltyCard extends StatefulWidget {
  const AddLoyaltyCard({super.key});

  @override
  State<AddLoyaltyCard> createState() => _AddLoyaltyCardState();
}

class _AddLoyaltyCardState extends State<AddLoyaltyCard> {
  File? frontImg, backImg;
  StorageService _storageService = StorageService();
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: ColorManager.darkGrey,
        // leading: const Padding(
        //   padding: EdgeInsets.only(left: AppPadding.p20, right: AppPadding.p14),
        //   child: Icon(Icons.arrow_back),
        // ),

        title: const SizedBox(
          child: Text("New Card",
              style: TextStyle(
                  color: ColorManager.black, fontWeight: FontWeight.w800)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.all(33),
            child: Text(
              "Scan your card barcode or QR code and enter the following info as you prefer to link it to your card",
              textAlign: TextAlign.center,
              style: getRegularStyle(
                  color: ColorManager.darkGrey, fontSize: FontSize.s14),
            ),
          ),
          Section2(
            backImgSelect: (p0) {
              setState(() {
                backImg = p0;
              });
            },
            frontImgSelect: (p0) {
              setState(() {
                frontImg = p0;
              });
            },
          ),
          FormSection(
            onSaveForm: (p0) async {
              if (frontImg != null && backImg != null) {
                final url =
                    await _storageService.saveImages(frontImg!, backImg!);
                _databaseService.saveCardDetails(
                    onError: (error) {
                      print(error);
                    },
                    onSuccess: () {
                      print('success');
                    },
                    cardName: p0.cardName!,
                    vendor: p0.vendor!,
                    programmeName: p0.programmeName!,
                    webURL: p0.webURL!,
                    note: p0.note!,
                    cardFrontURL: url[0],
                    cardBackURL: url[1]);
              } else {
                print("Image required");
              }
            },
          ),
        ]),
      ),
    );
  }
}

class Section2 extends StatefulWidget {
  Function(File) backImgSelect;
  Function(File) frontImgSelect;

  Section2({
    Key? key,
    required this.backImgSelect,
    required this.frontImgSelect,
  }) : super(key: key);

  @override
  State<Section2> createState() => _Section2State();
}

class _Section2State extends State<Section2> {
  final ImagePicker _picker = ImagePicker();
  XFile? frontCardId;
  XFile? backCardId;

  getImages() {
    return [frontCardId, backCardId];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          height: 96,
          width: 124,
          child: Column(children: [
            DottedBorder(
              color: ColorManager.grey,
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              child: InkWell(
                onTap: () async {
                  final img = await _picker.pickImage(
                      source: ImageSource.camera,
                      preferredCameraDevice: CameraDevice.rear);
                  setState(() {
                    frontCardId = img;
                    widget.frontImgSelect(File(frontCardId!.path));
                  });
                },
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: 65,
                    width: double.infinity,
                    child: frontCardId != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(frontCardId!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(AssetsManager.frontIdIcon)),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.add,
                  color: ColorManager.primary,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Card front",
                  style: TextStyle(color: ColorManager.primary, fontSize: 14),
                )
              ]),
            )
          ]),
        ),
        Container(
          height: 96,
          width: 124,
          child: Column(children: [
            DottedBorder(
              color: ColorManager.grey,
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              child: InkWell(
                onTap: () async {
                  final img = await _picker.pickImage(
                      source: ImageSource.camera,
                      preferredCameraDevice: CameraDevice.rear);
                  setState(() {
                    backCardId = img;
                    widget.backImgSelect(File(backCardId!.path));
                  });
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 65,
                  width: double.infinity,
                  child: backCardId != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(backCardId!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(AssetsManager.backIdIcon),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.add,
                  color: ColorManager.primary,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Card back",
                  style: TextStyle(color: ColorManager.primary, fontSize: 14),
                )
              ]),
            )
          ]),
        ),
      ]),
    );
  }
}

class FormSection extends StatefulWidget {
  Function(ModelLoayltyCard) onSaveForm;

  FormSection({super.key, required this.onSaveForm});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  TextEditingController _cardNameController = TextEditingController();
  TextEditingController _cardProgrammeController = TextEditingController();
  TextEditingController _cardWebsiteController = TextEditingController();
  TextEditingController _cardNoteController = TextEditingController();
  var selectedValue = "Vendor 1";
  List list = [
    "Vendor 1",
    "Vendor 2",
    "Vendor 3",
    "Vendor 4",
    "Vendor 5",
  ];
  DatabaseService _databaseService = DatabaseService();
  StorageService _storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 50,
            child: TextFormField(
              controller: _cardNameController,
              textInputAction: TextInputAction.next,
              cursorColor: ColorManager.secondary,
              decoration: _customInputDecoration(lable: "Card name"),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: Container(
        //     height: 50,
        //     child: TextFormField(
        //       cursorColor: ColorManager.secondary,
        //       decoration: _customInputDecoration(
        //           lable: "Select vendor", isVendorField: true),
        //     ),
        //   ),
        // ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: DropdownButtonFormField(
            focusNode: FocusNode(descendantsAreTraversable: true),
            style: TextStyle(color: ColorManager.darkGrey, fontSize: 16),
            decoration: _customInputDecoration(lable: "Select vendor"),
            items: list.map<DropdownMenuItem>((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              selectedValue = value;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 50,
            child: TextFormField(
              controller: _cardProgrammeController,
              textInputAction: TextInputAction.next,
              cursorColor: ColorManager.secondary,
              decoration: _customInputDecoration(lable: "Programme name"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 50,
            child: TextFormField(
              controller: _cardWebsiteController,
              textInputAction: TextInputAction.next,
              cursorColor: ColorManager.secondary,
              decoration: _customInputDecoration(lable: "Website URL"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 100,
            child: TextFormField(
              controller: _cardNoteController,
              textAlignVertical: TextAlignVertical.top,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              cursorColor: ColorManager.secondary,
              decoration: _customInputDecoration(lable: "Note"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorManager.primary),
                    minimumSize: MaterialStatePropertyAll(
                        Size(double.infinity, double.infinity))),
                child: isLoading
                    ? Container(
                        height: 15,
                        child: CircularProgressIndicator(
                          color: ColorManager.white,
                        ))
                    : Text(
                        "SAVE",
                        style: TextStyle(fontSize: 16),
                      ),
                onPressed: () async {
                  var loyalty = ModelLoayltyCard();
                  loyalty.cardName = _cardNameController.text.trim();
                  loyalty.vendor = selectedValue;
                  loyalty.programmeName = _cardNameController.text.trim();
                  loyalty.webURL = _cardWebsiteController.text.trim();
                  loyalty.note = _cardNoteController.text.trim();
                  widget.onSaveForm(loyalty);

                  // setState(() {
                  //   isLoading = true;
                  // });
                  // final imageList = _Section2State().getImages();
                  // print(imageList);
                  // final urlList = await _storageService.saveImages(
                  //     imageList[0], imageList[1]);
                  // await _databaseService.saveCardDetails(
                  //     cardFrontURL: urlList[0],
                  //     cardBackURL: urlList[1],
                  //     cardName: _cardNameController.text,
                  //     vendor: selectedValue,
                  //     programmeName: _cardProgrammeController.text,
                  //     webURL: _cardWebsiteController.text,
                  //     note: _cardNoteController.text);
                  // setState(() {
                  //   isLoading = false;
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text("New card added!!")));
                  // });
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => LoyaltyCards(),
                  //     ));
                },
              )),
        )
      ],
    );
  }
}

InputDecoration _customInputDecoration(
    {required String lable, bool isVendorField = false}) {
  return InputDecoration(
      alignLabelWithHint: true,
      // suffixIcon: isVendorField ? InkWell(
      //   onTap: () {
      //     return DropdownButtonFormField(items: items, onChanged: onChanged);
      //   },
      //   child: Icon(Icons.arrow_drop_down)) : null,
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
