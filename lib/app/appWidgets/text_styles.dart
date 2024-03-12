
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_constants/constants_appColors.dart';


class Text14by400 extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  final int maxLine;
  final TextAlign align;
  const Text14by400({Key? key, required this.text, this.color=AppColors.blackishTextColor, this.fontSize=14, this.maxLine=1, this.align=TextAlign.left}) : super(key: key);

  @override
  State<Text14by400> createState() => _Text14by400State();
}

class _Text14by400State extends State<Text14by400> {
  @override
  Widget build(BuildContext context) {
    return  Text(widget.text,
        maxLines: widget.maxLine,
        textAlign: widget.align,
        style: TextStyle(
        
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w400,
      color: widget.color,
      overflow: TextOverflow.ellipsis,
    ));
  }
}
/////////////////////////////////////////////////////////////
class Text14by500 extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  const Text14by500({Key? key, required this.text, this.color=AppColors.blackishTextColor, this.fontSize=14}) : super(key: key);

  @override
  State<Text14by500> createState() => _Text14by500State();
}

class _Text14by500State extends State<Text14by500> {
  @override
  Widget build(BuildContext context) {
    return  Text(widget.text,style: TextStyle(
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w500,
      color: widget.color,
    ),);
  }
}
///////////////////////////////////////////////////////////////
class Text16by400 extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  final int maxLine;
  const Text16by400({Key? key, required this.text, this.color=Colors.black, this.fontSize=16, this.maxLine=1}) : super(key: key);

  @override
  State<Text16by400> createState() => _Text16by400State();
}

class _Text16by400State extends State<Text16by400> {
  @override
  Widget build(BuildContext context) {
    return  Text(widget.text,style: TextStyle(
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w400,
      color: widget.color,
    ),maxLines: widget.maxLine,overflow: TextOverflow.ellipsis,);
  }
}
/////////////////////////////////////////////////////////////
class Text16by600 extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  const Text16by600({Key? key, required this.text, this.color=Colors.black,  this.fontSize=16}) : super(key: key);

  @override
  State<Text16by600> createState() => _Text16by600State();
}

class _Text16by600State extends State<Text16by600> {
  @override
  Widget build(BuildContext context) {
    return  Text(widget.text,style: TextStyle(
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w600,
      color: widget.color,
    ),);
  }
}
/////////////////////////////////////////////////////////////
class Text16by700 extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  const Text16by700({Key? key, required this.text, this.color=Colors.black,  this.fontSize=16}) : super(key: key);

  @override
  State<Text16by700> createState() => _Text16by700State();
}

class _Text16by700State extends State<Text16by700> {
  @override
  Widget build(BuildContext context) {
    return  Text(widget.text,style: TextStyle(
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w700,
      color: widget.color,
    ),);
  }
}
///////////////////////////////////////////////////////////////////

class FooterTextWithCenterAligned extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overFlow;
  final TextAlign textAlign;
  const FooterTextWithCenterAligned({Key? key,
    required this.text,
    this.color=AppColors.lightBlackishTextColor,
    required this.fontSize,
    this.fontWeight=FontWeight.w400,
     this.overFlow=TextOverflow.ellipsis,
     this.textAlign=TextAlign.center
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      overflow: overFlow,
    ),
      textAlign: textAlign,
      maxLines: 3,

    );
  }
}
