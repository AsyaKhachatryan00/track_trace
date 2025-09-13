import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:track_trace/features/quiz/controller/quiz_controller.dart';
import 'package:track_trace/features/quiz/widgets/play_screen.dart';
import 'package:track_trace/models/animal.dart';

void main() {
  group('QuizController Tests', () {
    late QuizController controller;

    setUp(() {
      Get.testMode = true;
      controller = QuizController();
    });

    tearDown(() {
      Get.reset();
    });

    test('should initialize with default values', () {
      expect(controller.animals, isEmpty);
      expect(controller.currentIndex.value, -1);
      expect(controller.score.value, 0);
      expect(controller.lives.value, 3);
      expect(controller.secondsLeft.value, 60);
      expect(controller.options, isEmpty);
      expect(controller.correctAnswer, '');
      expect(controller.isShowingAnswer, false);
      expect(controller.selectedAnswer, '');
      expect(
        controller.isCorrectAnswer,
        true,
      ); // Both are empty strings initially
    });

    test('should start game with casual mode', () {
      controller.start(mode: PlayModes.casual, onTimerEnd: () {});

      expect(controller.animals, isNotEmpty);
      expect(controller.score.value, 0);
      expect(controller.lives.value, 3);
      expect(controller.currentIndex.value, 0);
      expect(controller.isShowingAnswer, false);
      expect(controller.selectedAnswer, '');
      expect(controller.options, isNotEmpty);
      expect(controller.correctAnswer, isNotEmpty);
    });

    test('should start game with survival mode', () {
      controller.start(mode: PlayModes.survival);

      expect(controller.animals, isNotEmpty);
      expect(controller.lives.value, 3);
      expect(controller.options, isNotEmpty);
    });

    test('should start game with timed mode', () {
      controller.start(mode: PlayModes.timed);

      expect(controller.animals, isNotEmpty);
      expect(controller.secondsLeft.value, 60);
      expect(controller.options, isNotEmpty);
    });

    test('should prepare question with correct answer and options', () {
      controller.start(mode: PlayModes.casual);

      expect(controller.correctAnswer, isNotEmpty);
      expect(controller.options, hasLength(4));
      expect(controller.options, contains(controller.correctAnswer));
      expect(controller.options.toSet(), hasLength(4)); // All unique
    });

    test('should handle correct answer selection', () {
      controller.start(mode: PlayModes.casual);
      final initialScore = controller.score.value;
      final correctAnswer = controller.correctAnswer;

      controller.select(correctAnswer, mode: PlayModes.casual);

      expect(controller.score.value, initialScore + 1);
      expect(controller.isShowingAnswer, true);
      expect(controller.selectedAnswer, correctAnswer);
      expect(controller.isCorrectAnswer, true);
    });

    test('should handle incorrect answer selection in casual mode', () {
      controller.start(mode: PlayModes.casual);
      final initialScore = controller.score.value;
      final wrongAnswer = controller.options.firstWhere(
        (option) => option != controller.correctAnswer,
      );

      controller.select(wrongAnswer, mode: PlayModes.casual);

      expect(controller.score.value, initialScore); // No score change
      expect(controller.isShowingAnswer, true);
      expect(controller.selectedAnswer, wrongAnswer);
      expect(controller.isCorrectAnswer, false);
    });

    test('should handle incorrect answer selection in survival mode', () {
      controller.start(mode: PlayModes.survival);
      final initialLives = controller.lives.value;
      final wrongAnswer = controller.options.firstWhere(
        (option) => option != controller.correctAnswer,
      );

      controller.select(wrongAnswer, mode: PlayModes.survival);

      expect(controller.lives.value, initialLives - 1);
      expect(controller.isShowingAnswer, true);
      expect(controller.selectedAnswer, wrongAnswer);
    });

    test('should end game when all lives lost in survival mode', () async {
      controller.start(mode: PlayModes.survival);
      controller.lives.value = 1; // Set to 1 life
      final wrongAnswer = controller.options.firstWhere(
        (option) => option != controller.correctAnswer,
      );

      bool gameEnded = false;
      controller.start(
        mode: PlayModes.survival,
        onTimerEnd: () => gameEnded = true,
      );
      controller.lives.value = 1;
      controller.select(wrongAnswer, mode: PlayModes.survival);

      // Wait for timer to complete
      await Future.delayed(const Duration(seconds: 4));
      expect(controller.lives.value, 0);
      expect(gameEnded, true);
    });

    test('should progress to next question after 3 seconds', () async {
      controller.start(mode: PlayModes.casual);
      final initialIndex = controller.currentIndex.value;
      final correctAnswer = controller.correctAnswer;

      controller.select(correctAnswer, mode: PlayModes.casual);

      expect(controller.isShowingAnswer, true);
      expect(controller.selectedAnswer, correctAnswer);

      // Wait for 3 seconds
      await Future.delayed(const Duration(seconds: 4));

      expect(controller.isShowingAnswer, false);
      expect(controller.selectedAnswer, '');
      expect(controller.currentIndex.value, initialIndex + 1);
    });

    test('should end game after 10 questions', () async {
      bool gameEnded = false;
      controller.start(
        mode: PlayModes.casual,
        onTimerEnd: () => gameEnded = true,
      );
      controller.currentIndex.value = 9; // Set to question 9

      final correctAnswer = controller.correctAnswer;
      controller.select(correctAnswer, mode: PlayModes.casual);

      // Wait for timer to complete
      await Future.delayed(const Duration(seconds: 4));

      expect(controller.currentIndex.value, 10);
      expect(gameEnded, true);
    });

    test('should not allow selection while showing answer', () {
      controller.start(mode: PlayModes.casual);
      final correctAnswer = controller.correctAnswer;

      controller.select(correctAnswer, mode: PlayModes.casual);
      expect(controller.isShowingAnswer, true);

      // Try to select again
      final initialScore = controller.score.value;
      controller.select(correctAnswer, mode: PlayModes.casual);

      expect(controller.score.value, initialScore); // Should not change
    });

    test('should dispose timer properly', () {
      controller.start(mode: PlayModes.timed);
      expect(controller.secondsLeft.value, 60);

      controller.disposeTimer();
      // Timer should be cancelled, secondsLeft should not change
      expect(controller.secondsLeft.value, 60);
    });

    test('should restart game properly', () {
      controller.start(mode: PlayModes.casual);
      controller.score.value = 5;
      controller.currentIndex.value = 3;

      controller.restart(mode: PlayModes.casual);

      expect(controller.score.value, 0);
      expect(controller.currentIndex.value, 0);
      expect(controller.isShowingAnswer, false);
      expect(controller.selectedAnswer, '');
    });

    test('should get current animal correctly', () {
      controller.start(mode: PlayModes.casual);
      final currentAnimal = controller.currentAnimal;

      expect(currentAnimal.image, isNotEmpty);
      expect(currentAnimal.name, isNotEmpty);
      expect(currentAnimal.category, isA<Category>());
      expect(currentAnimal.footType, isA<FootType>());
    });

    test('should get question number correctly', () {
      controller.start(mode: PlayModes.casual);
      expect(controller.questionNumber, 1);

      controller.currentIndex.value = 5;
      expect(controller.questionNumber, 6);
    });
  });
}
