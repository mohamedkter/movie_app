
import 'package:flutter/material.dart';


class CustomAuthPasswordInputField extends StatefulWidget {
  final String  label;
  final TextEditingController? controller;
  final String hintText;
  const CustomAuthPasswordInputField({
    super.key, required this.label, this.controller, required this.hintText,
  });

  @override
  State<CustomAuthPasswordInputField> createState() => _CustomAuthPasswordInputFieldState();
}

class _CustomAuthPasswordInputFieldState extends State<CustomAuthPasswordInputField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: widget.controller,
            obscureText: _isObscured,
            obscuringCharacter: '*',
            
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Theme.of(context).colorScheme.primary
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
              filled: true,
              fillColor:
                  Theme.of(context).inputDecorationTheme.fillColor,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


