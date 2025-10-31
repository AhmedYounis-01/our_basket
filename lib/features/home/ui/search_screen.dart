import 'package:e_commerce_supabase/core/components/product_list.dart';
import 'package:e_commerce_supabase/core/function/custom_appbar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Search Results"),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ProductsList(query: query),
        ],
      ),
    );
  }
}
