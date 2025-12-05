import 'package:flutter_test/flutter_test.dart';
import 'package:sunu_ticket_pro/app.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SunuTicketApp());

    // Verify that our app starts with the correct text.
    expect(find.text('SUNU TICKET Pro - Initialized'), findsOneWidget);
  });
}
