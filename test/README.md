# Quiz Test Suite

This directory contains comprehensive tests for the quiz functionality in the Track Trace app.

## Test Structure

### Unit Tests

#### QuizController Tests (`test/features/quiz/controller/quiz_controller_test.dart`)
Tests the core quiz logic including:
- Game initialization for all modes (Casual, Survival, Timed)
- Answer selection and scoring
- Question progression and game ending conditions
- Timer functionality for timed mode
- Lives system for survival mode
- Answer display state management

#### PlayScreen Tests (`test/features/quiz/widgets/play_screen_test.dart`)
Tests the UI components including:
- Screen rendering for all quiz modes
- Answer button interactions
- Visual feedback (correct/incorrect colors)
- Progress indicators and counters
- Dialog displays and interactions
- Navigation and back button functionality

### Integration Tests

#### Quiz Integration Tests (`test/integration/quiz_integration_test.dart`)
End-to-end tests covering:
- Complete quiz flows for all modes
- User interactions from start to finish
- Dialog confirmations and game over scenarios
- Play again functionality

### Test Helpers

#### TestHelpers (`test/helpers/test_helpers.dart`)
Common utilities for test setup:
- Widget creation with ScreenUtil
- GetX setup and cleanup
- Animation and timer handling

#### Mock Data (`test/mocks/mock_data.dart`)
Test data for consistent testing:
- Mock animal objects
- Sample animal names and asset paths

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Specific Test Files
```bash
# Unit tests
flutter test test/features/quiz/controller/quiz_controller_test.dart
flutter test test/features/quiz/widgets/play_screen_test.dart

# Integration tests
flutter test test/integration/quiz_integration_test.dart
```

### Run Tests with Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Test Coverage

The test suite covers:

### QuizController
- ✅ Game initialization and state management
- ✅ Answer selection and validation
- ✅ Score tracking and lives management
- ✅ Timer functionality
- ✅ Question progression
- ✅ Game ending conditions
- ✅ Answer display timing

### PlayScreen
- ✅ UI rendering for all modes
- ✅ Button interactions and feedback
- ✅ Progress indicators
- ✅ Dialog displays
- ✅ Navigation handling
- ✅ Visual state updates

### Integration
- ✅ Complete user workflows
- ✅ Cross-component interactions
- ✅ Real-world usage scenarios

## Test Data

Tests use mock data to ensure consistency and avoid dependencies on external assets. The mock data includes:
- Sample animal objects with proper categories and foot types
- Asset paths for testing image loading
- Animal names for answer option generation

## Best Practices

1. **Isolation**: Each test is independent and doesn't affect others
2. **Mocking**: External dependencies are mocked for unit tests
3. **Coverage**: All critical paths and edge cases are tested
4. **Readability**: Test names clearly describe what is being tested
5. **Maintainability**: Tests are organized logically and easy to update

## Adding New Tests

When adding new features to the quiz:

1. Add unit tests for new controller logic
2. Add widget tests for new UI components
3. Add integration tests for new user flows
4. Update mock data if needed
5. Ensure all tests pass before merging

## Troubleshooting

### Common Issues

1. **GetX not initialized**: Use `Get.testMode = true` in setUp
2. **ScreenUtil not working**: Wrap widgets in `ScreenUtilInit`
3. **Timer issues**: Use `pumpAndSettle` or `Future.delayed` for async operations
4. **Widget not found**: Ensure proper widget keys and wait for animations

### Debug Tips

1. Use `tester.pumpAndSettle()` to wait for animations
2. Use `tester.pump(Duration(seconds: X))` for specific delays
3. Check widget tree with `tester.printToConsole()`
4. Use `expect(find.byType(Widget), findsOneWidget)` for existence checks
