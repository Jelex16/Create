import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget(
      {super.key, required this.images, this.height = 500, this.width = 500});
  final List<String> images;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        options: CarouselOptions(
          autoPlay: images.length > 1 ? true : false,
          pageSnapping: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
          aspectRatio: 0.9,
          initialPage: 0,
        ),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            SizedBox(
                height: height,
                width: width,
                child: FadeInImage(
                  image: NetworkImage(
                    images[itemIndex],
                  ),
                  fit: BoxFit.cover,
                  placeholderFit: BoxFit.fitWidth,
                  placeholder: const AssetImage(
                    CustomAssets.noImage,
                  ),
                )));
  }
}
