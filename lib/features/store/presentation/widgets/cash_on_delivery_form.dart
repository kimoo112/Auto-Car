import 'package:auto_car/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class CashOnDeliveryForm extends StatefulWidget {
  const CashOnDeliveryForm({super.key});

  @override
  _CashOnDeliveryFormState createState() => _CashOnDeliveryFormState();
}

class _CashOnDeliveryFormState extends State<CashOnDeliveryForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  String? _selectedCity;
  final List<String> _cities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Shubra El Kheima',
    'Port Said',
    'Suez',
    'El Mahalla El Kubra',
    'Mansoura',
    'Tanta',
    'Asyut',
    'Faiyum',
    'Zagazig',
    'Ismailia',
    'Aswan',
    'Damanhur',
    'Damietta',
    'Minya',
    'Beni Suef',
    'Luxor',
    'Shibin El Kom',
    'Sohag',
    'Qena',
    'Hurghada',
    'Arish',
    'Banha',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
                labelText: "Full Name",
                controller: _nameController,
                icon: IconlyBold.profile),
            20.verticalSpace,
            CustomTextFormField(
                labelText: "Phone Number",
                controller: _phoneController,
                keyboardType: TextInputType.number,
                icon: IconlyBold.call),
            20.verticalSpace,
            CustomTextFormField(
                labelText: "Street Address",
                controller: _streetController,
                icon: IconlyBold.home),
            20.verticalSpace,
            _buildCityDropdown(),
            20.verticalSpace,
            CustomTextFormField(
                labelText: "Postal Code",
                controller: _postalCodeController,
                keyboardType: TextInputType.number,
                icon: IconlyBold.message),
            const Spacer(),
            CustomButton(
              text: 'Confirm Order',
              fontSize: 15.sp,
              textColor: AppColors.white,
              borderRadius: 15,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  customReplacementAndRemove(context, orderConfirmedView);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select City',
        labelStyle: TextStyle(
          color: AppColors.dark.withOpacity(.8),
        ),
        prefixIcon: Icon(IconlyBold.location, color: AppColors.primaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      value: _selectedCity,
      items: _cities.map((city) {
        return DropdownMenuItem(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCity = value;
        });
      },
      validator: (value) => value == null ? 'Please select a city' : null,
    );
  }
}
