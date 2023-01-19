import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/ui/widgets/common_widgets.dart';

class FormSection extends StatefulWidget {
  ModelLoayltyCard modelLoayltyCard;
  Function(ModelLoayltyCard) onSaveForm;

  FormSection(
      {super.key, required this.onSaveForm, required this.modelLoayltyCard});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardProgrammeController =
      TextEditingController();
  final TextEditingController _cardWebsiteController = TextEditingController();
  final TextEditingController _cardNoteController = TextEditingController();
  var selectedVendor = null;
  List vendorList = [
    "Vendor 1",
    "Vendor 2",
    "Vendor 3",
    "Vendor 4",
    "Vendor 5",
  ];
  bool isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? frontImgURL;
  String? backImgURL;
  bool isEnable = true;

  @override
  void initState() {
    _cardNameController.text = widget.modelLoayltyCard.cardName!;
    _cardProgrammeController.text = widget.modelLoayltyCard.programmeName!;
    _cardWebsiteController.text = widget.modelLoayltyCard.webURL!;
    // if (widget.modelLoayltyCard.note != null) {
    //   _cardNoteController.text = widget.modelLoayltyCard.note!;
    // }
    _cardNoteController.text = widget.modelLoayltyCard.note ?? "";
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
                isEnable: isEnable,
                controller: _cardNameController,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return StringManager.validateEmptyCardName;
                  }
                  return null;
                },
                lable: StringManager.cardNameLableText),
            CommonWidgets.getDropDownFormField(
              isEnable: isEnable,
              selectedvendor: selectedVendor,
              list: vendorList,
              onChanged: (p0) {
                setState(() {
                  selectedVendor = p0;
                });
              },
            ),
            CommonWidgets.getTextInputField(
                isEnable: isEnable,
                controller: _cardProgrammeController,
                lable: StringManager.programmeNameLableText,
                validator: ((p0) {
                  if (p0!.isEmpty) {
                    return StringManager.validateEmptyProgrammeName;
                  }
                  return null;
                })),
            CommonWidgets.getTextInputField(
              isEnable: isEnable,
              controller: _cardWebsiteController,
              lable: StringManager.webURLLableText,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return StringManager.validateEmptyWebURL;
                }
                return null;
              },
            ),
            CommonWidgets.getTextInputField(
              isEnable: isEnable,
              maxLine: 3,
              lable: StringManager.noteLableText,
              controller: _cardNoteController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return StringManager.validateEmptyNote;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 50,
                child: isLoading
                    ? SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                MaterialStatePropertyAll(ColorManager.primary),
                            minimumSize: const MaterialStatePropertyAll(
                                Size(double.infinity, double.infinity))),
                        child: const Text(
                          "SAVE",
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              isEnable = false;
                              isLoading = true;
                            });
                            var loyalty = ModelLoayltyCard();
                            loyalty.cardName = _cardNameController.text.trim();
                            loyalty.vendor = selectedVendor;
                            loyalty.programmeName =
                                _cardProgrammeController.text.trim();
                            loyalty.webURL = _cardWebsiteController.text.trim();
                            loyalty.note = _cardNoteController.text.trim();
                            await widget.onSaveForm(loyalty);
                            setState(() {
                              isEnable = true;
                              isLoading = false;
                            });
                          }
                        },
                      )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
