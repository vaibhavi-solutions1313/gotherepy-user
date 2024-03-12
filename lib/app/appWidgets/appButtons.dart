
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';

import '../app_constants/constants_appColors.dart';

class BorderButton extends StatefulWidget {
  final VoidCallback onClick;
  final String buttonText;
  final Color borderColor;
  final Color textColor;
  final double fontSize;
  final double lMargin;
  final double rMargin;
  const BorderButton({Key? key, required this.buttonText, this.borderColor=AppColors.tealColor,  this.textColor=AppColors.tealColor,
    required this.onClick, this.fontSize=16, this.lMargin=0.0, this.rMargin=0.0,}) : super(key: key);

  @override
  State<BorderButton> createState() => _BorderButtonState();
}

class _BorderButtonState extends State<BorderButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:widget.lMargin,top: 16.0,right:widget.rMargin,bottom: 6.0),
      child: Material(
        elevation: 0.5,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          // overlayColor: AppColors.tealColor,
          borderRadius: BorderRadius.circular(12.0),
          onTap: widget.onClick,
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: widget.borderColor
              )
            ),
            child: Center(
                child: Text16by400(text:widget.buttonText,color: widget.textColor,fontSize: widget.fontSize,)),
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////

class CustomSolidButton extends StatelessWidget {

  final VoidCallback onClick;
  final String buttonText;
  final Color boxColor;
  final Color textColor;
  final double fontSize;
  final double vPadding;
  const CustomSolidButton({Key? key, required this.buttonText, this.boxColor=AppColors.tealColor,  this.textColor=AppColors.scaffoldColor,
    required this.onClick, this.fontSize=16,  this.vPadding=14,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 16.0,bottom: 6.0),
      child: Material(

        elevation: 0.5,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(

          // overlayColor: AppColors.tealColor,
          borderRadius: BorderRadius.circular(8.0),
          onTap: onClick,
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: vPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: boxColor
            ),
            child: Center(
                child: Text16by400(text:buttonText,color:textColor,fontSize: fontSize,)),
          ),
        ),
      ),
    );
  }
}

