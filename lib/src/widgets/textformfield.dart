import 'package:flutter/material.dart';
import 'responsive_ui.dart';

double _width;
double _pixelRatio;
bool large;
bool medium;

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final onChanged;
  final enabled;
  final onEdit;
  final onSubmit;
  final validator;
  final inputFormatters;
  final autofocus;
  final initialValue;

  CustomTextField({
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.obscureText = false,
    this.onChanged,
    this.enabled,
    this.onEdit,
    this.onSubmit,
    this.validator,
    this.inputFormatters,
    this.autofocus,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
        enabled: enabled,
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Colors.orange[200],
        onChanged: onChanged,
        onEditingComplete: onEdit,
        onFieldSubmitted: onSubmit,
        validator: validator,
        inputFormatters: inputFormatters,
        focusNode: autofocus,
        initialValue: initialValue,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10.0),
            child: Icon(icon, color: Colors.orange[200], size: 20),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreenAccent, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreenAccent, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
