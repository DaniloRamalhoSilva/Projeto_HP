import '../../domain/entities/product_analysis.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProductAnalysis> analyzeProduct(String url) {
    return remoteDataSource.analyze(url);
  }
}
