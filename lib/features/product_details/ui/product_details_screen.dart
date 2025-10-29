import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:e_commerce_supabase/core/components/custom_net_img.dart';
import 'package:e_commerce_supabase/core/function/navigate_without_back.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:e_commerce_supabase/features/auth/logic/cubit/auth_cubit.dart';
import 'package:e_commerce_supabase/features/product_details/logic/cubit/productdetails_cubit.dart';
import 'package:e_commerce_supabase/features/product_details/ui/widget/comments_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductdetailsCubit()..getRates(productId: widget.product.productId),
      child: BlocConsumer<ProductdetailsCubit, ProductdetailsState>(
        listener: (context, state) {
          if (state is AddOrUpdateRateSuccess) {
            navigateWithoutBack(context, widget);
          }
        },
        builder: (context, state) {
          ProductdetailsCubit cubit = context.read<ProductdetailsCubit>();

          return Scaffold(
            appBar: AppBar(title: Text(widget.product.productName)),
            body: state is GetRateLoading
                ? const Center(child: CustomCircularIndicator())
                : ListView(
                    children: [
                      Container(
                        height: 300,
                        color: Colors.grey[300],
                        child: widget.product.imageUrl.isEmpty
                            ? const Icon(Icons.image)
                            : CustomNetworkImage(url: widget.product.imageUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.product.productName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${widget.product.price} LE",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${cubit.avgRates} ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Icon(Icons.star, color: Colors.amber),
                                  ],
                                ),
                                const Icon(Icons.favorite, color: Colors.grey),
                              ],
                            ),
                            const SizedBox(height: 30),

                            Center(
                              child: Column(
                                children: [
                                  const Text(
                                    "Product Description",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  RatingBar.builder(
                                    initialRating: cubit.userRate.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      cubit.addOrUpdateRate(
                                        productId: widget.product.productId,
                                        data: {
                                          "rate": rating.toInt(),
                                          "for_users": cubit.userId,
                                          "for_products":
                                              widget.product.productId,
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                labelText: "Type your feedback",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    await context
                                        .read<AuthCubit>()
                                        .getUserData();
                                    await cubit.addComments(
                                      data: {
                                        "comment": _commentController.text,
                                        "for_users": cubit.userId,
                                        "for_products":
                                            widget.product.productId,
                                        "user_name":
                                            // ignore: use_build_context_synchronously
                                            context
                                                .read<AuthCubit>()
                                                .userModel
                                                ?.name ??
                                            "User Name",
                                      },
                                    );
                                    _commentController.clear();
                                  },
                                  icon: const Icon(Icons.send),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Comments",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            CommentsList(productModel: widget.product),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
