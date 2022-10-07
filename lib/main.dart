import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first(),
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  final controller = CarouselController();
  int activeindex = 0;
  final imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider.builder(
                  itemCount: imgList.length,
                  itemBuilder: (context, index, realIndex) {
                    final image = imgList[index];
                    return buildImage(image, index);
                  },
                  carouselController: controller,
                  options: CarouselOptions(
                      height: 400,
                      autoPlay: true,
                      reverse: false,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeindex = index;
                        });
                      },
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlayInterval: Duration(seconds: 2))),
              SizedBox(
                height: 5,
              ),
              buildIndicator(),
              SizedBox(
                height: 10,
              ),
              buildButtons(),
            ],
          ),
        ));
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeindex,
      count: imgList.length,
      effect: JumpingDotEffect(
          dotWidth: 20,
          dotHeight: 20,
          dotColor: Colors.grey,
          activeDotColor: Colors.black),
    );
  }

  Widget buildImage(String image, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(image, fit: BoxFit.cover),
    );
  }

  Widget buildButtons() {
    return Row(
      children: [
        Spacer(),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10)),
            onPressed: () {
              privous();
            },
            child: Icon(Icons.arrow_back)),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10)),
            onPressed: () {
              next();
            },
            child: Icon(Icons.arrow_forward)),
        Spacer(),
      ],
    );
  }

  void privous() {
    controller.previousPage(duration: Duration(milliseconds: 500));
  }

  void next() {
    controller.nextPage(duration: Duration(milliseconds: 500));
  }
}
