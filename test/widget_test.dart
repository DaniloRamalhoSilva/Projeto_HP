import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_hp/main.dart';

void main() {
  testWidgets('App loads validator page', (tester) async {
    await tester.pumpWidget(const HPValidatorApp());
    expect(find.text('Analisar Produto'), findsOneWidget);
  });
}
