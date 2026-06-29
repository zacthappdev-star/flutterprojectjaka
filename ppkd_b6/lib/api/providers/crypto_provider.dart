import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b6/api/models/crypto_models.dart';
import 'package:ppkd_b6/api/services/api_services.dart';

enum ProviderState { initial, loading, loaded, error }

class CryptoProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService(Dio());
  
  ProviderState _state = ProviderState.initial;
  ProviderState get state => _state;

  List<CryptoModels> _cryptos = [];
  List<CryptoModels> get cryptos => _cryptos;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  CryptoProvider() {
    fetchCryptos();
  }

  Future<void> fetchCryptos() async {
    _state = ProviderState.loading;
    notifyListeners();

    try {
      _cryptos = await _apiService.getAllCrypto('idr');
      _state = ProviderState.loaded;
    } catch (e) {
      _state = ProviderState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
