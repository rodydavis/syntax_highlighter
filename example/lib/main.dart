import 'package:flutter/material.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart';
import 'editor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syntax Highlighter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Syntax Highlighter Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _exampleCode = """
class PreviewWidget extends StatefulWidget {
  @override
  _PreviewWidgetState createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '\$_count',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Increment Counter",
        onPressed: () {
          if (mounted)
            setState(() {
              _count++;
            });
        },
      ),
    );
  }
}

""";

  @override
  Widget build(BuildContext context) {
    final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: RichText(
      //       text: TextSpan(
      //         style: const TextStyle(fontFamily: 'monospace', fontSize: 10.0),
      //         children: <TextSpan>[
      //           DartSyntaxHighlighter(style).format(_exampleCode),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: DartCodeEditor(
        data: _exampleCode,
        onChanged: (val) {
          // if (mounted)
          //   setState(() {
          //     _exampleCode = val;
          //   });
        },
      ),
    );
  }
}
