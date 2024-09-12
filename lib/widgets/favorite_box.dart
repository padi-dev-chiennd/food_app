import 'package:flutter/material.dart';
import 'package:food_app/theme/color.dart';

class FavoriteBox extends StatefulWidget {
  const FavoriteBox({
    super.key,
    this.padding = 5,
    this.iconSize = 18,
    this.isFavorited = false,
    this.onTap,
  });

  final double padding;
  final double iconSize;
  final bool isFavorited;
  final GestureTapCallback? onTap;

  @override
  _FavoriteBoxState createState() => _FavoriteBoxState();
}

class _FavoriteBoxState extends State<FavoriteBox> {
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    isFavorited = widget.isFavorited;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorited = !isFavorited;
        });

        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: const BoxDecoration(color: primary, shape: BoxShape.circle),
        child: Icon(
          isFavorited ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          size: widget.iconSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
