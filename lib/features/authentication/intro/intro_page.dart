import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/png/intro_background.png'), fit: BoxFit.cover,),
      ),

     /* child: Stack(
          children: [
            Image.asset('assets/images/png/intro_background.png', fit: BoxFit.fill,),
            Positioned(child: Container(
              height: MediaQuery.of(context).size.height*30,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(0, 14, 23, 39),
                    Color.fromARGB(255, 133, 133, 133)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),),
          ],
      ),*/
    );
  }
}
