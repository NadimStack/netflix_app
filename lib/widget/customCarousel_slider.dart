import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/model/Top_Rated_Series_Model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCarouselSlider extends StatelessWidget {
  final TopRatedSeries data;

  const CustomCarouselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : (size.height * 0.33),
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final url = data.results[index].backdropPath.toString();
          return InkWell(
            onTap: () {},
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 220,
                      child: CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        imageUrl: '$imgUrl$url',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.results[index].name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: (size.height * 0.33 < 300) ? 300 : (size.height * 0.33),
          initialPage: 0,
          autoPlay: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,  // Allows for part of the next/previous items to be visible
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          reverse: false,
          scrollDirection: Axis.horizontal,
          enlargeCenterPage: true,
        ),

      ),
    );
  }
}
