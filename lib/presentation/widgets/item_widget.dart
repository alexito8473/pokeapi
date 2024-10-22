import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:pokeapi/data/model/item.dart';

class ItemWidget extends StatefulWidget {
  final Item item;
  const ItemWidget({super.key, required this.item});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureFlipCard(
        animationDuration: const Duration(milliseconds: 500),
        axis: FlipAxis.vertical,
        enableController: false,
        frontWidget: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.item.name,
                style: const TextStyle(fontSize: 20, letterSpacing: 2),
              ),
              CachedNetworkImage(
                imageUrl: widget.item.sprite,
                width: size.width * 0.15,
                height: size.width * 0.15,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                progressIndicatorBuilder: (context, url, progress) {
                  return const CircularProgressIndicator(color: Colors.blue);
                },
              )
            ],
          ),
        ),
        backWidget: Container(
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Cost: ${widget.item.cost.toString()}",
                    style: const TextStyle(fontSize: 10, letterSpacing: 2),
                  ),
                  Text(
                    widget.item.descriptionEn,
                    style: TextStyle(fontSize: 10, letterSpacing: 2),
                  ),
                ],
              )),
        ));
  }
}
