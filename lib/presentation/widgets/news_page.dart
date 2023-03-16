// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/presentation/widgets/open_news_image.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';
import 'package:news_app/utils/dimensions.dart';

import 'video_player.dart';

class NewsPageOpened extends StatelessWidget {
  final News singleNews;
  const NewsPageOpened({
    Key? key,
    required this.singleNews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                const Gap(10),
                Text(
                  singleNews.title,
                  textAlign: singleNews.language == 'arabic'
                      ? TextAlign.right
                      : TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Gap(20),
                NormalText(
                  text: DateFormat('EEEE, LLLL d, y ').format(
                    DateTime.parse(
                      singleNews.pubDate,
                    ),
                  ),
                  color: Colors.black38,
                  fontSize: 17,
                ),
                const Gap(40),
                NormalText(
                  text: singleNews.creator.isNotEmpty
                      ? "by : ${singleNews.creator}"
                      : 'Unknown author',
                  color: Colors.black,
                  fontSize: 15,
                ),
                const Gap(20),
              ],
            ),
          ),
          SizedBox(
              width: double.infinity,
              height: ScreenDimensions.getDynamicHeight(
                context: context,
                height: 460,
              ),
              child: CustomScrollView(
                slivers: [
                  buildSilverAppBar(context),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const Gap(30),
                    SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            children: [
                              // const Gap(20),
                              singleNews.content.isNotEmpty
                                  ? NormalText(
                                      textAlign: singleNews.language == 'arabic'
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      text: singleNews.content,
                                      fontSize: 20,
                                    )
                                  : NormalText(
                                      textAlign: singleNews.language == 'arabic'
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      text: singleNews.description.isNotEmpty
                                          ? singleNews.description
                                          : 'Unavailable article',
                                      fontSize: 20,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]))
                ],
              )),
        ],
      ),
    );
  }

  Widget buildSilverAppBar(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      expandedHeight: ScreenDimensions.getDynamicHeight(
        context: context,
        height: 200,
      ),
      pinned: false,
      stretch: false,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(background: openNewsContent(context)),
    );
  }

  Widget openNewsContent(BuildContext context) {
    if (singleNews.videoUrl.isNotEmpty) {
      return VideoPlayerWithChewie(
        videoPlayerLink: singleNews.videoUrl,
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return OpenNewsImage(
              newsImageUrl: singleNews.imageUrl,
            );
          }));
        },
        child: singleNews.imageUrl != null
            ? FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: singleNews.imageUrl!,
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
      );
    }
  }
}
