import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final quoteWidget = getQuoteWidget();

    const contentWidget = Text(
      '222222222222',
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14,
      ),
    );

    const translateWidget = Text(
      'Translate',
      style: TextStyle(
        color: Colors.lightBlue,
        fontSize: 14,
      ),
    );

    final contentPainter = TextPainter(
      text: TextSpan(
        text: contentWidget.data,
        style: contentWidget.style,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    double width = contentPainter.width;

    final translatePainter = TextPainter(
      text: TextSpan(
        text: translateWidget.data,
        style: translateWidget.style,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final quoteWidgetPainter = TextPainter(
      text: quoteWidget.textSpan,
      textDirection: TextDirection.ltr,
      textWidthBasis:
          TextWidthBasis.longestLine, // TODO(kjxbyz): It does't work.
      maxLines: 2,
      ellipsis: '...',
    )
      ..setPlaceholderDimensions([
        const PlaceholderDimensions(
          size: Size(6, 8),
          alignment: PlaceholderAlignment.middle,
        ),
      ])
      ..layout();

    width = max(width, translatePainter.width);
    width = max(width, quoteWidgetPainter.width);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 220),
          child: ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: contentWidget,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ColoredBox(
                      color: Colors.limeAccent,
                      child: quoteWidget,
                    ),
                  ),
                  ColoredBox(
                    color: Colors.black26,
                    child: SizedBox.fromSize(size: Size(width, 0.5)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: translateWidget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text getQuoteWidget() {
    final child = Text.rich(
      TextSpan(
        children: <InlineSpan>[
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: ColoredBox(
                color: Colors.red,
                child: SizedBox.fromSize(
                  size: const Size(2, 8),
                ),
              ),
            ),
            alignment: PlaceholderAlignment.middle,
          ),
          const TextSpan(text: 'The message has been recalled.'),
        ],
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
          height: 1.14,
        ),
      ),
      maxLines: 2,
      textWidthBasis: TextWidthBasis.longestLine,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
    );

    return child;
  }
}

class MyPainter extends CustomPainter {
  final double width;

  MyPainter({super.repaint, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    const textSpan = TextSpan(
      text:
          'Here is some long text that will overflow and we want to check the longest line basis.',
      style: TextStyle(color: Colors.black, fontSize: 18),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
      maxLines: 2,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    textPainter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
