import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_analysis_model.dart';

class ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSource(this.client);

  Future<ProductAnalysisModel> analyze(String url) async {
    final response = await client.get(
      Uri.parse('http://localhost:8000/scrape?url=${Uri.encodeComponent(url)}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return ProductAnalysisModel.fromJson(data);
    } else {
      throw Exception('Erro ao realizar a analise');
    }
  }
}
