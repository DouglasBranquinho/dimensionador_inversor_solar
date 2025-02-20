import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dimensionador_inversor/main.dart';

void main() {
  testWidgets('Testa o cálculo de energia diária', (WidgetTester tester) async {
    // Construir o app
    await tester.pumpWidget(DimensionadorApp());

    // Verificar se o app iniciou com os campos vazios
    expect(find.text('Nome do Aparelho'), findsOneWidget);
    expect(find.text('Potência (W)'), findsOneWidget);
    expect(find.text('Horas de Uso Diário'), findsOneWidget);

    // Preencher os campos com dados
    await tester.enterText(find.byType(TextField).first, 'Geladeira');
    await tester.enterText(find.byType(TextField).at(1), '350');
    await tester.enterText(find.byType(TextField).last, '24');

    // Simular o clique no botão "Calcular"
    await tester.tap(find.text('Calcular'));
    await tester.pump();

    // Verificar se os resultados são exibidos corretamente
    expect(find.text('Total de Energia Diária: 8400.00 Wh'), findsOneWidget);
    expect(find.text('Capacidade da Bateria: 700.00 Ah'), findsOneWidget);
  });
}
