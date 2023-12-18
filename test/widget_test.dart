import 'package:advertech_test_task/providers/form_provider.dart';
import 'package:advertech_test_task/screens/contact_us_screen.dart';
import 'package:advertech_test_task/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

class MockApiServices extends Mock implements ApiService {}

void main() {
  // late MockApiServices mockApi;
  // late FormProvider formProvider;

  // setUp(() {
  //   mockApi = MockApiServices();
  //   when(mockApi.sendDataToServer(
  //     name: anyNamed('name') as String,
  //     email: anyNamed('email') as String,
  //     message: anyNamed('message') as String,
  //   )).thenAnswer((_) async =>
  //       Response(data: {}, statusCode: 201, requestOptions: RequestOptions()));
  //   formProvider = FormProvider(apiService: mockApi);
  // });

  testWidgets('Contact Us Screen UI Test', (WidgetTester tester) async {
    // Build our ContactUsScreen widget wrapped in Provider
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => FormProvider(
              apiService:
                  ApiService()), // You might need to provide a mock here
          child: const ContactUsScreen(),
        ),
      ),
    );

    // Find the form fields and the send button
    final nameField = find.byKey(const Key('name_field'));
    final emailField = find.byKey(const Key('email_field'));
    final messageField = find.byKey(const Key('message_field'));
    final sendButton = find.byKey(const Key('send_button'));

    // Verify the existence of the form fields and the send button
    expect(nameField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(messageField, findsOneWidget);
    expect(sendButton, findsOneWidget);

    // Try tapping the send button without filling the form
    await tester.tap(sendButton);
    await tester.pump();

    // Verify that the button is disabled
    expect(tester.widget<ElevatedButton>(sendButton).enabled, isFalse);

    // Fill the form fields with valid data
    await tester.enterText(nameField, 'John Doe');
    await tester.enterText(emailField, 'johndoe@gmail.com');
    await tester.enterText(messageField, 'Test message');
    await tester.pump();

    // Verify that the button is enabled after filling the form
    expect(tester.widget<ElevatedButton>(sendButton).enabled, isTrue);

    // // Tap the send button and check for "Please Wait" text
    // await tester.tap(sendButton);
    // await tester.pump();
    // expect(find.text('Please Wait'), findsOneWidget);
  });
}
