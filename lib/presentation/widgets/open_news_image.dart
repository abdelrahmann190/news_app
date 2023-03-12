// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OpenNewsImage extends StatefulWidget {
  final String? newsImageUrl;
  const OpenNewsImage({
    Key? key,
    required this.newsImageUrl,
  }) : super(key: key);

  @override
  State<OpenNewsImage> createState() => _OpenNewsImageState();
}

class _OpenNewsImageState extends State<OpenNewsImage> {
  TransformationController controller = TransformationController();
  TapDownDetails? tapDownDetails;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('key'),
      direction: DismissDirection.vertical,
      onDismissed: (direction) {
        Navigator.of(context).pop();
      },
      resizeDuration: const Duration(microseconds: 10),
      child: GestureDetector(
        onDoubleTapDown: (details) {
          tapDownDetails = details;
        },
        onDoubleTap: () {
          final position = tapDownDetails!.localPosition;
          const double scale = 3;
          final x = -position.dx * (scale - 1);
          final y = -position.dy * (scale - 1);

          final zoomed = Matrix4.identity()
            ..translate(x, y)
            ..scale(scale);
          final value =
              controller.value.isIdentity() ? zoomed : Matrix4.identity();
          controller.value = value;
        },
        child: InteractiveViewer(
          transformationController: controller,
          child: widget.newsImageUrl != null
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: widget.newsImageUrl!,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/image_placeholder.jpg',
                      fit: BoxFit.contain,
                    );
                  },
                  fit: BoxFit.contain,
                )
              : Image.asset(
                  'assets/images/image_placeholder.jpg',
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
