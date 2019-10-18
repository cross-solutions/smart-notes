import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_common/constants.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mocks/services_mocks.dart';

void main() {
  group('MainViewModel', () {
    MainViewModel unit;
    NavigationService navigationService;

    setUp(() {
      navigationService = MockNavigationService();
      unit = MainViewModel(navigationService);
    });

    test('counter increments by one', () {
      // Act
      unit.incrementCounter();

      // Assert
      expect(unit.counter, 1);
    });

    test('counter decrements by one', () {
      // Act
      unit.decrementCounter();

      // Assert
      expect(unit.counter, -1);
    });

    test('navigates to SecondView', () async {
      // Arrange
      when(navigationService.push(ViewNames.secondView, parameter: anyNamed('parameter')))
          .thenAnswer((_) => Future.value());

      // Act
      await unit.goToSecondView();

      // Assert
      verify(navigationService.push(ViewNames.secondView, parameter: anyNamed('parameter'))).called(1);
    });
  });
}
