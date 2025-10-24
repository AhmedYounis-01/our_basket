import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_supabase/core/services/api_sevices.dart';
import 'package:e_commerce_supabase/features/product_details/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'productdetails_state.dart';

class ProductdetailsCubit extends Cubit<ProductdetailsState> {
  ProductdetailsCubit() : super(ProductdetailsInitial());
  final ApiSevices _apiSevices = ApiSevices();
  List<RateModel> rates = [];
  int avgRates = 0;
  int userRate = 5;

  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading());
    try {
      final response = await _apiSevices.getData(
        'rates?select=*&for_users=eq.75354b41-81ad-4d4c-ba10-bbad7956b513&for_products=eq.$productId',
      );
      rates.clear();
      for (final item in (response.data as List<dynamic>)) {
        rates.add(RateModel.fromJson(item as Map<String, dynamic>));
      }
      _getAverageRate();
      _getUserRate();
       emit(GetRateSuccess());
    } catch (e) {
      emit(GetRateError());
    }
  }

  void _getUserRate() {
     List<RateModel> userRates = rates
        .where(
          (RateModel rate) =>
              rate.forUsers == Supabase.instance.client.auth.currentUser!.id,
        )
        .toList();
    if (userRates.isNotEmpty) {
      userRate = userRates.first.rate!; // user Rate
      log('User Rate IS: $userRate');
    }
  }

  void _getAverageRate() {
    for (var avgUser in rates) {
      if (avgUser.rate != null) {
        avgRates += avgUser.rate!;
      }
    }
    avgRates = rates.isNotEmpty ? (avgRates ~/ rates.length) : 0;
  }
}
