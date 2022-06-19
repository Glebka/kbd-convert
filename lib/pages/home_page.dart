import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kbd_convert/modules/keyboard_translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // state
  bool _inputMasked = true;
  bool _outputMasked = true;

  final _inputCtrl = TextEditingController();
  final _outputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputCtrl.addListener(_handleInputChange);
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _outputCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            child: Column(children: [
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter text',
                icon: const Icon(Icons.abc),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _inputMasked = !_inputMasked;
                      });
                    },
                    icon: Icon(_inputMasked
                        ? Icons.visibility_off
                        : Icons.visibility))),
            obscureText: _inputMasked,
            controller: _inputCtrl,
            autofocus: true,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Get it converted',
              helperText: 'Tap to copy',
              icon: const Icon(Icons.language),
              suffixIcon: IconButton(
                  icon: Icon(
                      _outputMasked ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _outputMasked = !_outputMasked;
                    });
                  }),
            ),
            obscureText: _outputMasked,
            readOnly: true,
            controller: _outputCtrl,
            onTap: () {
              if (_outputCtrl.text.isNotEmpty) {
                Clipboard.setData(ClipboardData(text: _outputCtrl.text));
                _showToast(context, 'Copied to clipboard');
              }
            },
          )
        ])));
  }

  void _handleInputChange() {
    _outputCtrl.text = KeyboardTranslator.translate(_inputCtrl.text);
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
