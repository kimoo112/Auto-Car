import 'package:auto_car/core/routes/functions/navigation_functions.dart';
import 'package:auto_car/core/routes/routes.dart';
import 'package:auto_car/core/widgets/custom_button.dart';
import 'package:auto_car/features/store/data/products_model/products_model.dart';
import 'package:auto_car/features/store/presentation/widgets/cash_on_delivery_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterme_credit_card/flutterme_credit_card.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/utils/app_colors.dart';

class CheckoutDetailsScreen extends StatefulWidget {
  const CheckoutDetailsScreen({super.key, required this.product});
  final ProductsModel product;

  @override
  State<CheckoutDetailsScreen> createState() => _CheckoutDetailsScreenState();
}

class _CheckoutDetailsScreenState extends State<CheckoutDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    number.addListener(() => setState(() {}));
    validThru.addListener(() => setState(() {}));
    cvv.addListener(() => setState(() {}));
    holder.addListener(() => setState(() {}));
    loadCachedValues();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController number = TextEditingController();
  late TextEditingController validThru = TextEditingController();
  late TextEditingController cvv = TextEditingController();
  late TextEditingController holder = TextEditingController();

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
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Checkout Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('For payment : ', style: TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${widget.product.price!.toDouble()}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Text(
                      'Including Gst (18%)',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: const Offset(2, 0),
                        color: AppColors.softGrey.withOpacity(.7))
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.credit_card),
                    text: 'Credit card',
                  ),
                  Tab(
                    icon: Icon(IconlyBold.wallet),
                    text: 'Cash on delivery',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCreditCardForm(),
                  const CashOnDeliveryForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FMCreditCard(
            gradient: LinearGradient(colors: [
              AppColors.primaryColor,
              AppColors.primaryOrange.withOpacity(.9),
            ]),
            title:
                "${CacheHelper.getData(key: ApiKeys.name)} Card".toUpperCase(),
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
          30.verticalSpace,
          CustomButton(
            text: 'Pay for the order',
            fontSize: 15.sp,
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
                  // ignore: use_build_context_synchronously
                  customReplacementAndRemove(context, orderConfirmedView);
                }
              }
            },
          )
        ],
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
