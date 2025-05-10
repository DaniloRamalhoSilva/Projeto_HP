import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

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
  
  void _onAnalisar() {
    if (_formKey.currentState!.validate()) {
      // Só simula se a URL passar na validação
      setState(() {
        _porcentagemFalso = 72;
        _explicacao = 'A descrição do produto contém erros ortográficos comuns em itens falsificados.';
      });
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

