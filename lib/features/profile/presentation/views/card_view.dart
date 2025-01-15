import 'package:auto_car/core/cache/cache_helper.dart';
import 'package:auto_car/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterme_credit_card/flutterme_credit_card.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/utils/app_colors.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController number = TextEditingController();
  late TextEditingController validThru = TextEditingController();
  late TextEditingController cvv = TextEditingController();
  late TextEditingController holder = TextEditingController();

  @override
  void initState() {
    super.initState();

    // listen to state changes within the form field controllers
    number.addListener(() => setState(() {}));
    validThru.addListener(() => setState(() {}));
    cvv.addListener(() => setState(() {}));
    holder.addListener(() => setState(() {}));
    loadCachedValues();
  }

  void loadCachedValues() async {
    number.text = await CacheHelper.getData(key: 'number') ?? '';
    validThru.text = await CacheHelper.getData(key: 'validThru') ?? '';
    cvv.text = await CacheHelper.getData(key: 'cvv') ?? '';
    holder.text = await CacheHelper.getData(key: 'holder') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconlyLight.arrowLeft2),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FMCreditCard(
              gradient: LinearGradient(colors: [
                AppColors.primaryColor,
                AppColors.primaryOrange.withOpacity(.9),
              ]),
              title: "${CacheHelper.getData(key: ApiKeys.name)} Card"
                  .toUpperCase(),
              number: number.text,
              numberMaskType: FMMaskType.first6last2,
              cvv: cvv.text,
              cvvMaskType: FMMaskType.full,
              validThru: validThru.text,
              validThruMaskType: FMMaskType.none,
              holder: holder.text,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    FMHolderField(
                      controller: holder,
                      cursorColor: AppColors.primaryColor,
                      decoration: inputDecoration(
                        labelText: "Card Holder",
                        hintText: "John Doe",
                      ),
                    ),
                    const SizedBox(height: 30),
                    FMNumberField(
                      controller: number,
                      cursorColor: AppColors.primaryColor,
                      decoration: inputDecoration(
                        labelText: "Card Number",
                        hintText: "0000 0000 0000 0000",
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FMValidThruField(
                            controller: validThru,
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              labelStyle:
                                  TextStyle(color: AppColors.primaryColor),
                              labelText: "Valid Thru",
                              hintText: "****",
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: FMCvvField(
                            controller: cvv,
                            cursorColor: AppColors.primaryColor,
                            decoration: inputDecoration(
                              labelText: "CVV",
                              hintText: "***",
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Save Card Info ',
              fontSize: 12.sp,
              textColor: AppColors.white,
              borderRadius: 15,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await CacheHelper.saveData(key: 'number', value: number.text);
                  await CacheHelper.saveData(
                      key: 'validThru', value: validThru.text);
                  await CacheHelper.saveData(key: 'cvv', value: cvv.text);
                  await CacheHelper.saveData(key: 'holder', value: holder.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration({
    required String labelText,
    required String hintText,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      labelStyle: TextStyle(color: AppColors.primaryColor),
      labelText: labelText,
      hintText: hintText,
    );
  }
}
