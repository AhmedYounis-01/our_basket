import 'package:e_commerce_supabase/core/components/product_list.dart';
import 'package:e_commerce_supabase/core/function/custom_appbar.dart';
import 'package:flutter/material.dart';

class MyOrdersViwe extends StatelessWidget {
  const MyOrdersViwe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "My Orders"),
      body: const Padding(padding: EdgeInsets.all(8.0), child: ProductsList()),
    );
  }
}
