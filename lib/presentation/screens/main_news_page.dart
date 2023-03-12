import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../buisness_logic/cubit/bookmarks_cubit/bookmarks_cubit.dart';
import '../../buisness_logic/cubit/location_cubit/location_cubit.dart';
import '../../buisness_logic/cubit/main_page_news_cubit/main_page_news_cubit.dart';
import '../../buisness_logic/cubit/news_cubit/news_cubit.dart';
import '../../buisness_logic/cubit/search_news/search_news_dart_cubit.dart';
import '../../buisness_logic/cubit/user_data/user_data_cubit.dart';
import '../../data/models/user_model.dart';
import '../navigation_pages/bookmarks_page.dart';
import '../navigation_pages/discover_page.dart';
import '../navigation_pages/home_page.dart';
import '../navigation_pages/notifications_page.dart';
import '../navigation_pages/profile_page.dart';
import '../../utils/colors.dart';

class MainNewsPage extends StatefulWidget {
  const MainNewsPage({super.key});

  @override
  State<MainNewsPage> createState() => _MainNewsPageState();
}

class _MainNewsPageState extends State<MainNewsPage> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildMainAppWithBottomNavigationBar();
  }

  Widget buildMainAppWithBottomNavigationBar() {
    List pages = [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsCubit(),
          ),
          BlocProvider(
            create: (context) => MainPageNewsCubit(),
          ),
          BlocProvider(
            create: (context) => LocationCubit(),
          ),
          BlocProvider.value(
            value: BlocProvider.of<BookmarksCubit>(context),
          )
        ],
        child: HomePage(),
      ),
      BlocProvider.value(
        value: BlocProvider.of<BookmarksCubit>(context),
        child: const BookMarksPage(),
      ),
      BlocProvider(
        create: (context) => SearchNewsCubit(),
        child: DiscoverPage(),
      ),
      const NotificationsPage(),
      BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoaded) {
            return ProfilePage(
              userData: state.userDataList,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      // body: ,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey.withOpacity(0.5),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            label: 'Home',
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
          ),
          const BottomNavigationBarItem(
            label: 'Bookmarks',
            activeIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline),
          ),
          BottomNavigationBarItem(
            label: 'Discover',
            icon: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: const Color(AppColors.filledButtonColor),
              ),
              child: const Icon(CupertinoIcons.search),
            ),
          ),
          const BottomNavigationBarItem(
            label: 'Notification',
            activeIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_outlined),
          ),
          const BottomNavigationBarItem(
            label: 'Profile',
            icon: CircleAvatar(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<UserDataCubit>(context).getUserData();
    super.initState();
  }
}
