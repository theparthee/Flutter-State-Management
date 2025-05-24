import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'font_size_model.dart';

class FontSizeScreen extends StatelessWidget {
  const FontSizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Font Size: ${fontSizeProvider.fontSize.toStringAsFixed(0)}',
          style: TextStyle(fontSize: fontSizeProvider.fontSize),
        ),
        Slider(
          value: fontSizeProvider.fontSize,
          min: 10,
          max: 40,
          divisions: 6,
          label: fontSizeProvider.fontSize.toStringAsFixed(0),
          onChanged: (value) {
            fontSizeProvider.updateFontSize(value);
          },
        ),
      ],
    );
  }
}
