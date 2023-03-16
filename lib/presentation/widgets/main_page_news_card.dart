// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:news_app/buisness_logic/cubit/bookmarks_cubit/bookmarks_cubit.dart';

import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';

import '../../utils/dimensions.dart';
import 'news_page.dart';

class MainNewsPageCard extends StatelessWidget {
  final bool isDismissible;
  final List<News> mainNewsList;
  const MainNewsPageCard({
    Key? key,
    required this.isDismissible,
    required this.mainNewsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mainNewsList.length,
        itemBuilder: (context, index) {
          return isDismissible
              ? buildDismissibleWidget(context, index)
              : buildNewsWidget(context, index);
        });
  }

  Widget buildDismissibleWidget(BuildContext context, int index) {
    return Dismissible(
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete,
          color: Colors.grey,
          size: ScreenDimensions.getDynamicWidth(
            context: context,
            width: 50,
          ),
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.grey,
          size: 50,
        ),
      ),
      key: const Key('dismissble_key'),
      onDismissed: (direction) {
        context
            .read<BookmarksCubit>()
            .deleteBookmark(id: mainNewsList[index].id);
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return NewsPageOpened(singleNews: mainNewsList[index]);
              },
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: ScreenDimensions.getDynamicWidth(
                  context: context,
                  width: 200,
                ),
                child: Text(
                  mainNewsList[index].creator.isNotEmpty
                      ? (mainNewsList[index].creator is String
                          ? mainNewsList[index].creator
                          : mainNewsList[index].creator.toString())
                      : 'Author unknown',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 220,
                    child: Text(
                      mainNewsList[index].title,
                      textAlign: mainNewsList[index].language == 'arabic'
                          ? TextAlign.right
                          : TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: mainNewsList[index].imageUrl != null
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: 'assets/images/loading.gif',
                            image: mainNewsList[index].imageUrl!,
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
                            // width: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
              const Gap(10),
              NormalText(
                text: 'this ${DateFormat('EEEE').format(
                  DateTime.parse(
                    mainNewsList[index].pubDate,
                  ),
                )}'
                    .toLowerCase(),
                color: Colors.black,
                fontSize: 15,
              ),
              const Gap(5),
              const Divider(
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewsWidget(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return NewsPageOpened(singleNews: mainNewsList[index]);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: ScreenDimensions.getDynamicWidth(
                context: context,
                width: 200,
              ),
              child: Text(
                mainNewsList[index].creator.isNotEmpty
                    ? (mainNewsList[index].creator is String
                        ? mainNewsList[index].creator
                        : mainNewsList[index].creator.toString())
                    : 'Author unknown',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ScreenDimensions.getDynamicWidth(
                    context: context,
                    width: 220,
                  ),
                  child: Text(
                    mainNewsList[index].title,
                    textAlign: mainNewsList[index].language == 'arabic'
                        ? TextAlign.right
                        : TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenDimensions.getDynamicWidth(
                    context: context,
                    width: 100,
                  ),
                  height: ScreenDimensions.getDynamicHeight(
                    context: context,
                    height: 100,
                  ),
                  child: mainNewsList[index].imageUrl != null
                      ? FadeInImage.assetNetwork(
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: 'assets/images/loading.gif',
                          image: mainNewsList[index].imageUrl!,
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
                          // width: 200,
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
            const Gap(10),
            NormalText(
              text: 'this ${DateFormat('EEEE').format(
                DateTime.parse(
                  mainNewsList[index].pubDate,
                ),
              )}'
                  .toLowerCase(),
              color: Colors.black,
              fontSize: 15,
            ),
            const Gap(5),
            const Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
