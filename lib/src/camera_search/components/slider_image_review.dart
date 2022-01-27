import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import 'package:viettel_app/src/components/widget_container_count_slider.dart';

import '../../../export.dart';

class SliderImageReview extends StatefulWidget {
  num currentPos;

  final List<String> images;

  SliderImageReview({Key? key, required this.currentPos, required this.images})
      : super(key: key);

  @override
  _SliderImageReviewState createState() => _SliderImageReviewState();
}

class _SliderImageReviewState extends State<SliderImageReview> {
  @override
  Widget build(BuildContext context) {
    return widget.images.length > 0
        ? Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      aspectRatio: 1,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 20),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          widget.currentPos = index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      height: MediaQuery.of(context).size.height),
                  items: widget.images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return WidgetImageNetWork(
                          url: i,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.images.length, (index) {
                    return WidgetContainerCountSlider(
                      currentPos: widget.currentPos,
                      index: index,
                    );
                  }),
                ),
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          widget.currentPos = index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      height: MediaQuery.of(context).size.height),
                  items: [
                    0,
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image(
                          image: AssetImage(
                              AssetsConst.errorPlaceHolder),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0].map((i) {
                    return WidgetContainerCountSlider(
                      currentPos: widget.currentPos,
                      index: i,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
  }
}
