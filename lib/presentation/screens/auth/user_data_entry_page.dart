import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../buisness_logic/bloc/auth_bloc/app_auth_bloc.dart';
import '../../widgets/auth/customizable_text_field.dart';
import '../../widgets/bottom_big_button.dart';
import '../../widgets/text_generator.dart';
import '../../widgets/top_part_of_auth_pages.dart';
import '../../../utils/global_key.dart';

class UserDataEntryPage extends StatefulWidget {
  const UserDataEntryPage({super.key});

  @override
  State<UserDataEntryPage> createState() => _UserDataEntryPage();
}

class _UserDataEntryPage extends State<UserDataEntryPage> {
  final firstNameTextFieldController = TextEditingController();

  final lastNameTextFieldController = TextEditingController();
  final phoneNumberTextFieldController = TextEditingController();

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
                      text: 'Enter Your Data',
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(30),
                  NormalText(
                    text: 'First Name',
                    color: Colors.grey,
                  ),
                  const Gap(10),
                  CustomizableTextField(
                    controller: firstNameTextFieldController,
                    hintText: 'Jon',
                    obscureText: false,
                    prefixIcon: const Icon(
                      Icons.people_alt_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  const Gap(20),
                  NormalText(
                    text: 'Last Name',
                    color: Colors.grey,
                  ),
                  const Gap(10),
                  CustomizableTextField(
                    controller: lastNameTextFieldController,
                    hintText: 'Jones',
                    obscureText: false,
                    prefixIcon: const Icon(
                      Icons.people_alt_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  const Gap(10),
                  NormalText(
                    text: 'Phone Number (Optional)',
                    color: Colors.grey,
                  ),
                  const Gap(10),
                  CustomizableTextField(
                    controller: phoneNumberTextFieldController,
                    hintText: '+201012345678',
                    obscureText: false,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                  ),
                  const Gap(30),
                  BottomFilledButton(
                    text: 'submit',
                    onTap: () {
                      submitUserData();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitUserData() {
    BlocProvider.of<AppAuthBloc>(context).add(
      AppAuthEventUploadUserData(
        firstName: firstNameTextFieldController.text,
        lastName: lastNameTextFieldController.text,
        phoneNumber: phoneNumberTextFieldController.text,
      ),
    );
  }
}
