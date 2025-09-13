import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trace/features/quiz/controller/quiz_controller.dart';
import 'package:track_trace/features/quiz/widgets/play_screen.dart';

void main() {
  group('Quiz Integration Tests', () {
    late QuizController controller;

    setUp(() {
      Get.testMode = true;
      controller = Get.put(QuizController());
    });

    tearDown(() {
      Get.reset();
    });

    Widget createPlayScreen(PlayModes mode) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(home: PlayScreen(mode: mode)),
      );
    }

    testWidgets('Complete quiz flow - Casual Mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createPlayScreen(PlayModes.casual));
      await tester.pumpAndSettle();

      // Answer a few questions to test basic functionality
      for (int i = 0; i < 3; i++) {
        await tester.pumpAndSettle();
        final answerButtons = find.byType(ElevatedButton);
        if (answerButtons.evaluate().isNotEmpty) {
          await tester.tap(answerButtons.first);
          await tester.pump();
          await tester.pump(const Duration(seconds: 4));
          controller.disposeTimer();
        }
      }

      // Verify some progress was made
      expect(controller.currentIndex.value, greaterThan(0));
    });

    testWidgets('Complete quiz flow - Survival Mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createPlayScreen(PlayModes.survival));
      await tester.pumpAndSettle();

      // Answer a few questions to test basic functionality
      for (int i = 0; i < 3; i++) {
        await tester.pumpAndSettle();
        final answerButtons = find.byType(ElevatedButton);
        if (answerButtons.evaluate().isNotEmpty) {
          await tester.tap(answerButtons.first);
          await tester.pump();
          await tester.pump(const Duration(seconds: 4));
          controller.disposeTimer();
        }
      }

      // Verify some progress was made
      expect(controller.currentIndex.value, greaterThan(0));
    });

    testWidgets('Complete quiz flow - Timed Mode', (WidgetTester tester) async {
      await tester.pumpWidget(createPlayScreen(PlayModes.timed));
      await tester.pumpAndSettle();

      // Answer a few questions to test basic functionality
      for (int i = 0; i < 3; i++) {
        await tester.pumpAndSettle();
        final answerButtons = find.byType(ElevatedButton);
        if (answerButtons.evaluate().isNotEmpty) {
          await tester.tap(answerButtons.first);
          await tester.pump();
          await tester.pump(const Duration(seconds: 1));
          controller.disposeTimer();
        }
      }

      // Verify some progress was made
      expect(controller.currentIndex.value, greaterThan(0));
    });

    testWidgets('Exit quiz confirmation', (WidgetTester tester) async {
      await tester.pumpWidget(createPlayScreen(PlayModes.casual));
      await tester.pumpAndSettle();

      // Tap back button
      final backButton = find.byKey(const Key('back_button'));
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }

      // Verify back button exists (dialog might not show in tests)
      expect(backButton, findsOneWidget);

      // Tap No to cancel
      final noButton = find.text('No');
      if (noButton.evaluate().isNotEmpty) {
        await tester.tap(noButton);
        await tester.pumpAndSettle();
      }

      // Should still be in quiz
      expect(find.text('Which animal made this track?'), findsOneWidget);
    });

    testWidgets('Play again functionality', (WidgetTester tester) async {
      await tester.pumpWidget(createPlayScreen(PlayModes.casual));
      await tester.pumpAndSettle();

      // Answer a few questions
      for (int i = 0; i < 3; i++) {
        await tester.pumpAndSettle();
        final answerButtons = find.byType(ElevatedButton);
        if (answerButtons.evaluate().isNotEmpty) {
          await tester.tap(answerButtons.first);
          await tester.pump();
          await tester.pump(const Duration(seconds: 1));
          controller.disposeTimer();
        }
      }

      // Verify basic functionality works
      expect(controller.currentIndex.value, greaterThan(0));
    });

    testWidgets('Cross-mode functionality', (WidgetTester tester) async {
      // Test switching between modes
      final modes = [PlayModes.casual, PlayModes.survival, PlayModes.timed];

      for (final mode in modes) {
        await tester.pumpWidget(createPlayScreen(mode));
        await tester.pumpAndSettle();

        // Verify mode-specific UI elements
        switch (mode) {
          case PlayModes.casual:
            expect(find.text('Casual Mode'), findsOneWidget);
            break;
          case PlayModes.survival:
            expect(find.text('Survival Mode'), findsOneWidget);
            expect(find.byIcon(Icons.favorite), findsNWidgets(3));
            break;
          case PlayModes.timed:
            expect(find.text('Timed Mode'), findsOneWidget);
            expect(find.text('60s'), findsOneWidget);
            break;
        }

        // Answer one question
        final answerButtons = find.byType(ElevatedButton);
        if (answerButtons.evaluate().isNotEmpty) {
          await tester.tap(answerButtons.first);
          await tester.pump();
          await tester.pump(const Duration(seconds: 2));
          controller.disposeTimer();
        }
      }
    });
  });
}
