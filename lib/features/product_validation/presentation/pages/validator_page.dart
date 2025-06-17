import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/product_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product_analysis.dart';
import '../../domain/usecases/analyze_product.dart';

class ValidatorPage extends StatefulWidget {
  static const routeName = '/';
  const ValidatorPage({super.key});

  @override
  State<ValidatorPage> createState() => _ValidatorPageState();
}

class _ValidatorPageState extends State<ValidatorPage> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RegExp _mlUrl = RegExp(r'^https?://(?:[a-z0-9-]+\.)*mercadolivre\.com\.br/.+',caseSensitive: false,);

  ProductAnalysis? _analysis;
  late final AnalyzeProduct _analyzeUseCase;

  @override
  void initState() {
    super.initState();
    final dataSource = ProductRemoteDataSource(http.Client());
    final repository = ProductRepositoryImpl(dataSource);
    _analyzeUseCase = AnalyzeProduct(repository);
  }

  Future<void> _onAnalyze() async {
    if (_formKey.currentState!.validate()) {
      final url = _controller.text.trim();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const AlertDialog(
          content: SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Aguarde, estamos realizando a análise...'),
              ],
            ),
          ),
        ),
      );
      try {
        final result = await _analyzeUseCase(url);
        setState(() {
          _analysis = result;
        });
      } catch (_) {
        setState(() {
          _analysis = null;
        });
      } finally {
        if (mounted) Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004F9F),
        title: Image.asset('assets/hp_logo_branco.png', height: 32),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildFormCard(),
            const SizedBox(height: 20),
            if (_analysis != null && _analysis!.titulo != null)
              _buildProductCard(),
            if (_analysis != null && _analysis!.titulo != null)
              const SizedBox(height: 20),
            if (_analysis != null) _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Cole o link do Mercado Livre',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'https://www.mercadolivre.com.br/...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um link.';
                  }
                  if (!_mlUrl.hasMatch(value.trim())) {
                    return 'Insira um link valido do Mercado Livre.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _onAnalyze,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0072CE),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text('Analisar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text('Titulo: ${_analysis!.titulo}'),
            Text('Marca: ${_analysis!.marca}'),
            Text('Modelo: ${_analysis!.modelo}'),
            if (_analysis!.preco != null)
              Text('Preco: R\$ ${_analysis!.preco!.toStringAsFixed(2)}'),
            Text('Vendedor: ${_analysis!.vendedor}'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Resultado da Analise',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: _analysis!.porcentagemOriginal,
                          color: const Color(0xFF0072CE),
                          radius: 20,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 100 - _analysis!.porcentagemOriginal,
                          color: Colors.grey[300]!,
                          radius: 20,
                          showTitle: false,
                        ),
                      ],
                      sectionsSpace: 0,
                      centerSpaceRadius: 90,
                    ),
                  ),
                  Text(
                    '${_analysis!.porcentagemOriginal.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_analysis!.qualidadeDescricao != null)
              Text(
                'Qualidade da descricao: ${_analysis!.qualidadeDescricao}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            if (_analysis!.qualidadeComentarios != null)
              Text(
                'Qualidade dos comentarios: ${_analysis!.qualidadeComentarios}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 12),
            Text(
              _analysis!.explicacao,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
