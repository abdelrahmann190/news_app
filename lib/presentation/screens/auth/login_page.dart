import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../buisness_logic/bloc/auth_bloc/app_auth_bloc.dart';
import '../../widgets/auth/customizable_text_field.dart';
import '../../widgets/bottom_big_button.dart';
import '../../widgets/text_generator.dart';
import '../../widgets/top_part_of_auth_pages.dart';
import '../../../utils/global_key.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {
  final emailTextFieldController = TextEditingController();

  final passwordTextFieldController = TextEditingController();

  final String passwordHintText = '********';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myGlobals.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const TopPartOfAuthPage(),
          Positioned(
            bottom: 0,
            top: 335,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: BoldText(
                      text: 'Log In',
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(30),
                  NormalText(
                    text: 'Email',
                    color: Colors.grey,
                  ),
                  const Gap(10),
                  CustomizableTextField(
                    controller: emailTextFieldController,
                    hintText: 'hello@gmail.com',
                    obscureText: false,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  const Gap(20),
                  NormalText(
                    text: 'Password',
                    color: Colors.grey,
                  ),
                  const Gap(10),
                  CustomizableTextField(
                    controller: passwordTextFieldController,
                    hintText: passwordHintText,
                    obscureText: true,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                  ),
                  const Gap(30),
                  BottomFilledButton(
                    text: 'submit',
                    onTap: () {
                      onSubmitButtonPressed(
                        myGlobals.scaffoldKey.currentContext!,
                      );
                    },
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalText(
                        text: "Don't have an account?  ",
                        fontSize: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AppAuthBloc>(context).add(
                            AppAuthEventGoToRegisterPage(),
                          );
                        },
                        child: const BoldText(
                          text: 'Sign Up',
                          fontSize: 20,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmitButtonPressed(BuildContext context) {
    BlocProvider.of<AppAuthBloc>(context).add(
      AppAuthEventLogInRequested(
        email: emailTextFieldController.text,
        password: passwordTextFieldController.text,
      ),
    );
  }
}
