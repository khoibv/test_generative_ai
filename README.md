# Test 1 số mô hình AI trên Flutter

## 1. Chuẩn bị

Ứng dụng sử dụng 1 số mô hình AI, cần đăng ký API key của các mô hình này để test

|AI|Model version|Flutter package|Hướng dẫn đăng ký API key|Lưu ý|
|-|-|-|-|-|
|Google Gemini|gemini-2.0-flash-exp|[google_generative_ai](https://pub.dev/packages/google_generative_ai)|[API key](https://ai.google.dev/gemini-api/docs/api-key)|
|OpenAI ChatGPT|gemini-2.0-flash-exp|[google_generative_ai](https://pub.dev/packages/google_generative_ai)|[API key](https://ai.google.dev/gemini-api/docs/api-key)|

## 2. Build

```shell
dart run build_runner build --delete-conflicting-outputs
```

## 3. Run

```shell
flutter run
flutter run -d windows
```
