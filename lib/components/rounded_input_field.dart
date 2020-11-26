import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipsar_app/components/textfield_container.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    newText.clear();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1)
        selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3)
        selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6)
        selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10)
        selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
final _mobileFormatter = NumberTextInputFormatter();


class RoundedInputField extends StatelessWidget {
  final String hintText;

  final int exactLines;
  final ValueChanged<String> onChanged;
  final bool resizable;
  final double width;
  final TextInputType keyboard;
  final double maxHeight;
  final int maxCharacters;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.keyboard,
    this.onChanged,
    this.resizable = false,
    this.exactLines = 1,
    this.width = 0.8,
    this.maxHeight = 0.1,
    this.maxCharacters = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // h and w of screen
    return Container(
      width: size.width * width,
      child: TextFieldContainer(
        child: ConstrainedBox(

          constraints: BoxConstraints(

            maxHeight: size.height * maxHeight,
          ),
          child: TextField(
            keyboardType: keyboard,

            textInputAction: TextInputAction.next,
            inputFormatters: <TextInputFormatter>[
             //_mobileFormatter
            ],
            maxLines: resizable ? null : exactLines,
            onChanged: onChanged,
            decoration: InputDecoration(

              hintStyle: Theme.of(context).textTheme.headline2,

              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
