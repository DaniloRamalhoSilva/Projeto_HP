class ProductAnalysis {
  final double porcentagemFalso;
  final String explicacao;
  final String? titulo;
  final String? marca;
  final String? modelo;
  final double? preco;
  final String? vendedor;
  final String? qualidadeDescricao;
  final String? qualidadeComentarios;

  const ProductAnalysis({
    required this.porcentagemFalso,
    required this.explicacao,
    this.titulo,
    this.marca,
    this.modelo,
    this.preco,
    this.vendedor,
    this.qualidadeDescricao,
    this.qualidadeComentarios,
  });
}
