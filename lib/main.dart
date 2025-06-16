import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const HPValidatorApp());

class HPValidatorApp extends StatelessWidget {
  const HPValidatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validador HP',
      theme: ThemeData(
        primaryColor: const Color(0xFF004F9F),
        textTheme: GoogleFonts.robotoTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const ValidadorPage(),
    );
  }
}

class ValidadorPage extends StatefulWidget {
  const ValidadorPage({super.key});

  @override
  State<ValidadorPage> createState() => _ValidadorPageState();
}

class _ValidadorPageState extends State<ValidadorPage> {
  // Já inicializa com a URL de teste:
  final TextEditingController _controller = TextEditingController(
    text: 'https://www.mercadolivre.com.br/exemplo-produto1234',
  );
  
  final _formKey = GlobalKey<FormState>();
  //final TextEditingController _controller = TextEditingController();
  final RegExp _mlUrl = RegExp(r'^https?://(www\.)?mercadolivre\.com\.br/.+');
  
  double? _porcentagemFalso;
  String? _explicacao;
  String? _titulo;
  String? _marca;
  String? _modelo;
  double? _preco;
  String? _vendedor;
  String? _qualidadeDescricao;
  String? _qualidadeComentarios;
  
  Future<void> _onAnalisar() async {
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
                Text('Aguarde, estamos realizando a analise...'),
              ],
            ),
          ),
        ),
      );

      try {
        final response = await http.get(
          Uri.parse('http://localhost:8000/scrape?url=${Uri.encodeComponent(url)}'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _titulo = data['titulo'];
            _marca = data['marca'];
            _modelo = data['modelo'];
            _preco = (data['preco'] as num?)?.toDouble();
            _vendedor = data['vendedor'];
            _qualidadeDescricao = data['qualidade_descricao'];
            _qualidadeComentarios = data['qualidade_comentarios'];
            _porcentagemFalso = (data['percentagem'] as num?)?.toDouble();
            _explicacao = data['justificativa'];
          });
        } else {
          setState(() {
            _explicacao = 'Erro ao realizar a analise.';
            _porcentagemFalso = null;
          });
        }
      } catch (e) {
        setState(() {
          _explicacao = 'Erro ao realizar a analise.';
          _porcentagemFalso = null;
        });
      } finally {
        Navigator.of(context).pop();
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card 1 com Form
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,  // <-- conecta o Form
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
                            return 'Insira um link válido do Mercado Livre.';
                          }
                          return null; // tudo OK
                        },
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _onAnalisar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0072CE),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: const Text('Analisar Produto'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_titulo != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
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
                      Text('Título: $_titulo'),
                      Text('Marca: $_marca'),
                      Text('Modelo: $_modelo'),
                      if (_preco != null)
                        Text('Preço: R$ ${_preco!.toStringAsFixed(2)}'),
                      Text('Vendedor: $_vendedor'),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            // Card 2 - Resultado (mantém igual)
            if (_porcentagemFalso != null)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Resultado da Análise',
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
                                    value: _porcentagemFalso!,
                                    color: const Color(0xFF0072CE),
                                    radius: 20,
                                    showTitle: false,
                                  ),
                                  PieChartSectionData(
                                    value: 100 - _porcentagemFalso!,
                                    color: Colors.grey[300]!,
                                    radius: 20,
                                    showTitle: false,
                                  ),
                                ],
                                sectionsSpace: 0,
                                centerSpaceRadius: 90,
                              ),
                            ),
                            // Texto centralizado sobre o gráfico
                            Text(
                              '${_porcentagemFalso!.toStringAsFixed(0)}%',
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
                      if (_qualidadeDescricao != null)
                        Text(
                          'Qualidade da descrição: $_qualidadeDescricao',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      if (_qualidadeComentarios != null)
                        Text(
                          'Qualidade dos comentários: $_qualidadeComentarios',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        _explicacao ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}

