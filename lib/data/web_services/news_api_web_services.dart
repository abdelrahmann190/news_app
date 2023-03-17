import 'package:dio/dio.dart';

import '../../utils/strings.dart';

class NewsAPIWebServices {
  BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    receiveDataWhenStatusError: true,
    baseUrl: newsAPIBaseUrl,
  );
  late Dio dio;
  Future<List> getTopHeadLineNews({required String countryCode}) async {
    dio = Dio(options);
    Response response = await dio.get(
      '$topHeadLines${countryCode.toLowerCase().trim()}',
    );
    return response.data['results'];
  }

  Future getNewsWithSearchKeyword({
    required String searchKeyword,
  }) async {
    dio = Dio(options);
    Response response =
        await dio.get('$apiKey&country=$countryCode&q=$searchKeyword');
    return response.data['results'];
  }

  Future<List> getNewsWithCountryCodeAndCategory({
    required String newsCategory,
    required String countryCode,
  }) async {
    dio = Dio(options);

    Response response =
        await dio.get('$apiKey&category=$newsCategory&country=$countryCode');
    return response.data['results'];
  }
}
