import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import '../../../buisness_logic/bloc/auth_bloc/app_auth_bloc.dart';
import '../../widgets/text_generator.dart';
import '../../widgets/bottom_big_button.dart';
import '../../widgets/dont_have_account_row.dart';
import '../../../utils/colors.dart';

import '../../widgets/logo_animated_text.dart';
import '../../widgets/sign_up_page_divider_line.dart';

class MainEntryPage extends StatelessWidget {
  const MainEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 250,
          bottom: 15,
          right: 15,
          left: 15,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.7,
            image: AssetImage('assets/images/sign_up_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 40,
                ),
                const Gap(10),
                const LogoAnimatedText(),
              ],
            ),
            const Gap(40),
            const BoldText(
              text: 'Stay informed with our news app',
              color: Colors.white,
              fontSize: 35,
            ),
            const Gap(20),
            NormalText(
              text:
                  'Always stay in touch with what is happening in the world and around you',
              color: const Color(AppColors.lightGreyTextColor),
              textAlign: TextAlign.start,
            ),
            const Gap(40),
            BottomFilledButton(
              text: 'Continue With Email',
              onTap: () {
                context.read<AppAuthBloc>().add(
                      AppAuthEventGoToLogInPage(),
                    );
              },
            ),
            const Gap(40),
            const SignUpPageDividerLine(),
            const Gap(25),
            Row(
              children: [
                Expanded(
                  child: BottomFilledButton(
                    isIconButton: true,
                    icon: FontAwesomeIcons.google,
                    iconSize: 23,
                    text: 'Google',
                    onTap: () {},
                    backgroundColor: Colors.white,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: BottomFilledButton(
                    isIconButton: true,
                    icon: Icons.apple,
                    text: 'Apple',
                    onTap: () {},
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: DontHaveAccountText(
                onTap: () {
                  context.read<AppAuthBloc>().add(
                        AppAuthEventGoToRegisterPage(),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
