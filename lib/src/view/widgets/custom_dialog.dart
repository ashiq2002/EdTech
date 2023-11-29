import 'package:edtech/route/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: height/2,
        child: Column(
          children: [
            Expanded(child: Lottie.asset('assets/anim/anim_congratulation.json')),
            const Text('congratulation!\nyou completed the course', textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            TextButton(
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesName.dashboardScreen,
                    ModalRoute.withName(RoutesName.videoPlayScreen));
              },

              child: const Text('Claim Your Certificate'),
            )
          ],
        ),
      ),
    );
  }
}