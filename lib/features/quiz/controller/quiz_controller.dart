import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:track_trace/core/config/constants/app_assets.dart';
import 'package:track_trace/features/quiz/widgets/play_screen.dart';
import 'package:track_trace/models/animal.dart';

class QuizController extends GetxController {
  final RxList<Animal> animals = <Animal>[].obs;
  final RxInt currentIndex = RxInt(-1);
  final RxInt score = 0.obs;
  final RxInt lives = 3.obs;
  final RxInt secondsLeft = 60.obs;

  final RxList<String> optionsRx = <String>[].obs;
  String correctAnswer = '';

  Timer? _timer;
  foundation.VoidCallback? _onTimerEnd;
  bool _gameEnded = false;
  final RxBool _showingAnswer = false.obs;
  final RxString _selectedAnswer = ''.obs;

  List<String> get options => optionsRx;
  Animal get currentAnimal => animals.isEmpty
      ? Animal(
          image: '',
          name: '',
          category: Category.mammal,
          footType: FootType.paws,
        )
      : animals[currentIndex.value % animals.length];
  int get questionNumber => currentIndex.value + 1;

  void start({required PlayModes mode, foundation.VoidCallback? onTimerEnd}) {
    animals.assignAll(Animal.buildFromAssetPaths(AppImages.animals)..shuffle());
    score.value = 0;
    lives.value = 3;
    currentIndex.value = 0;
    _gameEnded = false;
    _showingAnswer.value = false;
    _selectedAnswer.value = '';
    _onTimerEnd = onTimerEnd;
    _prepareQuestion();
    if (mode == PlayModes.timed) {
      _startTimer();
    } else {
      disposeTimer();
    }
  }

  void restart({required PlayModes mode, foundation.VoidCallback? onTimerEnd}) {
    start(mode: mode, onTimerEnd: onTimerEnd);
  }

  void disposeTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _startTimer() {
    disposeTimer();
    secondsLeft.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft.value <= 0 || currentIndex.value >= 10) {
        t.cancel();
        if (!_gameEnded) {
          _gameEnded = true;
          _onTimerEnd?.call();
        }
      } else {
        secondsLeft.value--;
      }
    });
  }

  void _prepareQuestion() {
    final Animal current = currentAnimal;
    correctAnswer = current.name;
    final List<String> pool = animals.map((a) => a.name).toList();
    pool.remove(correctAnswer);
    pool.shuffle();
    final List<String> distractors = pool.take(3).toList();
    optionsRx.assignAll(
      <String>{correctAnswer, ...distractors}.toList()..shuffle(),
    );
  }

  void select(String choice, {required PlayModes mode}) {
    if (_gameEnded || _showingAnswer.value) return;

    _selectedAnswer.value = choice;
    _showingAnswer.value = true;

    final bool isCorrect = choice == correctAnswer;
    if (isCorrect) {
      score.value++;
    } else if (mode == PlayModes.survival) {
      lives.value--;
    }

    Timer(const Duration(seconds: 3), () {
      if (_gameEnded) return;

      _showingAnswer.value = false;
      _selectedAnswer.value = '';

      currentIndex.value++;

      if (currentIndex.value >= 10) {
        _gameEnded = true;
        _onTimerEnd?.call();
        return;
      }

      if (mode == PlayModes.survival && lives.value <= 0) {
        _gameEnded = true;
        _onTimerEnd?.call();
        return;
      }

      if (mode == PlayModes.timed && secondsLeft.value <= 0) {
        _gameEnded = true;
        _onTimerEnd?.call();
        return;
      }

      _prepareQuestion();
    });
  }

  bool get isShowingAnswer => _showingAnswer.value;
  String get selectedAnswer => _selectedAnswer.value;
  bool get isCorrectAnswer => _selectedAnswer.value == correctAnswer;
}
