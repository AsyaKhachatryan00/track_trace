import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:track_trace/core/config/constants/app_assets.dart';
import 'package:track_trace/core/config/theme/app_colors.dart';
import 'package:track_trace/core/widgets/dialog_screen.dart';
import 'package:track_trace/features/quiz/widgets/game_results_dialog.dart';
import 'package:track_trace/models/animal.dart';
import 'package:track_trace/features/quiz/controller/quiz_controller.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key, required this.mode});
  final PlayModes mode;

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late final QuizController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<QuizController>()
        ? Get.find<QuizController>()
        : Get.put(QuizController());
    _controller.start(
      mode: widget.mode,
      onTimerEnd: () => _showGameOverDialog(),
    );
  }

  void _showGameOverDialog() {
    try {
      Get.dialog(
        GameResults(
          count: _controller.score.toString(),
          onTap: () => _controller.restart(
            mode: widget.mode,
            onTimerEnd: () => _showGameOverDialog(),
          ),
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      debugPrint('Game over dialog error: $e');
    }
  }

  @override
  void dispose() {
    _controller.disposeTimer();
    super.dispose();
  }

  void _showExitConfirmation() {
    try {
      Get.dialog(
        DialogScreen(
          onTap: (v) {
            if (v) {
              Get.back(id: 1);
            }
          },
          title: 'Are you sure you want to leave this quest?',
        ),
      );
    } catch (e) {
      debugPrint('Dialog error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: InkWell(
            key: Key('back_button'),
            onTap: () => _showExitConfirmation(),
            child: SvgPicture.asset(
              AppSvgs.left,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.none,
            ),
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 24.w),
        actions: [
          Obx(
            () => Text(
              'Question ${_controller.currentIndex.value}/10',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                height: 1.2,
              ),
            ),
          ),
        ],
        centerTitle: false,
        title: Text(
          widget.mode == PlayModes.casual
              ? 'Casual Mode'
              : widget.mode == PlayModes.survival
              ? 'Survival Mode'
              : 'Timed Mode',
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 37.h),
              _buildModeHeader(),
              SizedBox(height: 45.h),
              Obx(
                () => LinearProgressIndicator(
                  value: _controller.currentIndex.value / 10,
                  minHeight: 10.h,
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  backgroundColor: Color(0xFF989898).withValues(alpha: 0.44),
                ),
              ),

              SizedBox(height: 36.h),
              _buildQuestionCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeHeader() {
    if (widget.mode == PlayModes.survival) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          final bool filled = i < _controller.lives.value;
          return Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : 6.w),
            child: Icon(
              filled ? Icons.favorite : Icons.favorite_border,
              color: filled
                  ? AppColors.radicalRed
                  : AppColors.radicalRed.withValues(alpha: 0.36),
              size: 30,
            ),
          );
        }),
      );
    }
    if (widget.mode == PlayModes.timed) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppSvgs.timer),
            SizedBox(width: 8.w),
            Text(
              '${_controller.secondsLeft.value}',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.white,
                height: 1.2,
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox();
  }

  Widget _buildQuestionCard() {
    final Animal current = _controller.currentAnimal;
    return Container(
      width: 327.w,
      padding: EdgeInsets.symmetric(vertical: 27.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.zucchini,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Text(
            'Which animal made this track?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.white,
              height: 1.2,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: Image.asset(current.image, width: 66.w, height: 66.h),
          ),

          _buildOptions(),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        for (int i = 0; i < _controller.options.length; i += 2)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                Expanded(child: _optionButton(_controller.options[i])),
                SizedBox(width: 12.w),
                Expanded(child: _optionButton(_controller.options[i + 1])),
              ],
            ),
          ),
      ],
    );
  }

  Widget _optionButton(String label) {
    return Obx(() {
      final bool isSelected =
          _controller.selectedAnswer.isNotEmpty &&
          _controller.selectedAnswer == label;
      final bool isCorrect = label == _controller.correctAnswer;
      final bool isShowingAnswer = _controller.isShowingAnswer;

      Color buttonColor = AppColors.mainBg;
      if (isShowingAnswer) {
        if (isSelected) {
          buttonColor = isCorrect ? AppColors.aquamarine : AppColors.maroon;
        } else if (isCorrect) {
          buttonColor = AppColors.aquamarine;
        }
      }

      return SizedBox(
        height: 56.h,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(buttonColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
          ),
          onPressed: isShowingAnswer
              ? null
              : () {
                  _controller.select(label, mode: widget.mode);
                },
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    });
  }
}

enum PlayModes { casual, survival, timed }
