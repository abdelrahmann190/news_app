// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:news_app/buisness_logic/cubit/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:news_app/buisness_logic/cubit/location_cubit/location_cubit.dart';
import 'package:news_app/buisness_logic/cubit/main_page_news_cubit/main_page_news_cubit.dart';
import 'package:news_app/buisness_logic/cubit/news_cubit/news_cubit.dart';

import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/presentation/screens/location_picker_page.dart';
import 'package:news_app/presentation/screens/news_story_page.dart';
import 'package:news_app/presentation/widgets/home_page_category_list.dart';
import 'package:news_app/presentation/widgets/main_page_news_card.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';
import 'package:news_app/presentation/widgets/today_date_formater.dart';
import 'package:news_app/presentation/widgets/top_news_articles_list.dart';

import '../../utils/strings.dart';
import '../widgets/show_country_flag.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  List<News> topNewsArticles = [];
  List<News> mainNewsList = [];

  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentLocation = '';
  int currentIndex = 0;
  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {});
            return Future.delayed(const Duration(seconds: 1), () {
              mainContext.read<NewsCubit>().getTopNewsArticles(
                    countryCode: countryCode,
                  );
              mainContext
                  .read<MainPageNewsCubit>()
                  .getNewsWithCountryCodeAndCategory(
                    newsCategory: newsCatogeries[currentIndex],
                    countryCode: countryCode,
                  );
            });
          },
          child: buildhomeNewsPage(mainContext),
        ));
  }

  Widget buildhomeNewsPage(BuildContext mainContext) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is TopNewsArticlesLoaded) {
          widget.topNewsArticles = state.topNewsArticles;
          return CustomScrollView(
            slivers: [
              buildTopNewsArticlesBar(mainContext),
              SliverList(
                  delegate: SliverChildListDelegate(
                [
                  buildHomePageBody(),
                ],
              ))
            ],
          );
        } else {
          return showLoadingProgressIndicator(
            indicatorColor: Colors.white,
          );
        }
      },
    );
  }

  Widget buildHomePageBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newsCatogeries.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                currentIndex = index;
                                context
                                    .read<MainPageNewsCubit>()
                                    .getNewsWithCountryCodeAndCategory(
                                      newsCategory:
                                          newsCatogeries[currentIndex],
                                      countryCode: countryCode,
                                    );
                              },
                            );
                          },
                          child: CategoriesListViewItems(
                            containerColor: currentIndex == index
                                ? Colors.black
                                : Colors.black12,
                            textColor: currentIndex == index
                                ? Colors.white
                                : Colors.black,
                            iconText: newsCatogeries[index],
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(10),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<MainPageNewsCubit, MainPageNewsState>(
                        builder: (context, state) {
                          if (state is CountryAndCatogeryNewsLoaded) {
                            widget.mainNewsList =
                                state.countryAndCatogeryNewsLoaded;
                            return MainNewsPageCard(
                              isDismissible: false,
                              mainNewsList: widget.mainNewsList,
                            );
                          } else {
                            return showLoadingProgressIndicator(
                                indicatorColor: Colors.black);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopNewsArticlesBar(BuildContext mainContext) {
    return SliverAppBar(
      expandedHeight: 570,
      pinned: false,
      stretch: true,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.only(
            left: 20,
            top: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider.value(
                          value: BlocProvider.of<BookmarksCubit>(mainContext),
                          child: NewsStoryPage(
                            topNewsList: widget.topNewsArticles,
                          ),
                        );
                      }));
                    },
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      width: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(onPressed: () {
                      _navigateAndDisplaySelection(context);
                    }, icon: BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, state) {
                        if (state is LocationLoaded) {
                          currentLocation = state.currentLoaction;
                          return NormalText(
                            text: flagEmoji(currentLocation),
                          );
                        } else {
                          return const Icon(
                            Icons.gps_fixed,
                            color: Colors.white,
                            size: 35,
                          );
                        }
                      },
                    )),
                  ),
                ],
              ),
              const Gap(20),
              const BoldText(
                text: 'Must you know',
                color: Colors.white,
              ),
              const Gap(20),
              NormalText(
                text: formatter,
                color: Colors.white70,
                fontSize: 17,
              ),
              const Gap(20),
              TopNewsArticlesList(
                topNewsArticlse: widget.topNewsArticles,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showLoadingProgressIndicator({required Color indicatorColor}) {
    return Container(
      height: 620,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: indicatorColor,
      ),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: BlocProvider.of<LocationCubit>(context),
                child: LocationPicker(),
              )),
    );
  }

  @override
  void initState() {
    context.read<NewsCubit>().getTopNewsArticles(
          countryCode: countryCode,
        );
    context.read<MainPageNewsCubit>().getNewsWithCountryCodeAndCategory(
          newsCategory: newsCatogeries[currentIndex],
          countryCode: countryCode,
        );

    super.initState();
  }
}
