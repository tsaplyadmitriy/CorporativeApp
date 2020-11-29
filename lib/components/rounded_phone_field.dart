import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipsar_app/components/textfield_container.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    String temp = newValue.text;
    bool isDeleted = (newTextLength-oldValue.text.length)<0;
    final StringBuffer newText = StringBuffer();
    if(newTextLength==1 && !isDeleted){

      temp = "8 ("+temp;
      selectionIndex+=3;
    }else{
    //  temp = temp.substring(2,temp.length);
    }

    newTextLength = selectionIndex;


    if(newTextLength==1 && isDeleted ){
      selectionIndex-=2;
      temp = temp.substring(1,temp.length);
    }
    print(selectionIndex.toString()+"/"+newTextLength.toString());
    if(newTextLength==6 && !isDeleted){
      temp = temp.substring(0,6)+") "+temp.substring(6,temp.length);
      selectionIndex+=2;
    }
    if(newTextLength==7 && isDeleted ){
      selectionIndex-=2;
      temp = temp.substring(0,5)+temp.substring(7,temp.length);
    }

    if(newTextLength==11 && !isDeleted){
      temp = temp.substring(0,11)+" "+temp.substring(11,temp.length);
      selectionIndex+=1;
    }
    if(newTextLength==10 && isDeleted){
      //selectionIndex-=1;
      temp = temp.substring(0,10)+temp.substring(11,temp.length);
    }
    if(newTextLength==12 && !isDeleted){
      temp = temp.substring(0,11)+" "+temp.substring(11,temp.length);
      selectionIndex+=1;
    }
    if(newTextLength==11 && isDeleted){
      selectionIndex-=1;
      temp = temp.substring(0,10)+temp.substring(11,temp.length);
    }
    if(newTextLength==14 && !isDeleted){
      temp = temp.substring(0,14)+" "+temp.substring(14,temp.length);
      selectionIndex+=1;
    }
    if(newTextLength==14 && isDeleted){
      selectionIndex-=1;
      temp = temp.substring(0,13)+temp.substring(14,temp.length);
    }
     //selectionIndex = newValue.selection.end;
    if(newTextLength==1 && !isDeleted ){

      temp = temp.substring(0,1)+" "+temp.substring(1,temp.length);
    }
    print("temp"+temp);

    if(newValue.text.length<=17){
      newText.write(temp);
    }else{
      newText.write(oldValue.text);
    }

    print("select"+selectionIndex.toString());
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: (!isDeleted)?selectionIndex:selectionIndex),
    );
  }
}
final _mobileFormatter = NumberTextInputFormatter();


class RoundedPhoneField extends StatelessWidget {
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
  const RoundedPhoneField({
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
