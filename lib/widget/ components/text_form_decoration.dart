import 'package:flutter/material.dart';

InputDecoration textFormDecoration(String action) {
    return InputDecoration(
                    filled: false,
                    fillColor: Colors.white.withOpacity(0.2),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFB95D6D)),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFB95D6D)),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF272727)),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF272727)),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF272727),
                        width: 1.5,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: "Введите $action",
                    isDense: true,
                  );
  }
