// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:news_app/buisness_logic/cubit/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/presentation/widgets/news_page.dart';
import 'package:news_app/presentation/widgets/news_story_page_top_bar.dart';
import 'package:news_app/presentation/widgets/story_page_bottom_icons_bar.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';

class NewsStoryPage extends StatefulWidget {
  final List<News> topNewsList;
  NewsStoryPage({
    Key? key,
    required this.topNewsList,
  }) : super(key: key);

  @override
  State<NewsStoryPage> createState() => _NewsStoryPageState();
}

class _NewsStoryPageState extends State<NewsStoryPage> {
  int currentIndex = 0;
  late bool bookmarked;

  IconData bookmarkIconData = CupertinoIcons.bookmark;
  DragDownDetails? dragDownDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageViewBuilder(context),
    );
  }

  Widget pageViewBuilder(BuildContext mainContext) {
    return PageView.builder(
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
          checkIfNewsBookmarked(mainContext, index);
        },
        itemCount: widget.topNewsList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: const Key('key'),
            resizeDuration: const Duration(microseconds: 100),
            onDismissed: (_) => Navigator.of(context).pop(),
            direction: DismissDirection.down,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    child: widget.topNewsList[index].imageUrl != null
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: 'assets/images/loading.gif',
                            image: widget.topNewsList[index].imageUrl!,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/image_placeholder.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/image_placeholder.jpg',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(60, 0, 0, 0),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 10,
                    ),
                    color: const Color.fromARGB(74, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return NewsPageOpened(
                                singleNews: widget.topNewsList[index],
                              );
                            }));
                          },
                          child: BoldText(
                            text: widget.topNewsList[index].title,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        const Gap(20),
                        NormalText(
                          text: DateFormat('EEEE, LLLL d, y ').format(
                            DateTime.parse(
                              widget.topNewsList[index].pubDate,
                            ),
                          ),
                          color: const Color.fromARGB(226, 255, 255, 255),
                          fontSize: 17,
                        ),
                        const Gap(20),
                        const Divider(
                          color: Colors.white,
                        ),
                        const Gap(20),
                        NormalText(
                          text: widget.topNewsList[index].creator.toString(),
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        const Gap(30),
                        BlocBuilder<BookmarksCubit, BookmarksState>(
                          builder: (context, state) {
                            if (state is NewsBookmarked) {
                              bookmarked = true;
                              bookmarkIconData = CupertinoIcons.bookmark_fill;
                            } else {
                              bookmarked = false;

                              bookmarkIconData = CupertinoIcons.bookmark;
                            }
                            return StoryPageBottomIconsBar(
                              bookmarkIcon: Icon(
                                bookmarkIconData,
                                color: Colors.white,
                              ),
                              bookmarkOnTap: () {
                                if (bookmarked) {
                                  bookmarked = false;
                                  setState(() {
                                    bookmarkIconData = CupertinoIcons.bookmark;
                                  });
                                } else {
                                  bookmarked = true;
                                  setState(() {
                                    bookmarkIconData =
                                        CupertinoIcons.bookmark_fill;
                                  });
                                }
                                final state =
                                    context.read<BookmarksCubit>().state;
                                if (state is NewsBookmarked) {
                                  setState(() {
                                    bookmarkIconData = CupertinoIcons.bookmark;
                                  });
                                  deleteBookmarkedNews(context, index);
                                } else {
                                  setState(() {
                                    bookmarkIconData =
                                        CupertinoIcons.bookmark_fill;
                                  });
                                  bookmarkNews(mainContext, index);
                                }
                              },
                            );
                          },
                        ),
                        const Gap(30),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: NewsStoryTopBar(
                      currentIndex: currentIndex,
                      newsCount: widget.topNewsList.length,
                    ))
              ],
            ),
          );
        });
  }

  void deleteBookmarkedNews(BuildContext context, int index) {
    context
        .read<BookmarksCubit>()
        .deleteBookmark(id: widget.topNewsList[index].id);
  }

  void checkIfNewsBookmarked(BuildContext context, int index) {
    context.read<BookmarksCubit>().checkIfNewsBookmarked(
          id: widget.topNewsList[index].id,
        );
  }

  void bookmarkNews(BuildContext context, int index) {
    BlocProvider.of<BookmarksCubit>(context).postNewsBookMark(
      authorName: widget.topNewsList[index].creator.toString(),
      newsTitle: widget.topNewsList[index].title,
      newsDescribtion: widget.topNewsList[index].content.isNotEmpty
          ? widget.topNewsList[index].content
          : widget.topNewsList[index].description,
      publishedAt: widget.topNewsList[index].pubDate,
      url: widget.topNewsList[index].url,
      imageUrl: widget.topNewsList[index].imageUrl ?? '',
      language: widget.topNewsList[index].language,
      category: widget.topNewsList[index].category,
      id: widget.topNewsList[index].id,
      videoUrl: widget.topNewsList[index].videoUrl,
    );
  }

  @override
  void initState() {
    super.initState();
    checkIfNewsBookmarked(context, 0);
  }
}
