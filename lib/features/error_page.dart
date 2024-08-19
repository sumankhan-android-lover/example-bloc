import 'package:ecommarce/helpers/constant.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0x0d53b175),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/png/common.png',
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Error!',
              style: TextStyleTypography.typoBoldStyle20,
            )
          ],
        ),
      ),
    );
  }
}
