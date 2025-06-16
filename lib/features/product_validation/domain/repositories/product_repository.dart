import '../entities/product_analysis.dart';

abstract class ProductRepository {
  Future<ProductAnalysis> analyzeProduct(String url);
}
