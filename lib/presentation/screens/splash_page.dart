import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../buisness_logic/bloc/auth_bloc/app_auth_bloc.dart';
import '../widgets/text_generator.dart';
import '../widgets/bottom_big_button.dart';
import '../../utils/colors.dart';
import '../../utils/strings.dart';

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
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Stack(children: [
          PageView.builder(
            itemCount: 3,
            itemBuilder: ((context, index) {
              return splashPageItems(index);
            }),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                BottomFilledButton(
                  text: 'Get Started',
                  onTap: () {
                    context
                        .read<AppAuthBloc>()
                        .add(AppAuthEventGoToMainEntryPage());
                  },
                ),
                const Gap(15),
                BottomBorderButton(text: 'Browse News'),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget splashPageItems(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/app_opening.jpg',
          width: 300,
        ),
        const Gap(70),
        BoldText(
          text: firstPageBoldText[index],
          fontSize: 30,
        ),
        const Gap(20),
        NormalText(
          text: firstPageSecondText[index],
          fontSize: 15,
          color: Colors.grey,
        ),
        const Gap(20),
        pagesDots(index),
        const Gap(40),
      ],
    );
  }

  Widget pagesDots(int index) {
    return Wrap(
      spacing: 10,
      children: List.generate(3, (indexDots) {
        return Container(
          width: index == indexDots ? 12 : 10,
          height: index == indexDots ? 12 : 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: index == indexDots
                ? const Color(AppColors.selectedDotColor)
                : const Color(AppColors.unSelectedDotColor),
          ),
        );
      }),
    );
  }
}
