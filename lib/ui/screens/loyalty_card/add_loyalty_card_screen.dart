import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/assets_manager.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/services/storage_service.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_cards_screen.dart';
import 'package:zig_project/ui/widgets/common_snackbar.dart';
import 'package:zig_project/ui/widgets/common_widgets.dart';

class AddLoyaltyCard extends StatefulWidget {
  ModelLoayltyCard modelLoayltyCard;
  AddLoyaltyCard({super.key, required this.modelLoayltyCard});

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
            backURL: widget.modelLoayltyCard.cardBackURL!,
            frontURL: widget.modelLoayltyCard.cardFrontURL!,
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
          SizedBox(
            height: 30,
          ),
          FormSection(
            modelLoayltyCard: widget.modelLoayltyCard,
            onSaveForm: (p0) async {
              if (frontImg != null && backImg != null) {
                final url =
                    await _storageService.saveImages(frontImg!, backImg!);
                _databaseService.saveCardDetails(
                    onError: (error) {
                      CommonSnackbar.showSnakbar(context, error);
                    },
                    onSuccess: () {
                      CommonSnackbar.showSnakbar(
                          context, "New loyalty card Added");
                    },
                    cardName: p0.cardName!,
                    vendor: p0.vendor!,
                    programmeName: p0.programmeName!,
                    webURL: p0.webURL!,
                    note: p0.note!,
                    cardFrontURL: url[0],
                    cardBackURL: url[1]);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoyaltyCards()));
              } else {
                CommonSnackbar.showSnakbar(
                    context, "Card Image should required !!");
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
  String frontURL;
  String backURL;

  Section2({
    Key? key,
    required this.backImgSelect,
    required this.frontImgSelect,
    required this.backURL,
    required this.frontURL,
  }) : super(key: key);

  @override
  State<Section2> createState() => _Section2State();
}

class _Section2State extends State<Section2> {
  final ImagePicker _picker = ImagePicker();
  XFile? frontCardId;
  XFile? backCardId;
  late String frontURL;
  late String backURL;
  @override
  void initState() {
    frontURL = widget.frontURL;
    backURL = widget.backURL;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        InkWell(
            onTap: () async {
              final img = await _picker.pickImage(
                  source: ImageSource.camera,
                  preferredCameraDevice: CameraDevice.rear);
              setState(() {
                frontCardId = img;
                widget.frontImgSelect(File(frontCardId!.path));
              });
            },
            child: CommonWidgets.chooseImageCard(
                tittle: "Card front", imageFile: frontCardId)),
        InkWell(
          onTap: () async {
            final img = await _picker.pickImage(
                source: ImageSource.camera,
                preferredCameraDevice: CameraDevice.rear);
            setState(() {
              backCardId = img;
              widget.backImgSelect(File(backCardId!.path));
            });
          },
          child: CommonWidgets.chooseImageCard(
              tittle: "Card back", imageFile: backCardId),
        )
      ]),
    );
  }
}

class FormSection extends StatefulWidget {
  ModelLoayltyCard modelLoayltyCard;
  Function(ModelLoayltyCard) onSaveForm;

  FormSection(
      {super.key, required this.onSaveForm, required this.modelLoayltyCard});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  TextEditingController _cardNameController = TextEditingController();
  TextEditingController _cardProgrammeController = TextEditingController();
  TextEditingController _cardWebsiteController = TextEditingController();
  TextEditingController _cardNoteController = TextEditingController();
  var selectedVendor = "";
  List vendorList = [
    "Vendor 1",
    "Vendor 2",
    "Vendor 3",
    "Vendor 4",
    "Vendor 5",
  ];
  DatabaseService _databaseService = DatabaseService();
  StorageService _storageService = StorageService();
  bool isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _cardNameController.text = widget.modelLoayltyCard.cardName!;
    _cardProgrammeController.text = widget.modelLoayltyCard.programmeName!;
    _cardWebsiteController.text = widget.modelLoayltyCard.webURL!;
    if (widget.modelLoayltyCard.note != null) {
      _cardNoteController.text = widget.modelLoayltyCard.note!;
    }
    selectedVendor = widget.modelLoayltyCard.vendor!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CommonWidgets.getTextInputField(
                controller: _cardNameController,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Card name should not be empty";
                  }
                },
                lable: "Card name"),
            CommonWidgets.getDropDownFormField(
              hint: selectedVendor,
              list: vendorList,
              onChanged: (p0) {
                setState(() {
                  selectedVendor = p0;
                });
              },
            ),
            CommonWidgets.getTextInputField(
                controller: _cardProgrammeController,
                lable: "Programme name",
                validator: ((p0) {
                  if (p0!.isEmpty) {
                    return "Programme name should not be empty";
                  }
                })),
            CommonWidgets.getTextInputField(
              controller: _cardWebsiteController,
              lable: "Website URL",
              validator: (p0) {
                if (p0!.isEmpty) {
                  return "Website URL should not be empty";
                }
              },
            ),
            CommonWidgets.getTextInputField(
              maxLine: 3,
              lable: "Note",
              controller: _cardNoteController,
              validator: (p0) {},
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
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
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      var loyalty = ModelLoayltyCard();
                      loyalty.cardName = _cardNameController.text.trim();
                      loyalty.vendor = selectedVendor;
                      loyalty.programmeName = _cardNameController.text.trim();
                      loyalty.webURL = _cardWebsiteController.text.trim();
                      loyalty.note = _cardNoteController.text.trim();
                      await widget.onSaveForm(loyalty);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
