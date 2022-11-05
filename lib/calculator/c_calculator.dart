// FFI signature of the hello_world C function
import 'dart:ffi';

import 'dart:io';

typedef CalcPiC = Double Function(Int32 precision);
typedef CalcPiDart = double Function(int precision);

typedef CalcAreaUnderSinC = Double Function(Int32 precision, Int32 pi_precision);
typedef CalcAreaUnderSinDart = double Function(int precision, int piPrecision);

abstract class CCalculator {
  static late CalcPiDart calcPi;
  static late CalcAreaUnderSinDart calcAreaUnderSin;

  static void init() {
    final DynamicLibrary nativeAddLib =
        Platform.isAndroid ? DynamicLibrary.open('libexample_lib.so') : DynamicLibrary.process();

    calcPi = nativeAddLib.lookup<NativeFunction<CalcPiC>>('calc_pi').asFunction();

    calcAreaUnderSin =
        nativeAddLib.lookup<NativeFunction<CalcAreaUnderSinC>>('calc_area_under_sin').asFunction();
  }
}
