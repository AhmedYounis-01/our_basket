import 'package:e_commerce_supabase/core/components/custom_circular_ind.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client
          .from("comments")
          .stream(primaryKey: ["id"])
          .eq("for_products", productModel.productId)
          .order("created_at"),
      builder: (_, snapshot) {
        List<Map<String, dynamic>>? data = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularIndicator());
        } else if (snapshot.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                UserComment(commentData: data?[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: data?.length ?? 0,
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text("No Comments Yet"));
        } else {
          return const Center(
            child: Text("Something went error , please try again."),
          );
        }
      },
    );
  }
}

class UserComment extends StatelessWidget {
  const UserComment({super.key, required this.commentData});
  // this structural programming not good , but to save time i used it ,, //! better use model class
  final Map<String, dynamic>? commentData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              commentData?["user_name"] ?? "User Name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(children: [Text(commentData?["comment"] ?? "Comment")]),
        commentData?["replay"] != null
            ? Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Replay:-",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(children: [Text(commentData!["replay"])]),
                ],
              )
            : Container(),
      ],
    );
  }
}
