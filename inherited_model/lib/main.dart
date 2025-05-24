import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class FontModel extends InheritedModel<String> {
  final double fontSize;
  final Color color;

  const FontModel({
    Key? key,
    required this.fontSize,
    required this.color,
    required Widget child,
  }) : super(key: key, child: child);

  static FontModel? of(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<FontModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(FontModel oldWidget) {
    return fontSize != oldWidget.fontSize || color != oldWidget.color;
  }

  @override
  bool updateShouldNotifyDependent(
      FontModel oldWidget, Set<String> dependencies) {
    return (dependencies.contains('fontSize') &&
        fontSize != oldWidget.fontSize) ||
        (dependencies.contains('color') && color != oldWidget.color);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _fontSize = 20.0;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return FontModel(
      fontSize: _fontSize,
      color: _color,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('InheritedModel - Font Size')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FontSizeText(),   // Only listens to fontSize
              ColorText(),      // Only listens to color
              const SizedBox(height: 30),
              Slider(
                value: _fontSize,
                min: 10,
                max: 40,
                divisions: 6,
                label: _fontSize.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _color =
                    _color == Colors.blue ? Colors.red : Colors.blue;
                  });
                },
                child: const Text('Toggle Color'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FontSizeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontModel = FontModel.of(context, 'fontSize')!;
    print('FontSizeText rebuilt');
    return Text(
      'Font Size: ${fontModel.fontSize.toStringAsFixed(0)}',
      style: TextStyle(fontSize: fontModel.fontSize),
    );
  }
}

class ColorText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontModel = FontModel.of(context, 'color')!;
    print('ColorText rebuilt');
    return Text(
      'Color Aware Text',
      style: TextStyle(color: fontModel.color),
    );
  }
}
