import 'package:car_service_log/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> startApp(
  WidgetTester tester, {
  Size size = const Size(412, 915),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    const RepaintBoundary(
      key: ValueKey('report-capture'),
      child: CarServiceApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> tapText(WidgetTester tester, String text) async {
  if (find.text(text).evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      find.text(text),
      250,
      scrollable: find.byType(Scrollable).first,
    );
  }
  final target = find.text(text).last;
  await Scrollable.ensureVisible(tester.element(target), alignment: 0.5);
  await tester.pumpAndSettle();
  await tester.tap(target);
  await tester.pumpAndSettle();
}

Future<void> fillField(WidgetTester tester, String label, String value) async {
  final field = find.widgetWithText(TextFormField, label);
  if (field.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      field,
      200,
      scrollable: find.byType(Scrollable).first,
    );
  }
  await Scrollable.ensureVisible(tester.element(field), alignment: 0.5);
  await tester.pumpAndSettle();
  await tester.enterText(field, value);
  await tester.pump();
}

void main() {
  testWidgets('S-01 → S-02/S-03 → S-01 and password visibility', (
    tester,
  ) async {
    await startApp(tester);
    expect(find.text('Вхід'), findsOneWidget);
    await tester.tap(find.byTooltip('Показати пароль'));
    await tester.pump();
    expect(find.byTooltip('Приховати пароль'), findsOneWidget);
    await tapText(tester, 'Зареєструватися');
    expect(find.text('Реєстрація'), findsOneWidget);
    await tapText(tester, 'Зареєструватися');
    expect(find.text('Вхід'), findsOneWidget);
    await tapText(tester, 'Забули пароль?');
    expect(find.text('Відновлення пароля'), findsOneWidget);
    await fillField(tester, 'Електронна пошта', 'max@example.com');
    await tapText(tester, 'Надіслати інструкції');
    expect(find.text('Вхід'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('S-01 → S-04 ↔ S-12 → S-13/S-14 → logout', (tester) async {
    await startApp(tester);
    await tapText(tester, 'Увійти');
    expect(find.text('Вітаємо, Максим!'), findsOneWidget);
    expect(find.text('18 740 грн'), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(2));
    await tapText(tester, 'Профіль');
    expect(find.text('max@example.com'), findsOneWidget);
    await tapText(tester, 'Редагувати профіль');
    await fillField(tester, 'Ім’я', 'Олексій');
    await fillField(tester, 'Електронна пошта', 'oleksii@example.com');
    await tapText(tester, 'Зберегти зміни');
    expect(find.text('Олексій'), findsOneWidget);
    expect(find.text('oleksii@example.com'), findsOneWidget);
    await tapText(tester, 'Редагувати профіль');
    await fillField(tester, 'Ім’я', 'Не зберігати');
    await tapText(tester, 'Скасувати');
    expect(find.text('Олексій'), findsOneWidget);
    await tapText(tester, 'Змінити пароль');
    await fillField(tester, 'Поточний пароль', 'demo123');
    await fillField(tester, 'Новий пароль', 'newdemo123');
    await fillField(tester, 'Підтвердження нового пароля', 'different');
    await tapText(tester, 'Змінити пароль');
    expect(find.text('Паролі не збігаються'), findsOneWidget);
    await fillField(tester, 'Підтвердження нового пароля', 'newdemo123');
    await tapText(tester, 'Змінити пароль');
    expect(find.text('Профіль').first, findsOneWidget);
    await tapText(tester, 'Головна');
    expect(find.text('Вітаємо, Олексій!'), findsOneWidget);
    await tapText(tester, 'Додати запис');
    expect(find.text('Демонстраційна дія: додавання запису'), findsOneWidget);
    await tapText(tester, 'Оновити пробіг');
    expect(find.text('Демонстраційна дія: оновлення пробігу'), findsOneWidget);
    await tapText(tester, 'Профіль');
    await tapText(tester, 'Вийти з акаунта');
    expect(find.text('Вхід'), findsOneWidget);
    await tapText(tester, 'Увійти');
    expect(find.text('Вітаємо, Максим!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Short viewport and open keyboard keep forms scrollable', (
    tester,
  ) async {
    await startApp(tester, size: const Size(320, 568));
    await tapText(tester, 'Зареєструватися');
    tester.view.viewInsets = const FakeViewPadding(bottom: 250);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    await fillField(tester, 'Підтвердження пароля', 'demo123');
    await tapText(tester, 'Зареєструватися');
    expect(find.text('Вхід'), findsOneWidget);
    tester.view.resetViewInsets();
    await tester.pumpAndSettle();
    await tapText(tester, 'Увійти');
    await tapText(tester, 'Профіль');
    await tapText(tester, 'Змінити пароль');
    await tapText(tester, 'Скасувати');
    expect(tester.takeException(), isNull);
  });
}
