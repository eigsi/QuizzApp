# Quizz App IDATA2503

The objective of this project is to create a cross-plateform quizz app using `Flutter`, available on Android and IOS .
The questions of the quizz will help the user to learn about coding with Flutter.

## Project Features

This project runs on `dart` and can be launched on the simulator of your choice using `Android studio` for Android devices, and `Xcode` pour IOS devices, and allows you to simulate a fonctional quizz application.

## Project Prerequisites
You need at least one emulateur to run this project, like `Android studio` or `Xcode`. You also need to install flutter on your device.
To set up your flutter environement, you can follow the [macOS Setup](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/37213684#overview) or [Windows Setup](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/37213680#overview) video from the course "A Complete Guide to the Flutter FrameWork on Udemy.

## Installation
1. **Clone the GitHub repo**
```bash
git clone https://github.com/eigsi/QuizzApp.git
cd QuizzApp
```
2. **Look for a simulator device to use**
```bash
flutter devices
```
3. **run the Application**
```bash
flutter run -d [device id]
```

## Quizz Material
The questions of the quizz are in the file `/lib/data/questions.dart`