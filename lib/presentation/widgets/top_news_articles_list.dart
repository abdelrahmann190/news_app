// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:news_app/presentation/widgets/news_page.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';

import '../../data/models/news_model.dart';

class TopNewsArticlesList extends StatelessWidget {
  final List<News> topNewsArticlse;
  const TopNewsArticlesList({
    Key? key,
    required this.topNewsArticlse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 380,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topNewsArticlse.length,
        itemBuilder: (context, index) {
          return listViewItem(index, context);
        },
      ),
    );
  }

  Widget listViewItem(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return NewsPageOpened(
            singleNews: topNewsArticlse[index],
          );
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: topNewsArticlse[index].imageUrl != null
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: topNewsArticlse[index].imageUrl!,
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
            const Gap(20),
            Text(
              topNewsArticlse[index].title,
              textAlign: topNewsArticlse[index].language == 'arabic'
                  ? TextAlign.right
                  : TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(10),
            NormalText(
              text: 'this ${DateFormat('EEEE').format(
                DateTime.parse(
                  topNewsArticlse[index].pubDate,
                ),
              )}'
                  .toLowerCase(),
              color: Colors.white54,
              fontSize: 15,
            ),
            const Gap(10),
            Text(
              topNewsArticlse[index].creator.isNotEmpty
                  ? (topNewsArticlse[index].creator is String
                      ? topNewsArticlse[index].creator
                      : topNewsArticlse[index].creator[0])
                  : 'Author unknown',
              textAlign: topNewsArticlse[index].language == 'arabic'
                  ? TextAlign.right
                  : TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
