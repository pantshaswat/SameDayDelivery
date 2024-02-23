import 'package:flutter/material.dart';

class CustomTextFromField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final int maxlines;
  bool isPassword;
  CustomTextFromField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.maxlines = 1,
  });

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 50,
      child: TextFormField(
        cursorColor: Colors.black,
        maxLines: widget.maxlines,
        controller: widget.controller,
        obscureText: passwordVisible,
        obscuringCharacter: "*",
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  icon: Icon(
                    passwordVisible ? Icons.lock_outline : Icons.lock_open,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.label,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field Cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
