import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constants/constants_appColors.dart';


class PhoneTextField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController phoneController;
  const PhoneTextField({Key? key, required this.title, required this.phoneController, required this.hint}) : super(key: key);
  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    var countryPhoneCode="91".obs;
    var countryCode="India (IN)".obs;
    var countryFlag="🇮🇳".obs;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.0),
      child: Obx(() => TextFormField(
        controller: widget.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
          fillColor: Colors.white,
          filled: false,
          hintText: countryCode.value,
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: AppColors.lightGreyTextColor.withOpacity(0.5),
                width: 1.5,
              )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: AppColors.lightGreyTextColor.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          prefixIcon: InkWell(
            onTap: ()=>showCountryPicker(
                countryListTheme: CountryListThemeData(
                    inputDecoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.scaffoldColor,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search)
                    )
                ),
                favorite: ['IN'],
                context: context,
                onSelect: (Country value){
                  countryCode.value=value.displayNameNoCountryCode.toString();
                  countryPhoneCode.value=value.phoneCode.toString();
                   countryFlag.value=value.flagEmoji;
                  print("------------------------");
                  print(value.flagEmoji);
                }),
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                   Text('${countryFlag.value}'),
                  Text(' ${countryPhoneCode.value}',style: TextStyle(color: AppColors.bluishColor),),
                ],
              ) ,
            ),
          ),
        ),
      )),
    );
  }
}