import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_cards_list/loyalty_cards_screen.dart';
import 'package:zig_project/ui/widgets/widgets.dart';
import 'package:zig_project/utils/validations/validations.dart';

class FormSection extends StatefulWidget {
  ModelLoayltyCard modelLoayltyCard;
  Function(ModelLoayltyCard) onSaveForm;

  FormSection(
      {super.key, required this.onSaveForm, required this.modelLoayltyCard});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  Validation _validationObject = Validation();
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
                validator: (value) => _validationObject.validateEmptyFields(
                    value, StringManager.validateEmptyCardName),
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
              validator: (value) => _validationObject.validateEmptyFields(
                  value, StringManager.validateEmptyProgrammeName),
            ),
            CommonWidgets.getTextInputField(
                isEnable: isEnable,
                controller: _cardWebsiteController,
                lable: StringManager.webURLLableText,
                validator: (value) => _validationObject.validateEmptyFields(
                    value, StringManager.validateEmptyWebURL)),
            CommonWidgets.getTextInputField(
              isEnable: isEnable,
              maxLine: 3,
              lable: StringManager.noteLableText,
              controller: _cardNoteController,
              validator: (value) => _validationObject.validateEmptyFields(
                  value, StringManager.validateEmptyNote),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          MaterialStatePropertyAll(ColorManager.primary),
                      minimumSize: const MaterialStatePropertyAll(
                          Size(double.infinity, double.infinity))),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () => onSubmit(),
                )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isEnable = false;
      });
      showDialog(
        context: context,
        builder: (context) => CommonWidgets.loadingIndicator(),
      );
      var loyalty = ModelLoayltyCard();
      loyalty.cardName = _cardNameController.text.trim();
      loyalty.vendor = selectedVendor;
      loyalty.programmeName = _cardProgrammeController.text.trim();
      loyalty.webURL = _cardWebsiteController.text.trim();
      loyalty.note = _cardNoteController.text.trim();
      await widget.onSaveForm(loyalty);
      setState(() {
        isEnable = true;
      });
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, LoyaltyCards.id);
    }
  }
}
