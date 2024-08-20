import 'package:ecommarce/features/common_widget/common_svgicon.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppThemeColor.primaryColor,
        child: Container(
          height: 80,
          width: 270,
          alignment: AlignmentDirectional.center,
          child: const CommonSVGIcon(
            imageName: 'splash_image',
            imagePath: 'icon'
          ),
        ),
      ),
    );
  }
}
