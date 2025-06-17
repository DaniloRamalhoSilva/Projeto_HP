import '../../domain/entities/product_analysis.dart';

class ProductAnalysisModel extends ProductAnalysis {
  const ProductAnalysisModel({
    required double porcentagemOriginal,
    required String explicacao,
    String? titulo,
    String? marca,
    String? modelo,
    double? preco,
    String? vendedor,
    String? qualidadeDescricao,
    String? qualidadeComentarios,
  }) : super(
          porcentagemOriginal: porcentagemOriginal,
          explicacao: explicacao,
          titulo: titulo,
          marca: marca,
          modelo: modelo,
          preco: preco,
          vendedor: vendedor,
          qualidadeDescricao: qualidadeDescricao,
          qualidadeComentarios: qualidadeComentarios,
        );

  factory ProductAnalysisModel.fromJson(Map<String, dynamic> json) {
    return ProductAnalysisModel(
      porcentagemOriginal: (json['percentagem'] as num?)?.toDouble() ?? 0,
      explicacao: json['justificativa'] ?? '',
      titulo: json['titulo'],
      marca: json['marca'],
      modelo: json['modelo'],
      preco: (json['preco'] as num?)?.toDouble(),
      vendedor: json['vendedor'],
      qualidadeDescricao: json['qualidade_descricao'],
      qualidadeComentarios: json['qualidade_comentarios'],
    );
  }
}
