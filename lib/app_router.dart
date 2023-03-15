import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/buisness_logic/bloc/auth_bloc/app_auth_bloc.dart';
import 'buisness_logic/cubit/bookmarks_cubit/bookmarks_cubit.dart';
import 'buisness_logic/cubit/user_data/user_data_cubit.dart';
import 'presentation/screens/auth/login_page.dart';
import 'presentation/screens/auth/main_entry_page.dart';
import 'presentation/screens/auth/signup_page.dart';
import 'presentation/screens/auth/user_data_entry_page.dart';
import 'presentation/screens/main_news_page.dart';
import 'presentation/screens/splash_page.dart';

import 'presentation/widgets/pop_up_dialoug_message.dart';
import 'utils/loading/loading_screen.dart';

class AppRouter extends StatelessWidget {
  AlertDialogMessage loadingDialog = AlertDialogMessage(isLoadingWidget: true);
  AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppAuthBloc()..add(AppAuthEventInitialized()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AppAuthBloc, AppAuthState>(
          listener: (context, state) {
            if (state.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: '',
              );
            } else {
              LoadingScreen.instance().hide();
            }

            if (state.authError != null) {
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogMessage(
                      isLoadingWidget: false,
                      titleText: state.authError!.errorHeader,
                      contentText: state.authError!.errorDescription,
                    );
                  });
            }
          },
          builder: (context, state) {
            if (state is AppAuthStateShowRegisterPage) {
              return SignUpPage();
            } else if (state is AppAuthStateShowLogInPage) {
              return LogInPage();
            } else if (state is AppAuthStateShowSplashPage) {
              return const SplashPage();
            } else if (state is AppAuthStateShowMainEntryPage) {
              return const MainEntryPage();
            } else if (state is AppAuthStateLoggedIn) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => BookmarksCubit(),
                  ),
                  BlocProvider(
                    create: (context) => UserDataCubit(),
                  ),
                ],
                child: const MainNewsPage(),
              );
            } else if (state is AppAuthStateLoggedOut) {
              return LogInPage();
            } else if (state is AppAuthStateShowUserDataEntryPage) {
              return const UserDataEntryPage();
            } else {
              return const Text('What are you doing here man');
            }
          },
        ),
      ),
    );
  }
}
