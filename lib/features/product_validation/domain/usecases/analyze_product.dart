import '../entities/product_analysis.dart';
import '../repositories/product_repository.dart';

class AnalyzeProduct {
  final ProductRepository repository;
  AnalyzeProduct(this.repository);

  Future<ProductAnalysis> call(String url) {
    return repository.analyzeProduct(url);
  }
}
