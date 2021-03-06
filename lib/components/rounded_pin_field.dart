import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lipsar_app/components/textfield_container.dart';
import 'package:lipsar_app/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

//var  pinFormatter = new MaskTextInputFormatter
  //(mask: '###-###', filter: { "#": RegExp(r'[0-9]') },initialText: "");

var   pinFormatter =  new MaskTextInputFormatter
  (mask: '###-###', filter: { "#": RegExp(r'[0-9]') });


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
   RoundedPinField({
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
      width: (size.width>300)?300:size.width*width,
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
              pinFormatter
            ],
            maxLines: resizable ? null : exactLines,
            onChanged: onChanged,

            decoration: InputDecoration(

              hintStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: constants.kPrimaryColor,
                fontSize: 18,
              ),

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
