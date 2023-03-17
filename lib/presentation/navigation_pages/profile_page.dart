// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:news_app/buisness_logic/bloc/auth_bloc/app_auth_bloc.dart';
import 'package:news_app/data/models/user_model.dart';
import 'package:news_app/presentation/widgets/bottom_big_button.dart';
import 'package:news_app/presentation/widgets/profile_page_body_cards.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';

class ProfilePage extends StatelessWidget {
  final List<UserModel> userData;
  const ProfilePage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
              ),
              const Gap(20),
              NormalText(
                text:
                    "${userData[0].firstName.toUpperCase()} ${userData[0].lastName.toUpperCase()}",
                color: Colors.white,
                fontSize: 35,
              )
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
            ),
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfilePageBodyCards(
                  onTap: () {},
                  boldTextPart: 'Profile Details',
                  lightTextPart: 'Show your profile details',
                ),
                const Gap(40),
                ProfilePageBodyCards(
                  onTap: () {},
                  boldTextPart: 'Privacy & Security',
                  lightTextPart: 'Show rules of security and data protection',
                ),
                const Gap(40),
                ProfilePageBodyCards(
                  onTap: () {},
                  boldTextPart: 'App Language',
                  lightTextPart: 'Chhose which language to use through the app',
                ),
                const Gap(40),
                ProfilePageBodyCards(
                  onTap: () {},
                  boldTextPart: 'Help Center',
                  lightTextPart: 'Reach for help & inquiries',
                ),
                const Gap(20),
                GestureDetector(
                  onTap: () {
                    _signOut(context);
                  },
                  child: BottomBorderButton(
                    text: 'Logout',
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void _signOut(BuildContext context) {
    BlocProvider.of<AppAuthBloc>(context).add(AppAuthEventLogOutRequested());
  }
}
