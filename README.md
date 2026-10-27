# Car Service Log - Lab 3

Flutter-застосунок для лабораторної роботи №3 з дисципліни «Кросплатформне програмування».
Реалізовано рівно сім UI-екранів: вхід, реєстрація, відновлення пароля, головна, профіль, редагування профілю та зміна пароля.
На головній — статичні демодані й швидкі дії з повідомленнями. Навігація: «Головна» та «Профіль».

## Запуск після клонування

Потрібні Git, **Flutter 3.47.4 / Dart 3.13.3**, Android Studio з Android SDK та **JDK 21**.
Для запуску на телефоні або емуляторі потрібен Android 10+ (API 29).
JDK 21 можна взяти з комплекту Android Studio (Gradle JDK).

```powershell
git clone https://github.com/gggmaximggg/car_service_log.git
cd car_service_log
flutter pub get --enforce-lockfile
flutter doctor
flutter devices
flutter run
```

Перед першим Android-запуском установіть Android SDK через SDK Manager і виконайте `flutter doctor --android-licenses`.
Для телефону ввімкніть налагодження USB, для емулятора створіть пристрій у Device Manager.
В Android Studio відкрийте корінь проєкту, виберіть пристрій і запускайте `lib/main.dart`.
Локальні шляхи SDK налаштовуються на вашому комп’ютері; `android/local.properties` не зберігається в Git.
Gradle wrapper та `pubspec.lock` включені до репозиторію.

Для входу достатньо натиснути «Увійти». Firebase, backend, API, бази даних та ключі доступу не потрібні.
Паролі не зберігаються, листи не надсилаються. Редагування профілю діє лише до виходу чи перезапуску.

## Перевірка і збірка

```powershell
dart format .
flutter analyze
flutter test
flutter build apk --debug
```

APK з’явиться в `build/app/outputs/flutter-apk/app-debug.apk`. Це навчальна debug-збірка для встановлення на Android.

У вкладці **Actions** GitHub workflow **Flutter checks and Android APK** виконує перевірку форматування,
аналіз, тести й Android-збірку після push у `main`, для pull request або вручну через **Run workflow**.
Після успішного запуску завантажте **car-service-log-debug-apk** у секції **Artifacts** й розпакуйте ZIP.
Артефакт зберігається 7 днів; для нового APK запустіть workflow повторно.

## Структура

```text
lib/
  main.dart
  app.dart
  core/
    data/          # статичні дані та ім’я/email демосеансу
    theme/         # Material 3, кольори, типографіка
    widgets/       # спільні кнопка, поле, картка, навігація
  features/
    auth/          # S-01, S-02, S-03
    home/          # S-04
    profile/       # S-12, S-13, S-14
    shell/         # головна ↔ профіль
assets/images/sto.jpg
test/
.github/workflows/flutter.yml
```
