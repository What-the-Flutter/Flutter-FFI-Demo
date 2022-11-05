import 'dart:math';

abstract class DartCalculator {
  static double calcPi(int precision) {
    double pi = 0;
    int sign = 1;

    for (int i = 1; i < precision * 2; i += 2) {
      pi = pi + sign * 4 / i;
      sign *= -1;
    }

    return pi;
  }

  static double calcAreaUnderSin(int precision, int piPrecision) {
    var sum = 0;
    final pi = calcPi(piPrecision);
    final rectArea = pi * 1;

    final rnd = Random();

    for (int i = 1; i < precision; i++) {
      final x = rnd.nextDouble() * pi;
      final y = rnd.nextDouble();

      if (y < sin(x)) {
        sum++;
      }
    }

    return sum / precision * rectArea;
  }

}