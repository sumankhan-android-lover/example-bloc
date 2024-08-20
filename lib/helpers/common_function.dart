import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:flutter/material.dart';

AppBar commonAppBar(String title, {bool isAction = false, VoidCallback? callback}) => AppBar(
  title: Text(
    title, style: TextStyleTypography.typoBoldStyle16.copyWith(color: Colors.white),
  ),
  backgroundColor: AppThemeColor.primaryColor,
  actions: isAction ? [
    TextButton(
        onPressed: (){
          callback!();
        },
        child: Text('Clear', style: TextStyleTypography.typoSemiBoldStyle12.copyWith(color: ColorConstants.white,),),
    ),
  ] : [],
);