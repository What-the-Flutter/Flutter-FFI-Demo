import 'package:ffi_test/calculator/c_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'calculator/dart_calculator.dart';

void main() {
  CCalculator.init();
  runApp(const MyApp());
}

final piPrecisionsList = <int>[10, 100, 1000, 10000];
final areaPrecisionsList = <int>[100, 1000, 1000000, 50000000];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  Duration cPiTime = Duration.zero;
  Duration dartPiTime = Duration.zero;

  Duration cAreaTime = Duration.zero;
  Duration dartAreaTime = Duration.zero;

  int piPrecision = piPrecisionsList.first;
  int areaPrecision = areaPrecisionsList.first;

  double cPi = 0;
  double dartPi = 0;

  double cArea = 0;
  double dartArea = 0;

  bool isCalculating = false;

  void _calculate() {
    setState(() {
      isCalculating = true;
    });

    Stopwatch stopwatch = Stopwatch()..start();

    setState(() {
      cPi = CCalculator.calcPi(piPrecision);
      cPiTime = stopwatch.elapsed;
      stopwatch.reset();
    });

    stopwatch.start();

    setState(() {
      cArea = CCalculator.calcAreaUnderSin(areaPrecision, piPrecision);
      cAreaTime = stopwatch.elapsed;
      stopwatch.reset();
    });

    stopwatch.start();

    setState(() {
      dartPi = DartCalculator.calcPi(piPrecision);
      dartPiTime = stopwatch.elapsed;
      stopwatch.reset();
    });

    stopwatch.start();

    setState(() {
      dartArea = DartCalculator.calcAreaUnderSin(areaPrecision, piPrecision);
      dartAreaTime = stopwatch.elapsed;
      stopwatch.reset();
    });

    setState(() {
      isCalculating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FFI example'),
      ),
      body: FittedBox(
        fit: BoxFit.scaleDown,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'res/sin.svg',
                width: 400,
                height: 300,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('C calculations'),
                  _dataRow('pi:', cPi, cPiTime),
                  _dataRow('area:', cArea, cAreaTime),
                  const Text('Dart calculations'),
                  _dataRow('pi:', dartPi, dartPiTime),
                  _dataRow('area:', dartArea, dartAreaTime),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton<int>(
                        value: piPrecision,
                        items: piPrecisionsList
                            .map(
                              (e) => DropdownMenuItem<int>(
                                value: e,
                                child: Text(e.toString()),
                              ),
                            )
                            .toList(),
                        onChanged: (item) => setState(() {
                          piPrecision = item!;
                        }),
                      ),
                      const SizedBox(width: 30),
                      DropdownButton<int>(
                        value: areaPrecision,
                        items: areaPrecisionsList
                            .map(
                              (e) => DropdownMenuItem<int>(
                                value: e,
                                child: Text(e.toString()),
                              ),
                            )
                            .toList(),
                        onChanged: (item) => setState(() {
                          areaPrecision = item!;
                        }),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(onPressed: _calculate, child: const Text('Calculate!')),
                    ],
                  ),
                  if (isCalculating) const CircularProgressIndicator(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataRow(String desc, double? value, Duration time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _paddedText(desc, 50, Alignment.centerLeft),
        if (value != null) _paddedText(value.toString()),
        _paddedText(time.toString()),
      ],
    );
  }

  Widget _paddedText(String text, [double width = 150, Alignment alignment = Alignment.center]) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: alignment,
        child: Text(text),
      ),
    );
  }
}
