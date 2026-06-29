import 'package:dio/dio.dart';
import 'package:ppkd_b6/api/models/crypto_models.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/coins/markets')
  Future<List<CryptoModels>> getAllCrypto(
    @Query('vs_currency') String currency,
  );

  @GET('/coins/{id}/market_chart')
  Future<dynamic> getCryptoChart(
    @Path('id') String id,
    @Query('vs_currency') String currency,
    @Query('days') int days,
  );
}
