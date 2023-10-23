import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_image_error_widget.dart';
import 'app_image_loading_widget.dart';

const kSizeImageCache = 100;

class AppImageWidget extends StatelessWidget {
  const AppImageWidget(
      {Key? key, required this.url, this.width = 54, this.height = 54})
      : super(key: key);
  final String url;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      imageUrl: url,
      maxWidthDiskCache: kSizeImageCache,
      memCacheWidth: kSizeImageCache,
      cacheKey: url,
      placeholder: (BuildContext context, url) => const AppImageLoadingWidget(),
      errorWidget: (BuildContext context, url, err) => AppImageErrorWidget(
        width: width,
        height: height,
      ),
    );
  }
}
