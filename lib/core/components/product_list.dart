import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:e_commerce_supabase/core/components/products_card.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:e_commerce_supabase/core/services/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, this.shrinkWrap, this.physics});
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getproducts(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<ProductModel> products = context.read<HomeCubit>().product;
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
