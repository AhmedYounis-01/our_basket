import 'package:e_commerce_supabase/core/components/custom_net_img.dart';
import 'package:e_commerce_supabase/core/function/navigate_to.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/product_details/ui/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final Function()? onFavoriteTap;
  final Function()? onFavoriteRemove;
  final bool isFavorite;

  const ProductCard({
    super.key,
    required this.product,
    this.onFavoriteTap,
    required this.isFavorite,
    this.onFavoriteRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(context, ProductDetailsScreen(product: product)),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: CustomNetworkImage(url: product.imageUrl),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(color: AppColors.kPrimaryColor),
                    child: Center(
                      child: Text(
                        "${product.sale} % offer",
                        style: const TextStyle(color: AppColors.kWhiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: onFavoriteTap,
                    icon: Icon(Icons.favorite),
                    color: isFavorite
                        ? AppColors.kPrimaryColor
                        : AppColors.kBordersideColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        product.price.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.oldPrice.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                      foregroundColor: AppColors.kWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
