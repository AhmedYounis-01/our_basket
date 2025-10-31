import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:e_commerce_supabase/core/components/products_card.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:e_commerce_supabase/core/services/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, this.shrinkWrap, this.physics, this.query});
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getproducts(qurey: query),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<ProductModel> products = query != null && query!.isNotEmpty
              ? context.read<HomeCubit>().searchResults
              : context.read<HomeCubit>().products;
          return state is HomeLoading
              ? const Center(child: CustomCircularIndicator())
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ProductCard(product: products[index]),
                );
        },
      ),
    );
  }
}
