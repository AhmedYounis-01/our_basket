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
  var userId = Supabase.instance.client.auth.currentUser!.id;

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
    List<RateModel> userRates = rates.where((RateModel rate) {
      return rate.forUsers == userId;
    }).toList();
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

  bool _isUserRateExist({required String productId}) {
    for (var rate in rates) {
      if ((rate.forUsers == userId) && (rate.forProducts == productId)) {
        return true;
      }
    }
    return false;
  }

  Future<void> addOrUpdateRate({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    final String path =
        'rates?select=*&for_users=eq.$userId&for_products=eq.$productId';
    try {
      if (_isUserRateExist(productId: productId)) {
        // update rate
        await _apiSevices.patchData(path, data);
      } else {
        // add rate
        await _apiSevices.postData(path, data);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
