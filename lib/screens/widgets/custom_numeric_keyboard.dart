import 'package:flutter/material.dart';

class NumericKeypad extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final bool isSingleField;

  const NumericKeypad({
    super.key,
    required this.controllers,
    required this.focusNodes,
    this.isSingleField = false,
  });

  @override
  State<NumericKeypad> createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
            ],
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
            ],
          ),
          Row(
            children: [
              _buildButton('.'),
              _buildButton('0'),
              _buildButton('⌫', onPressed: _backspace),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {VoidCallback? onPressed}) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed ?? () => _input(text),
        style: TextButton.styleFrom(
            minimumSize: Size(60, MediaQuery.of(context).size.height * 0.083),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            splashFactory: NoSplash.splashFactory),
        child: Text(text,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Poppins')),
      ),
    );
  }

  void _input(String text) {
    if (widget.isSingleField) {
      _handleSingleFieldInput(text);
    } else {
      _handleMultiFieldInput(text);
    }
  }

  void _handleSingleFieldInput(String text) {
    if (text == "." && _containsDecimal(widget.controllers[0].text)) {
      return;
    }

    if (_hasTooManyDecimalPlaces(widget.controllers[0].text)) {
      return;
    }

    widget.controllers[0].text += text;
  }

  void _handleMultiFieldInput(String text) {
    for (int i = 0; i < widget.focusNodes.length; i++) {
      if (widget.focusNodes[i].hasFocus) {
        if (text == "." || _containsDecimal(widget.controllers[i].text)) {
          return;
        }

        if (_hasTooManyDecimalPlaces(widget.controllers[i].text)) {
          return;
        }

        widget.controllers[i].text += text;

        if (i < widget.focusNodes.length - 1) {
          widget.focusNodes[i].unfocus();
          FocusScope.of(context).requestFocus(widget.focusNodes[i + 1]);
        } else {
          widget.focusNodes[i].unfocus();
        }
        break;
      }
    }
  }

  bool _containsDecimal(String text) {
    return text.contains('.');
  }

  bool _hasTooManyDecimalPlaces(String text) {
    if (text.contains('.')) {
      String decimalPart = text.split('.').last;
      return decimalPart.length >= 2;
    }
    return false;
  }

  void _backspace() {
    if (widget.isSingleField) {
      final currentText = widget.controllers[0].text;
      if (currentText.isNotEmpty) {
        widget.controllers[0].text =
            currentText.substring(0, currentText.length - 1);
      }
    } else {
      for (int i = 0; i < widget.focusNodes.length; i++) {
        if (widget.focusNodes[i].hasFocus) {
          final currentText = widget.controllers[i].text;

          if (currentText.isNotEmpty) {
            widget.controllers[i].text =
                currentText.substring(0, currentText.length - 1);
          } else if (i > 0) {
            widget.focusNodes[i].unfocus();
            FocusScope.of(context).requestFocus(widget.focusNodes[i - 1]);

            final prevText = widget.controllers[i - 1].text;
            if (prevText.isNotEmpty) {
              widget.controllers[i - 1].text =
                  prevText.substring(0, prevText.length - 1);
            }
          }
          break;
        }
      }
    }
  }
}
