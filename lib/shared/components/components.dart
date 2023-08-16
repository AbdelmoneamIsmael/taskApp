import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Tffpdf() {
  Widget defaultFormField({
    required TextEditingController controller,
    required TextInputType type,
    Function(String)? onSubmit,
    Function(String?)? onChange,
    List<TextInputFormatter>? inputFormatters,
    VoidCallback? onTap,
    bool isPassword = false,
    String? Function(String?)? validate, //required
    required String label,
    IconData? prefix,
    IconData? suffix,
    FocusNode? focusNode,
    String? initialValue,
    VoidCallback? suffixPressed,
    bool isClickable = true,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: type,
        inputFormatters: inputFormatters,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        autofocus: false,
        onChanged: onChange,
        onTap: onTap,
        focusNode: focusNode,
        maxLines: 1,
        initialValue: initialValue,
        validator: validate,
        decoration: InputDecoration(
            // labelText: label,
            isDense: true,
            contentPadding:
                EdgeInsets.only(left: 20, top: 13, right: 20, bottom: 13),
            // prefixIcon: Icon(
            //   prefix,
            // ),
            labelText: label,
            hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.red,
                fontWeight: FontWeight.w100,
                fontFamily: 'DEXEF'),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(
                      suffix,
                    ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            )),
      );
}

Widget TFF(
        {required TextEditingController textEditingController,
        required Icon prefex,
        required TextInputType keybordlayout,
        String hintontext = "",
        String? Function(String?)? validate,
        Icon? sufx,
        bool secure = false,
        Function(String?)? onChange,
        Function(String?)? onsubmit,
        Function()? ontap,
        bool isclickable = true}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(241, 250, 238, 1),
      ),
      child: TextFormField(
        controller: textEditingController,
        validator: validate,
        decoration: InputDecoration(
          labelText: hintontext,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.red,
            fontWeight: FontWeight.w100,
          ),
          border: OutlineInputBorder(),
          prefixIcon: prefex,
          suffixIcon: sufx,
        ),
        enabled: isclickable,
        keyboardType: keybordlayout,
        obscureText: secure,
        onTap: ontap,
        onFieldSubmitted: onsubmit,
        onChanged: onChange,
      ),
    );
Widget BTN({
  required double width,
  required Color color,
  required String txt,
  double border = 0,
  Function()? action,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border),
        color: color,
      ),
      child: MaterialButton(
        onPressed: action,
        child: Text(
          txt,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

// title TEXT,data TEXT,time TEXT,status TEXT
Widget taskwidget(Map model) => Column(
      children: [
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 20, top: 20, end: 10),
              child: CircleAvatar(
                radius: 35,
                child: Text('${model['time']}'),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text('${model['data']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[300],
                        fontSize: 20,
                      )),
                ],
              ),
            ),
          ],
        ),

      ],
    );
