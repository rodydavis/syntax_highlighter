import 'package:flutter/material.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart';

class DartCodeEditor extends StatefulWidget {
  final String data;
  final ValueChanged<String> onChanged;

  const DartCodeEditor({
    Key key,
    @required this.data,
    this.onChanged,
  }) : super(key: key);

  @override
  _DartCodeEditorState createState() => _DartCodeEditorState();
}

class _DartCodeEditorState extends State<DartCodeEditor> {
  final _contoller = CodeEditingController();

  @override
  void initState() {
    _contoller.text = widget.data;
    _contoller.addListener(_onChanged);
    super.initState();
  }

  void _onChanged() {
    if (widget.onChanged != null) {
      widget.onChanged(_contoller.text);
    }
  }

  @override
  void didUpdateWidget(DartCodeEditor oldWidget) {
    if (oldWidget.data != widget.data) {
      if (widget.data != _contoller.text) {
        _contoller.text = widget.data;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _contoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null || widget.data.isEmpty)
      return Center(child: CircularProgressIndicator());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    _contoller.isDark = isDark;
    return SingleChildScrollView(
      child: TextFormField(
        maxLines: null,
        controller: _contoller,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CodeEditingController extends TextEditingController {
  bool isDark = false;

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    DartSyntaxHighlighter _editor;
    if (isDark) {
      _editor =
          DartSyntaxHighlighter(SyntaxHighlighterStyle.darkThemeStyle(style));
    } else {
      _editor =
          DartSyntaxHighlighter(SyntaxHighlighterStyle.lightThemeStyle(style));
    }
    return _editor.format(value.text);
  }

  TextSelection get selection => value.selection;

  set selection(TextSelection newSelection) {
    if (newSelection.start > text.length || newSelection.end > text.length)
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('invalid text selection: $newSelection')
      ]);
    value = value.copyWith(selection: newSelection, composing: TextRange.empty);
  }

  void clear() {
    value = TextEditingValue.empty;
  }

  void clearComposing() {
    value = value.copyWith(composing: TextRange.empty);
  }
}
