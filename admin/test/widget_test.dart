import 'package:flutter_test/flutter_test.dart';
import 'package:admin/app.dart';

void main() {
  testWidgets('App renders dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const FlustraAdminApp());
    expect(find.text('Flustra Admin'), findsOneWidget);
  });
}
