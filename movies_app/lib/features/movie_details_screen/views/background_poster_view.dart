import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BackgroundPoster extends StatelessWidget {
  final String imageUrl;

  const BackgroundPoster({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => const ColoredBox(color: Colors.black12),
      ),
    );
  }
}
