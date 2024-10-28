import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:pokeapi/data/model/item.dart';

class CardItemWidget extends StatelessWidget {
  final ListItemCategory itemCategory;
  final bool isActive;
  final Function function;
  const CardItemWidget(
      {super.key,
      required this.itemCategory,
      required this.isActive,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        width: 170,
        height: 50,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isActive ? Colors.yellow : Colors.red[900],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.black)),
        alignment: Alignment.center,
        child: AutoSizeText(itemCategory.name,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureFlipCard(
        animationDuration: const Duration(milliseconds: 500),
        axis: FlipAxis.vertical,
        enableController: false,
        frontWidget: Container(
          padding: EdgeInsets.all(size.width * 0.05),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                item.name,
                maxLines: 1,
                style: const TextStyle(fontSize: 20, letterSpacing: 2),
              ),
              item.sprite.substring(0, 5) == "https"
                  ? CachedNetworkImage(
                      imageUrl: item.sprite,
                      width: size.width * 0.15,
                      height: size.width * 0.15,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      progressIndicatorBuilder: (context, url, progress) =>
                          const CircularProgressIndicator(color: Colors.blue),
                    )
                  : Image.asset(item.sprite,
                      width: size.width * 0.15,
                      height: size.width * 0.15,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high)
            ],
          ),
        ),
        backWidget: Container(
            padding: EdgeInsets.all(size.width * 0.03),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        "Cost: ${item.cost.toString()}",
                        style: const TextStyle(fontSize: 10, letterSpacing: 2),
                      ),
                  Expanded(
                      child: AutoSizeText(
                    item.descriptionEn,
                    maxLines: 10,
                    style: const TextStyle(fontSize: 10, letterSpacing: 2),
                  ))
                ])));
  }
}
