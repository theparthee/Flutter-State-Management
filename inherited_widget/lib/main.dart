import 'package:flutter/material.dart';

void main() => runApp(FontHeightApp());

class FontHeightApp extends StatelessWidget {
  const FontHeightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FontHeightProvider(
      fontSize: 10,
      child: MaterialApp(
        home: FontHeightHomePage(),
      ),
    );
  }
}

// InheritedWidget to provide font height
class FontHeightProvider extends InheritedWidget {
  final double fontSize;
  final Function(double)? onFontHeightChanged;

  const FontHeightProvider({
    super.key,
    required this.fontSize,
    required super.child,
    this.onFontHeightChanged,
  });

  static FontHeightProvider of(BuildContext context) {
    final FontHeightProvider? result =
    context.dependOnInheritedWidgetOfExactType<FontHeightProvider>();
    assert(result != null, 'No FontHeightProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FontHeightProvider oldWidget) =>
      fontSize != oldWidget.fontSize;
}

// StatefulWidget to update inherited widget using a wrapper
class FontHeightHomePage extends StatefulWidget {
  const FontHeightHomePage({super.key});

  @override
  _FontHeightHomePageState createState() => _FontHeightHomePageState();
}

class _FontHeightHomePageState extends State<FontHeightHomePage> {
  double _currentHeight = 10.0;

  @override
  Widget build(BuildContext context) {
    return FontHeightProvider(
      fontSize: _currentHeight,
      child: Scaffold(
        appBar: AppBar(title: Text('InheritedWidget – Font Height')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SampleText(),
            Slider(
              min: 10.0,
              max: 100.0,
              divisions: 10,
              label: _currentHeight.toStringAsFixed(1),
              value: _currentHeight,
              onChanged: (value) {
                setState(() {
                  _currentHeight = value;
                });
              },
            ),
            Text(
              "Font Height: ${_currentHeight.toStringAsFixed(1)}",
              style: TextStyle(fontSize: _currentHeight),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget to display text using inherited font height
class SampleText extends StatelessWidget {
  const SampleText({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = FontHeightProvider.of(context).fontSize;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "This is a sample text.\nChange the slider to update line height.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
