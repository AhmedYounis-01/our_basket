import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:e_commerce_supabase/core/components/products_card.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:e_commerce_supabase/core/services/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.query,
    this.category,
    this.isFavoriteView = false,
  });

  final String? query;
  final String? category;
  final bool isFavoriteView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProducts(qurey: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();
          List<ProductModel> products = query != null && query!.isNotEmpty
              ? homeCubit.searchResults
              : category != null && category!.isNotEmpty
              ? homeCubit.categoryProducts
              : isFavoriteView
              ? homeCubit.favoriteProductList
              : homeCubit.products;

          if (state is HomeLoading) {
            return const Center(child: CustomCircularIndicator());
          }

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_basket_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    query != null && query!.isNotEmpty
                        ? 'No products found for your search'
                        : category != null && category!.isNotEmpty
                        ? 'No products in this category yet'
                        : 'No products available yet',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
          //! >> use ListView.builder But Without (((shrinkWrap))) instead of column to improve performance
          return Column(
            children: products
                .map(
                  (ProductModel product) => ProductCard(
                    onPaymentSuccess: () {
                      homeCubit.purchaseProduct(product.productId);
                    },
                    product: product,
                    isFavorite: homeCubit.checkIfFavoureite(product.productId),
                    onFavoriteTap: () {
                      bool isFav = homeCubit.checkIfFavoureite(
                        product.productId,
                      );
                      if (!isFav) {
                        homeCubit.addToFavorites(product.productId);
                      } else {
                        homeCubit.removeFavorite(product.productId);
                      }
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
