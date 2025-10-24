import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_supabase/core/models/product_model.dart';
import 'package:e_commerce_supabase/core/services/api_sevices.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiSevices _apiSevices = ApiSevices();

  List<ProductModel> product = [];
  Future<void> getproducts() async {
    emit(HomeLoading());
    try {
      final response = await _apiSevices.getData(
        'products?select=*,favorite_products(*),purchase(*)',
      );
      product.clear();
      for (final item in (response.data as List<dynamic>)) {
        product.add(ProductModel.fromJson(item as Map<String, dynamic>));
      }
      // log(response.data.toString());
      emit(HomeSuccess());
    } catch (e) {
      log(e.toString());
      emit(HomeError());
    }
  }
}
