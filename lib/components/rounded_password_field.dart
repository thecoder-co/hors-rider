import 'package:flutter/material.dart';
import 'package:rider/components/text_field_container.dart';
import 'package:rider/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? text;
  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.text = 'password',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        onSubmitted: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: text,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
