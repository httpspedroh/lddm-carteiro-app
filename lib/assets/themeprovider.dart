import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {

	ThemeMode _themeMode = ThemeMode.light;
	ThemeMode get themeMode => _themeMode;

	set themeMode(ThemeMode mode) {

		_themeMode = mode;
		notifyListeners();
	}
}