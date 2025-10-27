import 'package:dio/dio.dart';
import 'package:e_commerce_supabase/core/services/sensitive_data.dart';

class ApiSevices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://mxgcypikbuuipodksmqe.supabase.co/rest/v1/",
      headers: {"apikey": anonKey},
    ),
  );

  Future<Response> getData(String path) async => await _dio.get(path);

  Future<Response> postData(String path, Map<String, dynamic> data) async =>
      await _dio.post(path, data: data);

  Future<Response> patchData(String path, Map<String, dynamic> data) async =>
      await _dio.patch(path, data: data);

  Future<Response> deleteData(String path) async => await _dio.delete(path);
}
