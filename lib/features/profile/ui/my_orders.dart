import 'package:e_commerce_supabase/core/components/product_list.dart';
import 'package:e_commerce_supabase/core/function/custom_appbar.dart';
import 'package:flutter/material.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "My Orders"),
      body: SingleChildScrollView(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ProductsList(isUserOrderView: true),
        ),
      ),
    );
  }
}
