import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipsar_app/components/textfield_container.dart';

class PinTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    String temp = newValue.text;
    bool isDeleted = (newTextLength-oldValue.text.length)<0;
    final StringBuffer newText = StringBuffer();

    if(newTextLength==3 && !isDeleted){
      temp = temp.substring(0,3)+"-"+temp.substring(3,temp.length);
    }
    if(newTextLength==3 && isDeleted){
      temp = temp.substring(0,2);
    }




    if(newTextLength<=7){
      newText.write(temp);
    }else{
      newText.write(oldValue.text);
    }


    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: temp.length),
    );
  }
}
final _mobileFormatter = PinTextInputFormatter();


class RoundedPinField extends StatelessWidget {
  final String hintText;

  final int exactLines;
  final ValueChanged<String> onChanged;
  final FocusNode next;
  final FocusNode current;
  final bool resizable;
  final double width;
  final TextInputType keyboard;
  final double maxHeight;
  final int maxCharacters;
  const RoundedPinField({
    Key key,
    this.hintText,
    this.next,
    this.current,
    this.keyboard,
    this.onChanged,
    this.resizable = false,
    this.exactLines = 1,
    this.width = 0.8,
    this.maxHeight = 0.1,
    this.maxCharacters = 18,
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
          child:
          TextFormField(

            keyboardType: keyboard,
            focusNode: current,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (term){
              _fieldFocusChange(context,current,next);
            },
            inputFormatters: <TextInputFormatter>[
              _mobileFormatter
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

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    if(nextFocus!=null){
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }else{

      currentFocus.unfocus();
    }
  }

}
