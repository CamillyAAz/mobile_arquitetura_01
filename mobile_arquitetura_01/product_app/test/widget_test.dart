import 'package:flutter_test/flutter_test.dart';

import 'package:product_app/main.dart';

void main() {
  testWidgets('exibe tela de login ao iniciar o app', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Acesso ao Sistema'), findsOneWidget);
    expect(find.text('Usuario'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });
}
