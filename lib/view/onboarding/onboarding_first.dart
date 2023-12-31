import 'package:flutter/material.dart';
import 'package:hackathon/const/colors.dart';

class OnBoardinngFirst extends StatelessWidget {
  const OnBoardinngFirst({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.orange.withOpacity(0.0),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(height: 60, child: Image.asset('assets/images/logo.png')),
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gram',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Saarthi',
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  'assets/images/on1.png',
                  height: size.height * 0.47,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Text(
                        'e-Market to promote Culture!',
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      const Text(
                        "Explore and shop on our e-Market for a cultural journey through unique products, each purchase a celebration of heritage and tradition.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
