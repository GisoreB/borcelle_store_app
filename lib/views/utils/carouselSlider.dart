import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatefulWidget {
  final List<String> images;
  final List<Icon>? icon;
  final List<String>? text;

  const CarouselWidget({super.key, required this.images, this.icon, this.text});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.images.asMap().entries.map((entry) {
        int id = entry.key;
        String image = entry.value;
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 3, right: 3, top: 5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white70,
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              if (widget.icon != null && id < widget.icon!.length)
                widget.icon![id],
              if (widget.text != null && id < widget.text!.length)
                Text(widget.text![id], style: const TextStyle(fontSize: 16.0)),
            ],
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 190.0,
        autoPlay: true,
        viewportFraction: 0.9500,
        enlargeCenterPage: false,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInBack,
        pauseAutoPlayOnTouch: true,
        scrollDirection: Axis.horizontal,
        initialPage: 2,
        enableInfiniteScroll: true,
        reverse: false,
      ),
    );
  }
}