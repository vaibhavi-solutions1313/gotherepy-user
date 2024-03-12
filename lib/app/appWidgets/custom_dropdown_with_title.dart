
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';

import '../app_constants/constants_appColors.dart';

class CustomDropDownWithTitle extends StatelessWidget {
  final String question;
  const CustomDropDownWithTitle({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text16by400(text: question),
          SizedBox(height: 6.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                width: 1,
                color: AppColors.lightGreyTextColor
              )
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(

                borderRadius: BorderRadius.circular(16.0),
                focusColor: Color(0xffF5F5F5),
                isExpanded: true,
                elevation: 2,
                value: 'Select Operate',
                icon: Icon(Icons.keyboard_arrow_down),

                hint: Text(
                  'Select Operate',
                  style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color:AppColors.lightGreyTextColor),
                ),
                onChanged: ( val) {
                  // community.dropDownValue.value = val.toString();
                },
                items: [
                  DropdownMenuItem<String>(
                    value: "Select Operate",
                    child: Text("Select Operate"),
                  ),
                  DropdownMenuItem<String>(
                    value: "jio",
                    child: Text("jio"),
                  ),
                  DropdownMenuItem<String>(
                    value: "vi",
                    child: Text("vodafone"),
                  ),
                  DropdownMenuItem<String>(
                    value: "idea",
                    child: Text("Idea"),
                  ),
                  DropdownMenuItem<String>(
                    value: "bsnl",
                    child: Text("Bsnl"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
