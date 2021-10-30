import 'package:flutter/material.dart';
import 'package:rider/components/text_field_container.dart';
import 'package:rider/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? text;
  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.text = 'password',
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool seen = true;
  @override
  Widget build(BuildContext context) {
    press() {
      if (seen == true) {
        setState(() {
          seen = false;
        });
      } else {
        setState(() {
          seen = true;
        });
      }
    }

    return TextFieldContainer(
      child: TextField(
        obscureText: seen,
        onChanged: widget.onChanged,
        onSubmitted: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.text,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                seen = seen ? false : true;
              });
            },
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
