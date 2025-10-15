import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => CustomCircularIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
