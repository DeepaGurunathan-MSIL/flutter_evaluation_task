import 'package:flutter/material.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final Function callBack;
  const OtpInput(this.controller,this.callBack, this.autoFocus,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 35,
      width: 50,
      child: Center(
        child: TextField(
          textInputAction: TextInputAction.done,
          onSubmitted: (value){
            callBack.call();
          },
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: controller,
          maxLength: 1,
          cursorColor: Colors.blueAccent,
          decoration:  InputDecoration(
            focusedBorder:const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            enabledBorder:const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            fillColor: Colors.grey.shade300,
              filled: true,
              counterText: '',
              hintStyle: const TextStyle(color: Colors.black, fontSize: 20.0)),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}